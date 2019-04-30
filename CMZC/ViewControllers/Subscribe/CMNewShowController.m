//
//  CMNewShowController.m
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMNewShowController.h"
#import "CMNewProductCell.h"
#import "CMMarketTitleView.h"
#import "CMScreeningView.h"
#import "CMProductPullView.h"
#import "CMShowHeadTitleView.h"
#import "CMProductType.h"
#import "CMErrorView.h"
@interface CMNewShowController ()<UITableViewDelegate,UITableViewDataSource,CMScreeningViewDelegate,CMProductPullViewDelegate,CMShowHeadTitleViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) NSMutableArray *productDataArr;
@property(nonatomic,strong)CMProductPullView *pullView;
@property(nonatomic,assign)NSInteger sortIndex;
@property (strong, nonatomic) CMErrorView *errorView;
@property(nonatomic,strong)CMShowHeadTitleView *SliderTitleView;
@end

@implementation CMNewShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // CMScreeningView *screeingView=[CMScreeningView initByNibForClassName];
   // screeingView.delegate=self;
// UIView   *topView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 40)];
//    [self.view addSubview:topView];
    [_topView addSubview:self.SliderTitleView];
   // _curTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 40)];
    //[_curTableView.tableHeaderView addSubview:screeingView];
    [self requestTitle];
    [self addRequestDataMeans];
}
-(CMShowHeadTitleView*)SliderTitleView{
   if (!_SliderTitleView) {
       _SliderTitleView=[[CMShowHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 45)];
       _SliderTitleView.backgroundColor= [UIColor clmHex:0x1e1e1e];
       _SliderTitleView.delegate=self;
    }
    return _SliderTitleView;
}
- (NSMutableArray *)productDataArr {
    if (!_productDataArr) {
        _productDataArr = [NSMutableArray array];
    }
    return _productDataArr;
}

- (CMErrorView *)errorView {
    if (!_errorView) {
        float heightView = [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height+45;
        _errorView = [[CMErrorView alloc] initWithFrame:CGRectMake(0, heightView, CMScreen_width(), CMScreen_height()) bgImageName:@"chiyou_trade"];
    }
    return _errorView;
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //_curTableView.hidden = YES;
    [self showDefaultProgressHUD];
    //显示菊花
    _sortIndex=0;
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = _productDataArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    [CMRequestAPI cm_applyNewProductListOnPageIndex:page pageSize:10 productType:_sortIndex success:^(NSArray *productArr, BOOL isPage) {
        
        [self hiddenProgressHUD];
        [_curTableView endRefresh];//结束刷新
        //_curTableView.hidden = NO;
        //区分显示教view
//       if (isPage==YES) {
//            [_curTableView noMoreData];
//
//        }
        if (productArr.count>0) {
            _curTableView.hidden=NO;
            if (self.errorView) {
                [self.errorView removeView];
            }
        } else {
            _curTableView.hidden = YES;
            [self.view addSubview:self.errorView];
        }
        
        
       kCurTableView_foot
        if (page == 1) {
            [self.productDataArr removeAllObjects];
        }
        [self.productDataArr addObjectsFromArray:productArr];
        
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}

- (void)requestTitle {
    [CMRequestAPI cm_marketFetchProductTypeSuccess:^(NSArray *typeArr) {
        
     
 
        NSMutableArray *mutableArray=[NSMutableArray arrayWithArray:typeArr];
        CMProductType *prType=[[CMProductType alloc]init];
        
        prType.name=@"全部";
        prType.typeId=0;
        [mutableArray insertObject:prType atIndex:0];
        
//        for (CMProductType *prType in typeArr) {
//            [mutableArray addObject:prType.name];
//        }
       
        self.SliderTitleView.titleArray=mutableArray;
        
    } fail:^(NSError *error) {
        MyLog(@"请求title str失败");
    }];
}


//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//      UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    for (UIView *vc in window.subviews) {
//
//        if ([vc isMemberOfClass:[CMProductPullView class]]) {
//            [vc removeFromSuperview];
//        }
//
//    }
//    [self.pullView removeFrom];
//    self.pullView = nil;
//}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.productDataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CMNewProductCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"CMNewProductCell"];
    
    if (!subscribeCell) {
        subscribeCell = [[NSBundle mainBundle] loadNibNamed:@"CMNewProductCell" owner:nil options:nil].firstObject;
    }
    
    subscribeCell.purchaseModel=self.productDataArr[indexPath.row];
    return subscribeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(tableView==self.curTableView){
   CMPurchaseProduct *product = self.productDataArr[indexPath.row];

   CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
   webVC.ProductId=product.productId;
   webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url,[NSString stringWithFormat:@"/Products/Detail?pid=%ld&isLuYan=1",product.productId]);
    webVC.showRefresh=YES;
    [self.navigationController pushViewController:webVC animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    CMScreeningView *screeingView=[CMScreeningView initByNibForClassName];
//    screeingView.delegate=self;
//
//    return screeingView;
//}
-(void)selectIndexPage:(NSInteger)index{
    NSLog(@"++++++++%ld",index);
    _sortIndex=index;
    [self requestListWithPageNo:1];
}
-(void)ShowScreeingList:(UILabel*)titleName{
    
    if (self.pullView == nil){
        ///创建下拉菜单
        self.curTableView.scrollEnabled=NO;
        self.pullView = [[CMProductPullView alloc]initShowTheListOnButton:titleName Height:160 Titles:@[@"综合排序",@"额度从高到低",@"额度从低到高",@"更新时间"]];
        self.pullView.delegate = self;
    
        
    }else{
        self.curTableView.scrollEnabled=YES;
       // [self.pullView hideTheListViewOnButton:titleName];
        self.pullView = nil;
        [self.pullView removeFrom];
        
    }
    
}
-(void)choseTheCell:(NSInteger)index{
    self.curTableView.scrollEnabled=YES;
    NSLog(@"+++%ld",index);
    _sortIndex=index;
    [self requestListWithPageNo:1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.pullView = nil;
    [self.pullView removeFrom];
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
