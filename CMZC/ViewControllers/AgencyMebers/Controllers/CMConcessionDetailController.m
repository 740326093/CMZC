//
//  CMConcessionDetailController.m
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMConcessionDetailController.h"
#import "CMConcessionDetailCell.h"
#import "CMCSDetailListModel.h"
#import "CMConcessionHeadView.h"
#import "CMApplyModel.h"
#import "CMYongJinListModel.h"
#import "CMYongJinDetailListModel.h"
#import "CMRongZiDetailTopModel.h"
#import "CMRongZiDetailList.h"
@interface CMConcessionDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTabLeView;
@property (strong, nonatomic) NSMutableArray *noticDataArr;
@property(nonatomic,assign)NSInteger pageIndex;
@property (strong, nonatomic) CMConcessionHeadView  *concessionView;
@end

@implementation CMConcessionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curTabLeView.delegate=self;
    _curTabLeView.dataSource=self;
    _curTabLeView.estimatedSectionHeaderHeight=0;
    switch (_newType) {
    case CMMyApplyDetail:
        self.title=@"承销详情";
            [self loadCxDetail];
            [self loadChengXiaoTopData];
        break;
    case CMMyConcessionDetail:
        self.title=@"佣金明细";
       [self loadYongjinTopMessage];
       [self loadYongJinDetail];
        break;
    case CMFinancingDetail:
        self.title=@"融资详情";
            DeleteDataFromNSUserDefaults(@"ltOrgHyid");
        [self  loadRongZiTopData];
            [self loadRongZiDetail];
        break;
        
    default:
        break;
    }
   
    _concessionView=[CMConcessionHeadView  initByNibForClassName];
    _concessionView.newType=_newType;
    _curTabLeView.tableHeaderView=_concessionView;

    
}
#pragma mark 承销详情列表
-(void)loadCxDetail{
    
    [self resetCXData];
    //添加下拉刷新
    [_curTabLeView addHeaderWithFinishBlock:^{
        [self resetCXData];
    }];
    //添加上提加载
    [_curTabLeView addFooterWithFinishBlock:^{
        
        [self loadListDataWithPage:++self.pageIndex];
    }];
    
}
-(void)resetCXData{
    
    self.pageIndex=1;
    [self loadListDataWithPage:self.pageIndex];
}

#pragma mark 佣金列表
-(void)loadYongJinDetail{
    
    [self resetYongJinData];
    //添加下拉刷新
    [_curTabLeView addHeaderWithFinishBlock:^{
        [self resetYongJinData];
    }];
    //添加上提加载
    [_curTabLeView addFooterWithFinishBlock:^{
      [self loadYongJinListDataWithPage:++self.pageIndex];
    }];
    
}
-(void)resetYongJinData{
    
    self.pageIndex=1;
    [self loadYongJinListDataWithPage:self.pageIndex];
}
#pragma mark 融资详情列表
-(void)loadRongZiDetail{
    
 //   [self resetRongziData];
    //添加下拉刷新
    [_curTabLeView addHeaderWithFinishBlock:^{
        [self resetRongziData];
    }];
    //添加上提加载
    [_curTabLeView addFooterWithFinishBlock:^{
        if(GetDataFromNSUserDefaults(@"ltOrgHyid")){
        [self loadRongZiListDataWithPage:++self.pageIndex andHyid:(NSString*) GetDataFromNSUserDefaults(@"ltOrgHyid")];
    }
    }];
    
}

