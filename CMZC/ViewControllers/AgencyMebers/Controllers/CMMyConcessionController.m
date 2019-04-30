//
//  CMMyConcessionController.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMyConcessionController.h"
#import "CMMyConcessionHeadView.h"
#import "CMMyConcessionCell.h"
#import "CMConcessionDetailController.h"
#import "CMYongJingHeadModel.h"
#import "CMYongJinListModel.h"
@interface CMMyConcessionController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property(nonatomic,strong)CMMyConcessionHeadView  *MyConcessionHead;
@property (strong, nonatomic) NSMutableArray *noticDataArr;
@property(nonatomic,assign)NSInteger pageIndex;
@end

@implementation CMMyConcessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout =UIRectEdgeNone;
        
    }
    _curTableView.dataSource=self;
    _curTableView.delegate=self;
    [self loadTopData];
    _MyConcessionHead=[CMMyConcessionHeadView initByNibForClassName];
    
    _curTableView.tableHeaderView=_MyConcessionHead;
    [self loadYongJinDetail];
}


-(void)loadYongJinDetail{
    
    [self resetCXData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self resetCXData];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
        [self loadListDataWithPage:++self.pageIndex];
    }];
    
}

-(void)resetCXData{
    
    self.pageIndex=1;
    [self loadListDataWithPage:self.pageIndex];
}
- (NSMutableArray *)noticDataArr {
    if (!_noticDataArr) {
        _noticDataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _noticDataArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticDataArr.count;
    //return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMMyConcessionCell  *applyListCell=[tableView  dequeueReusableCellWithIdentifier:@"MyConcessionCell"];
    if(!applyListCell){
        applyListCell=[CMMyConcessionCell  initByNibForClassName];
    }
    if (self.noticDataArr.count>0) {
        applyListCell.YongJinListModel=self.noticDataArr[indexPath.row];
    }
    return applyListCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMYongJinListModel *listModel=self.noticDataArr[indexPath.row];;
    
    CMConcessionDetailController *ConcessionDetail=(CMConcessionDetailController*)[CMConcessionDetailController initByStoryboard];
    ConcessionDetail.newType=CMMyConcessionDetail;
    ConcessionDetail.productZid=listModel.zid;
    [self.navigationController  pushViewController:ConcessionDetail animated:YES];
    
}

#pragma mark 加载佣金头部信息
-(void)loadTopData{
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_MyYongJin_Info" andMessage:messageDict success:^(id responseObj) {
      MyLog(@"我的佣金信息+++%@+++%@",responseObj,[responseObj objectForKey:@"respDesc"]);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            
            _MyConcessionHead.yongjinModel=[CMYongJingHeadModel yy_modelWithJSON:[responseObj objectForKey:@"data"]];
        }
        
    } failure:^(NSError *error) {
        
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
    
}
#pragma mark 加载承销详情列表
-(void)loadListDataWithPage:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"pageIndex":CMStringWithFormat(index),@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_MyYongJin_List" andMessage:messageDict success:^(id responseObj) {
        
         MyLog(@"融金列表+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTableView endRefresh];
            if(index==1){
                [self.noticDataArr removeAllObjects];
            }
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTableView noMoreData]:[_curTableView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
               
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                            CMYongJinListModel *yongJinLst=[CMYongJinListModel yy_modelWithDictionary:dict];
                            [self.noticDataArr addObject:yongJinLst];
                            
                        }
                        
                        
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_curTableView noMoreData];
                    
                }
            }else{
                
                
                
                
            }
            
            [_curTableView reloadData];
            
        }
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
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
