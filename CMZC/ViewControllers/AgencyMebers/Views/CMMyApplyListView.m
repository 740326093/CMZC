//
//  CMMyApplyListView.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMyApplyListView.h"
#import "CMApplyListCell.h"
#import "CMConcessionDetailController.h"
#import "CMApplyNoDataView.h"
#import "CMApplyModel.h"
#import "CMConsultController.h"
#import "CMShareView.h"
@interface CMMyApplyListView()<UITableViewDelegate,UITableViewDataSource,CMApplyNoDataViewDelegate,CMApplyListCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cureTableView;
@property(nonatomic,strong)CMApplyNoDataView *dataView;
@property (strong, nonatomic) NSMutableArray *noticDataArr;
@property (assign, nonatomic) NSInteger pageIndex;
@end
@implementation CMMyApplyListView

-(void)awakeFromNib{
    [super awakeFromNib];
    _cureTableView.delegate=self;
    _cureTableView.dataSource=self;
    
// CMApplyNoDataView *dataView= [CMApplyNoDataView initByNibForClassName];
//    [dataView updateNoDataImage:@"applyNoDataImage_03" andnoDataTitle:@"暂无承销项目" withApplyString:@"申请承销"];
//    [self addSubview:dataView];
    [self addSubview:self.dataView];
    self.dataView.delegate=self;
    [self addRequestDataMeans];
    
}

- (void)addRequestDataMeans {

     [self resetData];
    //添加下拉刷新
    [_cureTableView addHeaderWithFinishBlock:^{
        [self resetData];
    }];
    //添加上提加载
    [_cureTableView addFooterWithFinishBlock:^{
       
        [self LoadDataWithPageIndex:++self.pageIndex];
    }];
    
    
}
-(void)resetData{
    self.pageIndex=1;
    [self LoadDataWithPageIndex:self.pageIndex];
}
- (NSMutableArray *)noticDataArr {
    if (!_noticDataArr) {
        _noticDataArr = [NSMutableArray array];
    }
    return _noticDataArr;
}
-(CMApplyNoDataView*)dataView{
    if (!_dataView) {
        _dataView= [CMApplyNoDataView initByNibForClassName];
        [_dataView updateNoDataImage:@"applyNoDataImage_03" andnoDataTitle:@"暂无承销项目" withApplyString:@"申请承销"];
        
    }
    
    return _dataView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMApplyListCell  *applyListCell=[tableView  dequeueReusableCellWithIdentifier:@"ApplyListCell"];
    if(!applyListCell){
        applyListCell=[CMApplyListCell  initByNibForClassName];
    }
    
    if (self.noticDataArr.count>0) {
        applyListCell.applyModel=self.noticDataArr[indexPath.row];
        applyListCell.type=2;
        applyListCell.delegate=self;
    }
    return applyListCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMConcessionDetailController *ConcessionDetail=(CMConcessionDetailController*)[CMConcessionDetailController initByStoryboard];
    CMApplyModel *apply=self.noticDataArr[indexPath.row];
    ConcessionDetail.productZid=apply.zid;
    ConcessionDetail.newType=CMMyApplyDetail;
    [_ListController.navigationController  pushViewController:ConcessionDetail animated:YES];
}

-(void)LoadDataWithPageIndex:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"pageSize":@"5",@"pageIndex":CMStringWithFormat(index)};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetChengXiaoList" andMessage:messageDict success:^(id responseObj) {
        
        MyLog(@"我承销项目+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
             [_cureTableView endRefresh];
            if(index==1){
                
                [self.noticDataArr removeAllObjects];
            }
          
            
       index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_cureTableView noMoreData]:[_cureTableView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                _cureTableView.hidden=NO;
                self.dataView.hidden=YES;
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                        
                                CMApplyModel *apply=[CMApplyModel yy_modelWithDictionary:dict];
                                [self.noticDataArr addObject:apply];
                          
                        }
                       
                        //self.noticDataArr.count<5?[_cureTableView noMoreData]:[_cureTableView resetNoMoreData];
                        
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_cureTableView noMoreData];
                   
                }
            }else{
                
                //没数据
                _cureTableView.hidden=YES;
                self.dataView.hidden=NO;
                
            }
            
            [_cureTableView reloadData];
            
        }
        
            
        
        
        
        
    } failure:^(NSError *error) {
        
        [_cureTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
    
    
}

#pragma mark 代理
-(void)applyEvent{
    
    CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
    consultController.type=ApplyProject;
    consultController.pid=@"";
    [_ListController.navigationController pushViewController:consultController animated:YES];
    
    
}
-(void)ApplyShareEventWith:(CMApplyModel *)model{
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    shareView.center = window.center;
    shareView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    shareView.contentUrl =[NSString stringWithFormat:@"%@/Products/Detail?pid=%@&cxid=%@",kCMMZWeb_url,model.cpId,model.zid];
    shareView.titleConten = [NSString stringWithFormat:@"%@向您推荐%@",(NSString*)GetDataFromNSUserDefaults(@"OrgJianCheng"),model.cpName];
   shareView.controller=_ListController;
   NSString *content = [NSString stringWithFormat:@"本产品由%@领投,预期收益%@%%,保荐人推荐,百分百中签,赶快来加入吧!",model.LingTouOrgName,model.yq_nlv];
   shareView.contentStr = content;
   shareView.ShareImageName=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.cpPic]];
    [window addSubview:shareView];
    
    
}
@end
