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
  
    if (_dataArr.count == 0) {
        _bgView.hidden = NO;
     
    } else {
        
    
        _bgView.hidden = YES;
    }
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMessage *messge=_dataArr[indexPath.row];
    CGFloat height = [messge.message getHeightIncomingWidth:CMScreen_width() -66-18 incomingFont:14];
    
    return 70-14+height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"CMMessageTableViewCell" forIndexPath:indexPath];
    CMMessage *messge=_dataArr[indexPath.row];
    messageCell.titleNameStr = messge.message;
    return messageCell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    CMMessage *message=_dataArr[indexPath.row];
    
    [CMMessageDao setNoReadBecomeIsRead:@"0"andBtnTag:message.messageId];
    
    if (message.url!=nil) {
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        webVC.urlStr=message.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    self.block();
    
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




























