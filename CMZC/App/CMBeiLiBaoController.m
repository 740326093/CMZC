//
//  CMBeiLiBaoController.m
//  CMZC
//
//  Created by WangWei on 17/3/2.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMBeiLiBaoController.h"
#import "CMBLBProductCell.h"
#import "CMBarHeadView.h"
#import "CMSafeKeepView.h"
#import "CMLiuCheng.h"
#import "CMTouCeView.h"
#import "CMIntrouctionView.h"
@interface CMBeiLiBaoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *currentTableView;

@end

@implementation CMBeiLiBaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   

    self.title=@"倍利宝";
    [self requestProductList];
}

#pragma mark 请求产品
-(void)requestProductList{
    [self showDefaultProgressHUD];
    [self requestData];
     _currentTableView.hidden = YES;
     _currentTableView.tableHeaderView=[CMBarHeadView barHeadViewWithImage:@"BLBHead@2x"];
    _currentTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    //添加下拉刷新
   [_currentTableView addHeaderWithFinishBlock:^{
    [self requestData];
    }];

  
    
}
-(void)requestData{
    [CMRequestAPI cm_homeFetchProductFundlistPageSize:3 success:^(NSArray *fundlistArr) {
        [self hiddenProgressHUD];
         _currentTableView.hidden = NO;
        [_currentTableView endRefresh];
        [self.dataArr removeAllObjects];
      
        [self.dataArr addObjectsFromArray:fundlistArr];
        
       
        [_currentTableView reloadData];//结束刷新
    } fail:^(NSError *error) {
        MyLog(@"产品请求失败");
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
    
}
#pragma mark Lazy
-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5+self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
      view.tintColor = [UIColor clmHex:0xbbbbbb];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellID=@"indexPath";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text=@"倍利宝是新经板推出的类基金产品,顶级专业机构管理,只投优选10倍股,收益有保底,每年保证分红,预期最高可达十倍收益,开放净值型,本金安全有保证,信息披露及时,是资本市场的明星产品。";
        cell.textLabel.font=[UIFont systemFontOfSize:14.0];
        cell.textLabel.numberOfLines=0;
        return cell;
    }else if (indexPath.section==self.dataArr.count+1){
        static NSString *cellID=@"CMSafeKeepView";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        CMSafeKeepView *safe=[[CMSafeKeepView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 300)];
        [cell addSubview:safe];
        return cell;
        
        
    }
    else if (indexPath.section==self.dataArr.count+2){
        static NSString *cellID=@"CMTouCeView";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        CMTouCeView *safe=[[CMTouCeView alloc]initWithFrame:cell.frame];
        
        [cell addSubview:safe];
        return cell;
        
        
    }
    else if (indexPath.section==self.dataArr.count+3){
        static NSString *cellID=@"CMLiuCheng";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        CMLiuCheng *safe=[[CMLiuCheng alloc]initWithFrame:cell.frame];
     
        [cell addSubview:safe];
        return cell;
        
        
    }
    else if (indexPath.section==self.dataArr.count+4){
        static NSString *cellID=@"CMIntrouctionView";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        CMIntrouctionView *safe=[[CMIntrouctionView alloc]initWithFrame:cell.frame];
        
        [cell addSubview:safe];
        return cell;
        
        
    }
    
    
    else{
        static NSString *BLbID=@"CMBLBProductCell";
        CMBLBProductCell *cell=[tableView dequeueReusableCellWithIdentifier:BLbID];
        if (!cell) {
            cell=[[CMBLBProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BLbID];
            
        }
        cell.Numberous=self.dataArr[indexPath.section-1];
        cell.Index=indexPath;
    
        cell.buyInBlock=^(NSIndexPath *index){
            CMNumberous *Numberous=self.dataArr[index.section-1];
            CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
            NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Invest/Confirm?pid=%@&pcont=1",Numberous.berId]);
            webVC.urlStr = webUrl;
            [self.navigationController pushViewController:webVC animated:YES];
            
        };
       
        return cell;
        
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==0||indexPath.section==self.dataArr.count+1||indexPath.section==self.dataArr.count+2||indexPath.section ==self.dataArr.count+3||indexPath.section==self.dataArr.count+4) {
       
    }else{
        CMNumberous *Numberous=self.dataArr[indexPath.section-1];
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Products/Detail?pid=%@",Numberous.berId]);
        webVC.urlStr = webUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
           return 100;
    }else if (indexPath.section==self.dataArr.count+1){
        return 420;
    }
    else if (indexPath.section==self.dataArr.count+2){
        return 120;
    }
    else if (indexPath.section==self.dataArr.count+4){
        return 500;
    }
    else{
        return 170;

    }
 
    
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
