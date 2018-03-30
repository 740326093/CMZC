//
//  CMApplyProjectListController.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMApplyProjectListController.h"
#import "CMConcessionDetailController.h"
#import "CMApplyListCell.h"
#import "CMApplyNoDataView.h"
#import "CMRongZiModel.h"
#import "CMLingTouModel.h"
#import "CMHangtagApplyController.h"
#import "CMConsultController.h"
#import "CMShareView.h"
@interface CMApplyProjectListController ()<UITableViewDelegate,UITableViewDataSource,CMApplyNoDataViewDelegate,CMApplyListCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property(nonatomic,strong)NSMutableArray *noticDataArr;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)CMApplyNoDataView *dataView;
@end
@implementation CMApplyProjectListController


-(void)viewDidLoad{
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout =UIRectEdgeNone;
        
    }
    [self.view addSubview:self.dataView];
    if (_type==1) { 
        self.title=@"我申请的融资项目";
       [self.dataView updateNoDataImage:@"applyNoDataImage_01" andnoDataTitle:@"暂无融资项目" withApplyString:@"申请挂牌融资"];
        [self addrequestData];
    }else if (_type==2){
        self.title=@"我的承销项目";
        [self.dataView updateNoDataImage:@"applyNoDataImage_03" andnoDataTitle:@"暂无承销项目" withApplyString:@"申请承销"];
        [self addChengXiaoData];
    }else if (_type==3){
        
        self.title=@"我的领投项目";
        [self.dataView updateNoDataImage:@"applyNoDataImage_02" andnoDataTitle:@"暂无领投项目" withApplyString:@"申请领投"];
        [self addLingTouData];
    }else{
        self.title=@"我的承销项目";
        [self.dataView updateNoDataImage:@"applyNoDataImage_03" andnoDataTitle:@"暂无承销项目" withApplyString:@"申请承销"];
        [self addChengXiaoData];
    }
    
    self.dataView.delegate=self;
    
}

#pragma mark data 融资数据
-(void)addrequestData{
    
    [self resetData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self resetData];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
        [self LoadDataWithPageIndex:++self.pageIndex];
    }];
}
-(void)resetData{
    self.pageIndex=1;
    [self LoadDataWithPageIndex:self.pageIndex];
}

#pragma mark 领投项目

