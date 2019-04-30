//
//  CMHotApplyListView.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMHotApplyListView.h"
#import "CMHotApplyCell.h"
#import "CMConcessionDetailController.h"
#import "CMApplyNoDataView.h"
#import "CMHotApplyModel.h"
#import "CMConsultController.h"
#import "CMHangtagApplyController.h"
@interface CMHotApplyListView()<UITableViewDataSource,UITableViewDelegate,CMApplyNoDataViewDelegate,CMHotApplyCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property(nonatomic,strong)CMApplyNoDataView *dataView;
@property (strong, nonatomic) NSMutableArray *noticDataArr;
@property(nonatomic,assign)NSInteger pageIndex;
@end
@implementation CMHotApplyListView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _curTableView.delegate=self;
    _curTableView.dataSource=self;
    
//    CMApplyNoDataView *dataView= [CMApplyNoDataView initByNibForClassName];
//    [dataView updateNoDataImage:@"applyNoDataImage_03" andnoDataTitle:@"暂无承销项目" withApplyString:@"申请承销"];
    [self addSubview:self.dataView];
     self.dataView.delegate=self;
    [self addRequestDataMeans];
}

- (void)addRequestDataMeans {
    //显示菊花
    [self resetData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self resetData];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
        [self LoadDataWithPageIndex:self.pageIndex++];
    }];
    
    
}

-(void)resetData{
    
    self.pageIndex=1;
    [self LoadDataWithPageIndex:self.pageIndex];
}
- (NSMutableArray *)noticDataArr {
    if (!_noticDataArr) {
        _noticDataArr = [NSMutableArray arrayWithCapacity:0];
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
    CMHotApplyCell  *applyListCell=[tableView  dequeueReusableCellWithIdentifier:@"CMHotApplyCell"];
    if(!applyListCell){
        applyListCell=[CMHotApplyCell  initByNibForClassName];
    }
   if (self.noticDataArr.count>0) {
    applyListCell.HotApplyModel=self.noticDataArr[indexPath.row];
       applyListCell.delegate=self;
   }
    return applyListCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CMConcessionDetailController *ConcessionDetail=(CMConcessionDetailController*)[CMConcessionDetailController initByStoryboard];
//    CMHotApplyModel *apply=self.noticDataArr[indexPath.row];
//    ConcessionDetail.newType=CMMyApplyDetail;
//    ConcessionDetail.productZid=apply.cpid;
//    [_UnderwritingListController.navigationController  pushViewController:ConcessionDetail animated:YES];
    CMHotApplyModel *apply=self.noticDataArr[indexPath.row];
    
    //进入m站产品详情
   CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Products/Detail?pid=%@",apply.cpid]);
    commWebVC.urlStr = webUrl;
    commWebVC.ProductId=[apply.cpid integerValue];
  [_UnderwritingListController.navigationController pushViewController:commWebVC animated:YES];
    
}
-(void)LoadDataWithPageIndex:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"pageSize":@"5",@"pageIndex":CMStringWithFormat(index)};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetOtherHotChengXiaoProduct" andMessage:messageDict success:^(id responseObj) {
          // MyLog(@"其他热门承销项目+++%ld+++%@",index,responseObj);
        
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTableView endRefresh];
            if(index==1){
                
                [self.noticDataArr removeAllObjects];
            }
            
            

            index>[[responseObj objectForKey:@"pageCount"]integerValue]?  [_curTableView noMoreData]:[_curTableView resetNoMoreData];
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                _curTableView.hidden=NO;
                self.dataView.hidden=YES;
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
              
                if (tmp) {
                 
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                            CMHotApplyModel *apply=[CMHotApplyModel yy_modelWithDictionary:dict];
                            [self.noticDataArr addObject:apply];
                            
                        }
                    
                       
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_curTableView noMoreData];
                    
                }
            }else{
                
            //没数据
                _curTableView.hidden=YES;
                self.dataView.hidden=NO;
                
            }
                
                 [_curTableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
    
    
}

#pragma mark 代理
-(void)applyEvent{
    
    CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
    consultController.type=ApplyProject;
    consultController.pid=@"";
    [_UnderwritingListController.navigationController pushViewController:consultController animated:YES];
    
    
}
-(void)applyChengXiaoEventWith:(NSString *)pid{
    
 // CMHangtagApplyController *HangtagApply=(CMHangtagApplyController*)[CMHangtagApplyController initByStoryboard];
    
   // [_UnderwritingListController.navigationController pushViewController:HangtagApply animated:YES];
    CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
    consultController.type=ApplyProject;
    consultController.pid=pid;
    [_UnderwritingListController.navigationController pushViewController:consultController animated:YES];
}
@end
