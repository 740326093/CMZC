//
//  CMMessageViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/25.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMMessageViewController.h"
#import "CMMessageTableViewCell.h"


@interface CMMessageViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray     *_dataArr;
    
}

@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  [CMMessageDao createTable];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[CMDataMessage getFilePath]]) {
        
        _dataArr=[CMMessageDao selectAllMessage];
    
    }

//    if (_dataArr.count>0) {
//        _bgView.hidden = YES;
//        UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightBarBtn.frame = CGRectMake(0, 0, 80, 40);
//        [rightBarBtn setTitle:@"清除消息" forState:UIControlStateNormal];
//        [rightBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        rightBarBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
//        [rightBarBtn addTarget:self action:@selector(clearAllMessage) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
//        self.navigationItem.rightBarButtonItem = rightItem;
//
//        _curTableView.hidden=NO;
//
//    } else {
//
//
//        _bgView.hidden = NO;
//    }

    [self loadData];
}

-(void)clearAllMessage{
    
    [CMMessageDao deleteAllMessage];
    [_dataArr removeAllObjects];
    
    _bgView.hidden = NO;
    _curTableView.hidden=YES;
    [_curTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  CMMessage *messge=_dataArr[indexPath.row];
  //  CGFloat height = [messge.message getHeightIncomingWidth:CMScreen_width() -66-18 incomingFont:14];
    
    //return 70-14+height;
    
    
    CMMessage *tMessage=_dataArr[indexPath.row];
    CGRect rect=[tMessage.message boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.0]} context:nil];
    return rect.size.height+100;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CMMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"CMMessageTableViewCell" forIndexPath:indexPath];
//    CMMessage *messge=_dataArr[indexPath.row];
//    messageCell.titleNameStr = messge.message;
//    return messageCell;
    
    
    static NSString *cellId=@"indexPath";
    
    CMMessageTableViewCell *messageCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!messageCell) {
        messageCell=[[CMMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        messageCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    CMMessage *messge=_dataArr[indexPath.row];
    messageCell.messageModel=messge;
    return messageCell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CMMessage *message=_dataArr[indexPath.row];
    message.isread=0;
    [CMMessageDao setNoReadBecomeIsRead:@"0"andBtnTag:message.messageId];
    if (message.url!=nil) {
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        webVC.urlStr=message.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    self.block();
    [_curTableView reloadData];
}
-(void)loadData{
    [CMRequestAPI cm_appMessageSuccess:^(NSArray *dataArray) {
        MyLog(@"消息+++%@",dataArray);
        [_dataArr addObjectsFromArray:dataArray];
        
     
        [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CMMessage *model=(CMMessage*)obj;
            
            model.messageId=(int)idx;
            //model.isread=1;
        }];
        
        [_dataArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            CMMessage *pModel1 = obj1;
            CMMessage *pModel2 = obj2;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            NSDate *date1= [dateFormatter dateFromString:pModel1.time];
            NSDate *date2= [dateFormatter dateFromString:pModel2.time];
            if (date1 != [date1 earlierDate: date2]) { //不使用intValue比较无效
                
                return NSOrderedAscending;//降序
                
            }else if (date1 != [date1 laterDate: date2]) {
                return NSOrderedDescending;//升序
                
            }else{
                return NSOrderedSame;//相等
            }
            
            
        }];
        
        
        
        if (_dataArr.count>0) {
            _bgView.hidden = YES;
            UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBarBtn.frame = CGRectMake(0, 0, 80, 40);
            [rightBarBtn setTitle:@"清除消息" forState:UIControlStateNormal];
            [rightBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightBarBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
            [rightBarBtn addTarget:self action:@selector(clearAllMessage) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            
            _curTableView.hidden=NO;
            
        } else {
            
            
            _bgView.hidden = NO;
        }
        [_curTableView reloadData];
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end




