-(void)addLingTouData{
    [self resetLingTouData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self resetLingTouData];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
        [self LoadLingTouDataWithPageIndex:++self.pageIndex];
    }];
    
}
-(void)resetLingTouData{
    self.pageIndex=1;
    [self LoadLingTouDataWithPageIndex:self.pageIndex];
}
#pragma mark 承销项目
-(void)addChengXiaoData{
    [self resetChengXiaoData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self resetChengXiaoData];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
        [self LoadChengXiaoDataWithPageIndex:++self.pageIndex];
    }];
    
}
-(void)resetChengXiaoData{
    self.pageIndex=1;
    [self LoadChengXiaoDataWithPageIndex:self.pageIndex];
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
       
        
    }
    
    return _dataView;
}
#pragma mark UiTableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticDataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CMApplyListCell  *applyCell=[tableView dequeueReusableCellWithIdentifier:@"ApplyListCell"];
    if (!applyCell) {
        applyCell=[CMApplyListCell initByNibForClassName];
    }
    if (self.noticDataArr.count>0) {
        applyCell.type=_type;
        switch (_type) {
            case 1:
            {
                applyCell.RongZiModel=self.noticDataArr[indexPath.row];
                if (applyCell.RongZiModel.enterDetail) {
                    
                    applyCell.selectionStyle=UITableViewCellSelectionStyleDefault;
                }else{
                    applyCell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                
            }
                
                break;
            case 2:{
                applyCell.applyModel=self.noticDataArr[indexPath.row];
                applyCell.delegate=self;
            }
                break;
            case 3:
            {
                
                 applyCell.LingTouModel=self.noticDataArr[indexPath.row];
            }
                break;
                
            default:
                break;
        }
        
    }
    return applyCell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (_type) {
        case 1:{
            CMRongZiModel *rongModel=self.noticDataArr[indexPath.row];
            if (rongModel.enterDetail) {
                CMConcessionDetailController *ConcessionDetail=(CMConcessionDetailController*)[CMConcessionDetailController initByStoryboard];
                ConcessionDetail.newType=CMFinancingDetail;
                ConcessionDetail.productZid=rongModel.cpid;
                [self.navigationController  pushViewController:ConcessionDetail animated:YES];
           }
        }
            break;
        case 2:
            //承销
        {
            
            CMConcessionDetailController *ConcessionDetail=(CMConcessionDetailController*)[CMConcessionDetailController initByStoryboard];
            CMApplyModel *apply=self.noticDataArr[indexPath.row];
            ConcessionDetail.productZid=apply.zid;
            ConcessionDetail.newType=CMMyApplyDetail;
            [self.navigationController  pushViewController:ConcessionDetail animated:YES];
            
        }
            break;
        case 3:
            //领投
        {
            CMLingTouModel *rongModel=self.noticDataArr[indexPath.row];
            CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
            NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Products/Detail?pid=%@",rongModel.pid]);
            webVC.urlStr = webUrl;
            [self.navigationController pushViewController:webVC animated:YES];
            
            
        }
            break;
            
        default:
            break;
    }
   
    
    
}
- (IBAction)addProjectEvent:(id)sender {
    
   // CMHangtagApplyController *HangtagApply=(CMHangtagApplyController*)[CMHangtagApplyController initByStoryboard];
   // [self.navigationController pushViewController:HangtagApply animated:YES];
    switch (_type) {
        case 1:
        {
            CMHangtagApplyController *HangtagApply=(CMHangtagApplyController*)[CMHangtagApplyController initByStoryboard];
            [self.navigationController pushViewController:HangtagApply animated:YES];
        }
            break;
        case 2:{
            CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
            consultController.type=ApplyProject;
            consultController.pid=@"";
            [self.navigationController pushViewController:consultController animated:YES];
        }
            break;
        case 3:{
            CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
            consultController.type=LingTouProject;
            consultController.pid=@"";
            [self.navigationController pushViewController:consultController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)applyEvent{
    
    switch (_type) {
        case 1:
        {
            CMHangtagApplyController *HangtagApply=(CMHangtagApplyController*)[CMHangtagApplyController initByStoryboard];
            [self.navigationController pushViewController:HangtagApply animated:YES];
        }
            break;
        case 2:{
            CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
            consultController.type=ApplyProject;
            consultController.pid=@"";
            [self.navigationController pushViewController:consultController animated:YES];
        }
            break;
        case 3:{
            CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
            consultController.type=LingTouProject;
            consultController.pid=@"";
            [self.navigationController pushViewController:consultController animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(void)LoadDataWithPageIndex:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"pageSize":@"5",@"pageIndex":CMStringWithFormat(index)};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"AppliedFinancingProject" andMessage:messageDict success:^(id responseObj) {
        
        MyLog(@"融资项目+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTableView endRefresh];
            if(index==1){
                
                [self.noticDataArr removeAllObjects];
            }
            
            
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTableView noMoreData]:[_curTableView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                _curTableView.hidden=NO;
                self.dataView.hidden=YES;
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                            
                            CMRongZiModel *apply=[CMRongZiModel yy_modelWithDictionary:dict];
                            [self.noticDataArr addObject:apply];
                            
                        }
                        
                        //self.noticDataArr.count<5?[_cureTableView noMoreData]:[_cureTableView resetNoMoreData];
                        
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
        [self.view showHubView:self.view messageStr:error.message time:2];
    }];
    
    
}
#pragma mark 领投项目
-(void)LoadLingTouDataWithPageIndex:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"pageIndex":CMStringWithFormat(index)};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"Get_MyLingTouProduct_List" andMessage:messageDict success:^(id responseObj) {
        
        MyLog(@"领投项目+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTableView endRefresh];
            if(index==1){
                
                [self.noticDataArr removeAllObjects];
            }
            
            
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTableView noMoreData]:[_curTableView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                _curTableView.hidden=NO;
                self.dataView.hidden=YES;
                id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
                
                if (tmp) {
                    
                    
                    if ([tmp isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *dict in tmp) {
                            
                            CMLingTouModel *apply=[CMLingTouModel yy_modelWithDictionary:dict];
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
        [self.view showHubView:self.view messageStr:error.message time:2];
    }];
    
    
}

#pragma mark 承销项目
-(void)LoadChengXiaoDataWithPageIndex:(NSInteger)index{
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"pageSize":@"5",@"pageIndex":CMStringWithFormat(index)};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetChengXiaoList" andMessage:messageDict success:^(id responseObj) {
        
        MyLog(@"承销项目+++%@",responseObj);
        if ([[responseObj objectForKey:@"respCode"]integerValue]==1) {
            [_curTableView endRefresh];
            if(index==1){
                
                [self.noticDataArr removeAllObjects];
            }
            
            
            index>[[responseObj objectForKey:@"pageCount"]integerValue]?[_curTableView noMoreData]:[_curTableView resetNoMoreData];
            
            if([responseObj[@"totalRows"]integerValue]>0){
                //有数据
                _curTableView.hidden=NO;
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
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
    
    
}

#pragma mark  代理
-(void)ApplyShareEventWith:(CMApplyModel *)model{
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    shareView.center = window.center;
    shareView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    shareView.contentUrl =[NSString stringWithFormat:@"%@/Products/Detail?pid=%@&cxid=%@",kCMMZWeb_url,model.cpId,model.zid];
    shareView.titleConten = [NSString stringWithFormat:@"%@向您推荐%@",(NSString*)GetDataFromNSUserDefaults(@"OrgJianCheng"),model.cpName];
    shareView.controller=self;
    NSString *content = [NSString stringWithFormat:@"本产品由%@领投,预期收益%@%%,保荐人推荐,百分百中签,赶快来加入吧!",model.LingTouOrgName,model.yq_nlv];
    shareView.contentStr = content;
    shareView.ShareImageName=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.cpPic]];
    [window addSubview:shareView];
    
}
//-(void)LiTouZiXunEvent:(CMLingTouModel *)model{
//    
//    CMConsultController  *consultController=(CMConsultController*)[CMConsultController initByStoryboard];
//    consultController.type=LingTouProject;
//    consultController.pid=model.pid;
//    [self.navigationController pushViewController:consultController animated:YES];
//    
//}
@end