-(void)resetRongziData{
    self.pageIndex=1;
    if(GetDataFromNSUserDefaults(@"ltOrgHyid")){
     [self loadRongZiListDataWithPage:self.pageIndex andHyid:(NSString*)GetDataFromNSUserDefaults(@"ltOrgHyid")];
    }
}
- (NSMutableArray *)noticDataArr {
    if (!_noticDataArr) {
        _noticDataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _noticDataArr;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.noticDataArr.count;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMConcessionDetailCell *ConcessionDetailCell=[tableView  dequeueReusableCellWithIdentifier:@"ConcessionDetailCell" forIndexPath:indexPath];
    ConcessionDetailCell.newType=_newType;
    if (self.noticDataArr.count>0) {
        switch (_newType) {
            case CMMyApplyDetail:
            ConcessionDetailCell.listMode=self.noticDataArr[indexPath.row];
                break;
            case CMMyConcessionDetail:
           ConcessionDetailCell.YongJinDetailListModel=self.noticDataArr[indexPath.row];
                break;
            case CMFinancingDetail:
          ConcessionDetailCell.RongZiDetailList=self.noticDataArr[indexPath.row];
                break;
                
            default:
                break;
        }
        
    }
    return ConcessionDetailCell;
}
#pragma mark 加载承销头部信息
-(void)loadChengXiaoTopData{
    NSDictionary *messageDict=@{@"zid":_productZid};
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetChengXiaoDetailProductInfo" andMessage:messageDict success:^(id responseObj) {
        //MyLog(@"头部信息+++%@+++%@",responseObj,[responseObj objectForKey:@"respDesc"]);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            
       CMApplyModel *applyModel=[CMApplyModel  yy_modelWithJSON:responseObj[@"data"]];
        _concessionView.ApplyModel=applyModel;
            
        }
        
    } failure:^(NSError *error) {
        
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];

}
#pragma mark 加载承销详情列表
-(void)loadListDataWithPage:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"pageIndex":CMStringWithFormat(index),@"zid":_productZid};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetChengXiaoDetailShenGouList" andMessage:messageDict success:^(id responseObj) {
        
      //  MyLog(@"承销详情列表+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTabLeView endRefresh];
            if(index==1){
                [self.noticDataArr removeAllObjects];
            }
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTabLeView noMoreData]:[_curTabLeView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                if (tmp) {
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *dict in tmp) {
                            CMCSDetailListModel  *lismodel=[CMCSDetailListModel yy_modelWithDictionary:dict];
                            [self.noticDataArr addObject:lismodel];
                        }
                        
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_curTabLeView noMoreData];
                }
            }else{
                
               
             
                
            }
            
            [_curTabLeView reloadData];
            
        }
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
    
    }];
    
}
#pragma mark 佣金头部信息

-(void)loadYongjinTopMessage{
    
    NSDictionary *messageDict=@{@"zid":_productZid,@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_MyProductYongJin_Info" andMessage:messageDict success:^(id responseObj) {
       // MyLog(@"佣金详情头部信息+++%@+++%@",responseObj,[responseObj objectForKey:@"respDesc"]);
        
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            
            CMYongJinListModel *applyModel=[CMYongJinListModel  yy_modelWithJSON:responseObj[@"data"]];
            _concessionView.YongJinListModel=applyModel;
            
            
        }
        
    } failure:^(NSError *error) {
        
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];

    
    
}
#pragma mark 佣金列表
-(void)loadYongJinListDataWithPage:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"pageIndex":CMStringWithFormat(index),
                                @"zid":_productZid,
                                @"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")
                                };
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_MyProductYongJin_List" andMessage:messageDict success:^(id responseObj) {
        
        //  MyLog(@"承销详情列表+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTabLeView endRefresh];
            if(index==1){
                [self.noticDataArr removeAllObjects];
            }
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTabLeView noMoreData]:[_curTabLeView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                            CMYongJinDetailListModel  *lismodel=[CMYongJinDetailListModel yy_modelWithDictionary:dict];
                            [self.noticDataArr addObject:lismodel];
                            
                        }
                        
                        
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_curTabLeView noMoreData];
                    
                }
            }else{
                
                
                
                
            }
            
            [_curTabLeView reloadData];
            
        }
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}






#pragma mark 加载融资头部信息
-(void)loadRongZiTopData{
    NSDictionary *messageDict=@{@"pid":_productZid};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_Product_Info" andMessage:messageDict success:^(id responseObj) {
        //MyLog(@"头部信息+++%@+++%@",responseObj,[responseObj objectForKey:@"respDesc"]);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            
            CMRongZiDetailTopModel *ZiDetailTopModel=[CMRongZiDetailTopModel  yy_modelWithJSON:responseObj[@"data"]];
            _concessionView.RongZiDetailTopModel=ZiDetailTopModel;
            SaveDataToNSUserDefaults(ZiDetailTopModel.ltOrgHyid, @"ltOrgHyid");
            
            [self loadRongZiListDataWithPage:1 andHyid:ZiDetailTopModel.ltOrgHyid];
        }
        
    } failure:^(NSError *error) {
        
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
    
}

#pragma mark 融资详情列表
-(void)loadRongZiListDataWithPage:(NSInteger)index andHyid:(NSString*)hyid{
    
 
    NSDictionary *messageDict=@{@"pageIndex":CMStringWithFormat(index),
                                @"pid":_productZid,
                                @"ltOrgHyId":hyid
                                };
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_Product_ShenGouList" andMessage:messageDict success:^(id responseObj) {
        
        MyLog(@"融资详情列表+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTabLeView endRefresh];
            if(index==1){
                [self.noticDataArr removeAllObjects];
            }
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTabLeView noMoreData]:[_curTabLeView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                          CMRongZiDetailList  *lismodel=[CMRongZiDetailList yy_modelWithDictionary:dict];
                         [self.noticDataArr addObject:lismodel];
                            
                        }
                        
                        
                    }
                }
                if(self.noticDataArr.count%5!=0){
                    [_curTabLeView noMoreData];
                    
                }
            }else{
                
                
                
                
            }
            
            [_curTabLeView reloadData];
            
        }
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
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
