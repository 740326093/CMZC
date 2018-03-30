//
//  CMBeiLiBaoController.m
//  CMZC
//
//  Created by WangWei on 17/3/2.
//  Copyright © 2017年 MAC. All rights reserved.
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
    
    CMIntrouctionView *footView=[[CMIntrouctionView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), f_i5real(300))];
  
    _currentTableView.tableFooterView=footView;
 
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
    
    return 4+self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
      view.tintColor = [UIColor clmHex:0xEFEFF4];
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
     view.tintColor = [UIColor clmHex:0xEFEFF4];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section==0) {
        static NSString *cellID=@"indexPath";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
       
                cell.textLabel.text=@"倍利宝是新经板推出的类基金产品,顶级专业机构管理,只投优选10倍股,收益有保障,每年保证分红,预期最高可达十倍收益,开放净值型,本金安全有保证,信息披露及时,是资本市场的明星产品。";
                cell.textLabel.font=[UIFont systemFontOfSize:14.0];
                cell.textLabel.textColor=[UIColor clmHex:0x333333];
                cell.textLabel.numberOfLines=0;
     
        return cell;
    }
   
    else if (indexPath.section==self.dataArr.count+1){
        static NSString *SafeKeep=@"CMSafeKeepView";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SafeKeep ];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SafeKeep];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            CMSafeKeepView *safe=[[CMSafeKeepView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 300)];
            [cell addSubview:safe];
        }
        
        
        return cell;
        
        
    }
    else if (indexPath.section==self.dataArr.count+2){
        static NSString *TouCe=@"CMTouCeView";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TouCe];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TouCe];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            CMTouCeView *safe=[[CMTouCeView alloc]initWithFrame:cell.frame];
            
            [cell addSubview:safe];
        }
        
       
        return cell;
        
        
    }
    else if (indexPath.section==self.dataArr.count+3){
        static NSString *LiuCheng=@"CMLiuCheng";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LiuCheng];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LiuCheng];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        CMLiuCheng *safe=[[CMLiuCheng alloc]initWithFrame:cell.frame];
     
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
            NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Invest/Confirm?pid=%@&pcont=1",Numberous.berId]);
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
        NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Products/Detail?pid=%@",Numberous.berId]);
        webVC.urlStr = webUrl;
        webVC.ProductId=[Numberous.berId integerValue];
        webVC.showRefresh=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
           return 100;
    }else if (indexPath.section==self.dataArr.count+1){
        return 440;
    }
    else if (indexPath.section==self.dataArr.count+2){
        return 150;
    }
    else{
        return 220;

    }
 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.dataArr.count+3) {
        return 10;
    }else{
        return 0.01;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[self.currentTableView class]]) {

    CGFloat sectionHeaderHeight = 20; //sectionHeaderHeight
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
        
        
        
   
    }
    

    
}



@end
