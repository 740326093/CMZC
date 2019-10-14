//
//  CMHomeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMHomeViewController.h"
#import "CMEditionTableViewCell.h"
//#import "CMBannerHeaderView.h"
#import "CMOptionTableViewCell.h"
#import "CMNewQualityTableViewCell.h"
#import "CMLatestTableViewCell.h"
#import "CMHomeTableFootView.h"
#import "CMOptionalViewController.h"
#import "CMProductDetailsViewController.h"
#import "CMAllServeViewController.h"
#import "CMAnalystViewController.h"
#import "CMBulletinViewController.h"
#import "CMMoneyViewController.h"
#import "CMTabBarViewController.h"
#import "CMCommWebViewController.h"
#import "CMCommentTableViewCell.h"
#import "CMWebSocket.h"
#import "CMRegisterViewController.h"
#import "CMNewShiModel.h"
#import "CMProductDetails.h"
#import "CMTradeSearchCell.h"

#import "CMSubscribeTableViewCell.h"
#import "CMGoldMedalTableViewCell.h"
#import "CMAnalystDetailsViewController.h"
#import "CMApp_Header.h"
#import "CMClickViewCell.h"
#import "CMShowOtherCell.h"


//#import "CMNewProductCell.h"


@interface CMHomeViewController ()<UITableViewDelegate,UITableViewDataSource,CMEditionTableViewCellDelegate,CMOptionTableViewCellDelegate,CMNewQualityCellDelegate,CMWebSocketDelegate,CMGoldMedalTableViewCellDelegate,CMSubscribeTableViewCellDelegate,SDCycleScrollViewDelegate,CMShowOtherCellDelegate,UIAlertViewDelegate> {
    //NSString *_buyNumber; //多少人购买
}

@property (weak, nonatomic) IBOutlet UITableView *curTableView;//表

//@property (strong, nonatomic) CMBannerHeaderView *headerView;//表头

@property (strong, nonatomic) CMHomeTableFootView *footerView;//表尾

@property (nonatomic,strong) NSMutableArray *proictArr; //三个动态

@property (strong, nonatomic) NSMutableArray *manyFulfilArr; //众投宝

@property (strong, nonatomic) CMWebSocket *webSocket; //webSocket

@property (strong, nonatomic) NSArray *purchaseArr; //申购数据arr
@property (strong, nonatomic) NSArray *NewProductArr; //S板
@property (strong, nonatomic) NSArray *glodServiceArr; //金牌服务

@property (strong, nonatomic) NSMutableArray *guanDianArr; //请求新观点
@property (strong, nonatomic) SDCycleScrollView  *barScrollView; //请求新观点

@property (assign, nonatomic) BOOL bankExits; //是否认证



@end

@implementation CMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _barScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CMScreen_width(),f_i5real(160))
                                                            delegate:self
                                                    placeholderImage:[UIImage imageNamed:@"title_log"]];
    _barScrollView.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
    _curTableView.tableHeaderView=_barScrollView;
    _footerView = [CMHomeTableFootView initByNibForClassName];
    _curTableView.tableFooterView = _footerView;
    //请求轮播图数据
    [self requestTitleBannesData];
    [self addRequestDataMeans];
   
    //[_curTableView beginHeaderRefreshing];
    //监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful) name:@"loginWin" object:nil];
    //监听退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful) name:@"exitLogin" object:nil];
    
    _bankExits=NO;

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开启定时器
   // [_headerView restartScrollBanner];
    //开启websocket
    [self initWebSocket];
    [_barScrollView adjustWhenControllerViewWillAppera];
    
    
        
    
        
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭定时器
    //[_headerView stopScrollBanner];
    //关闭websocket
    [_webSocket close];
}



#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {

    [self showDefaultProgressHUD];
    [self addData];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestTitleBannesData];
        [self addData];
    }];
}
-(void)addData{
    
    
    //众投宝
    
//    if (CMIsLogin()) {
//        [self isHaveBankInformation];
//
//
//    }
    
    
    //[self requestPrictThree];
     [self requestProductFundlist];
    //申购
    [self requestPurchase];
    
    //金牌服务
    [self requestGlodService];
    //新视点
    [self requestNewGuanDian];
    //新科版
    [self requestNewProduct];
}

#pragma mark 判断是否认证
-(void)isHaveBankInformation{
    [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
        [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
            
            [self hiddenProgressHUD];
            
            SaveDataToNSUserDefaults(account.userid, @"userid");
            
            if (account.bankcardisexists==YES) {
                [self requestProductFundlist];
                
            }else{
                //_bankExits=NO;
                [self.manyFulfilArr removeAllObjects];
                [_curTableView reloadData];
            }
            
       
        } fail:^(NSError *error) {
            [_curTableView endRefresh];
            [self hiddenProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];
        //[self showHUDWithMessage:@"请登录账户" hiddenDelayTime:2];
    }];
    
    
    
}

-(void)requestNewGuanDian{
    
    [CMRequestAPI cm_trendsNewDataPage:1 withType:@"16" success:^(NSArray *dataArr, BOOL isPage) {
      
        [self.guanDianArr removeAllObjects];
        
        [self.guanDianArr addObjectsFromArray:dataArr];
       
        [_curTableView endRefresh];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"最新动态请求失败");
        [_curTableView endRefresh];
        [self hiddenProgressHUD];
        [self showHUDWithMessage:@"网络异常，请重试" hiddenDelayTime:2.0];
       
        
   
        
    }];
    
}

//- (void)requestTrends {
//    
//    
//    [CMRequestAPI cm_trendsNewDataPage:1 withType:@"8" success:^(NSArray *dataArr, BOOL isPage) {
//     
//        [self.trendsArr removeAllObjects];
//        [self.trendsArr addObjectsFromArray:dataArr];
//        
//        if (self.trendsArr.count>0) {
//            [self hiddenProgressHUD];
//            
//            [_curTableView endRefresh];//结束刷新
//            
//            [_curTableView reloadData];
//        }
//        
//    } fail:^(NSError *error) {
//         MyLog(@"最新动态请求失败");
//    }];
//}
//



- (void)requestProductFundlist {
    
    [CMRequestAPI cm_homeFetchProductFundlistPageSize:3 success:^(NSArray *fundlistArr) {
       
        [self.manyFulfilArr removeAllObjects];
        
        [self.manyFulfilArr addObjectsFromArray:fundlistArr];
        //_bankExits=YES;
        [self hiddenProgressHUD];
        [_curTableView reloadData];
//        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
//        [_curTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
//        [_curTableView endUpdates];
    } fail:^(NSError *error) {
        MyLog(@"众投产品请求失败");
        [_curTableView endRefresh];
        [self hiddenProgressHUD];
        [self showHUDWithMessage:@"网络异常，请重试" hiddenDelayTime:2.0];
    }];
    
    /*
    [CMRequestAPI cm_homeProductPurchaseNumberSuccess:^(NSString *buyNumber) {
        _buyNumber = buyNumber;
       [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"人数请求失败");
    }];
    */
}


//请求轮播图
- (void)requestTitleBannesData {
    [CMRequestAPI cm_homeFetchBannersSuccess:^(NSArray *bannersArr) {
       
      //  _headerView.banners = bannersArr;
        _barScrollView.barModelGrop=bannersArr;
    } fail:^(NSError *error) {
        MyLog(@"轮播图请求失败");
    }];
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToUrl:(NSString *)url{
    [self cm_commWebViewURL:url];
}
//产品三个
- (void)requestPrictThree {
    
    [CMRequestAPI cm_homeFetchProductThreePageSize:3 success:^(NSArray *threeArr) {
       
        [self.proictArr removeAllObjects];
        if (threeArr.count>=3) {
          [self.proictArr addObjectsFromArray:threeArr];
        }
       
        [_curTableView beginUpdates];
        [_curTableView reloadData];
        
    } fail:^(NSError *error) {
        MyLog(@"请求三个产品失败");
    }];
}
//申购列表
- (void)requestPurchase {
    [CMRequestAPI cm_applyFetchProductListOnPageIndex:0 pageSize:3 success:^(NSArray *productArr, BOOL isPage) {
        [self hiddenProgressHUD];
        self.purchaseArr = productArr;
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"请求申购列表");
    }];
}

- (void)requestNewProduct {
   [CMRequestAPI cm_homeShowOtherProductBannersSuccess:^(NSArray *bannersArr) {

        self.NewProductArr = bannersArr;
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } fail:^(NSError *error) {
         MyLog(@"请求新科列表");
    }];
}
//金牌理财师
- (void)requestGlodService {
    [CMRequestAPI cm_homeDefaultPageGlodServiceSuccess:^(NSArray *adminis) {
       
        self.glodServiceArr = adminis;
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"金牌理财师请求失败");
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   //+4+1+self.NewProductArr.count;
    if (section==0) {
        if (self.guanDianArr.count >4) {
            return 5+self.purchaseArr.count+4;
        } else{
            return 5+self.purchaseArr.count+self.guanDianArr.count;
        }//+1+self.NewProductArr.count;
    } else {
        if (self.NewProductArr.count>0) {
           return 1;
        } else {
           return 0;
        }
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
    if (indexPath.row == 0) {
        if (self.proictArr.count == 0 ) {
            return 0;
        } else {
            return 111;
        }
    } else if (indexPath.row == 1) {
       
        return 240;
     
    } else if (indexPath.row == 2) { //倍利宝
        if (self.manyFulfilArr.count>0) {
            return 231;
        } else {
            return 0.001;
        }
        
        
        
    } else if (indexPath.row == 3) {
        return 39;
    } else if (indexPath.row > 3 && indexPath.row <= self.purchaseArr.count + 3) { //申购
        return 375;
    }/*
    else if ( indexPath.row ==4+self.purchaseArr.count) { //申购
        
        return 39;
    }else if ( indexPath.row >4+self.purchaseArr.count&& indexPath.row <=4+self.purchaseArr.count+self.NewProductArr.count) { //申购
        return 250;
    }
      *///+self.NewProductArr.count
    else if (indexPath.row == 4 + self.purchaseArr.count) { //金牌服务
        return 240;
    }//self.NewProductArr.count
    else if (indexPath.row == 5 + self.purchaseArr.count) { //最新动态
        return 181;
    } else {
        return 36;
    }
        
    } else {
        return f_i5real(140);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
    if (indexPath.row == 0) {
        if (self.proictArr.count == 0 ) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            return cell;
        } else {
            //产品
            CMEditionTableViewCell *editionCell = [tableView dequeueReusableCellWithIdentifier:@"CMEditionTableViewCell" forIndexPath:indexPath];
            editionCell.prictArr = self.proictArr;
            
            editionCell.delegate = self;
            return editionCell;
        }
    } else if (indexPath.row == 1) {
        //四个选项
        CMOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"CMOptionTableViewCell" forIndexPath:indexPath];
        optionCell.isHaveBank=_bankExits;
        optionCell.baseController=self;
        optionCell.delegate = self;
       
        return optionCell;
    } else if (indexPath.row == 2) {
        //倍利宝
        CMNewQualityTableViewCell *qualityCell = [tableView dequeueReusableCellWithIdentifier:@"CMNewQualityTableViewCell" forIndexPath:indexPath];
        if (self.manyFulfilArr.count > 0) {
            qualityCell.munyArr = self.manyFulfilArr;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 __block int number=0;
                [self.manyFulfilArr enumerateObjectsUsingBlock:^(CMNumberous *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    int num=[obj.attendPersionCount intValue];
                    number +=num;
                }];
                
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                     qualityCell.buyNumber = [NSString stringWithFormat:@"%d",number];   
                        
                    });
                
                 
            });
            
        }
       
        qualityCell.delegate = self;
        qualityCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return qualityCell;
    } else if (indexPath.row == 3) {
        CMClickViewCell *goldCell = [tableView dequeueReusableCellWithIdentifier:@"goldCell"];
        if (!goldCell) {
            
          goldCell = [[NSBundle mainBundle] loadNibNamed:@"CMClickViewCell" owner:nil options:nil].firstObject;
    
        }
        goldCell.rightLab.text=@"更多 >";
        goldCell.leftLab.text = @"申购";
        
        return goldCell;
    } else if (indexPath.row > 3 && indexPath.row <= self.purchaseArr.count + 3) { //申购
        CMSubscribeTableViewCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"CMSubscribeTableViewCell"];
        
        if (!subscribeCell) {
            subscribeCell = [[NSBundle mainBundle] loadNibNamed:@"CMSubscribeTableViewCell" owner:nil options:nil].firstObject;
        }
        subscribeCell.delegate = self;
        subscribeCell.product = self.purchaseArr[indexPath.row-4];
        return subscribeCell;
    }
    /*
    else if ( indexPath.row ==4+self.purchaseArr.count){
        
        
        CMClickViewCell *NewPreCell = [tableView dequeueReusableCellWithIdentifier:@"NewPreCell"];
        if (!NewPreCell) {
            
            NewPreCell = [[NSBundle mainBundle] loadNibNamed:@"CMClickViewCell" owner:nil options:nil].firstObject;
            
        }
        NewPreCell.rightLab.text=@"更多 >";
        NewPreCell.leftLab.text = @"新科板";
        
        return NewPreCell;
        

    }else if ( indexPath.row>4+self.purchaseArr.count&& indexPath.row <=4+self.purchaseArr.count+self.NewProductArr.count){//新科版
        CMNewProductCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"NewProductArr"];
        
        if (!subscribeCell) {
            subscribeCell = [[NSBundle mainBundle] loadNibNamed:@"CMNewProductCell" owner:nil options:nil].firstObject;
        }
     
        subscribeCell.purchaseModel=self.NewProductArr[indexPath.row-5-self.purchaseArr.count];
        return subscribeCell;
    }
    */
    else if (indexPath.row == 4 + self.purchaseArr.count) {
        CMGoldMedalTableViewCell *goldCell = [tableView dequeueReusableCellWithIdentifier:@"CMGoldMedalTableViewCell"];
        if (!goldCell) {
            goldCell = [[NSBundle mainBundle] loadNibNamed:@"CMGoldMedalTableViewCell" owner:nil options:nil].firstObject;
            goldCell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        goldCell.delegate = self;
        goldCell.glodServiceArr = self.glodServiceArr;
        return goldCell;
        
    } else if (indexPath.row == 5 + self.purchaseArr.count) {
        //最新动态
        CMLatestTableViewCell *latestCell = [tableView dequeueReusableCellWithIdentifier:@"CMLatestTableViewCell" forIndexPath:indexPath];
        latestCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.guanDianArr.count > 0) {
            latestCell.notice = self.guanDianArr[0];
        }
        return latestCell;
    } else {
        CMTradeSearchCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeSearchCell"];
        if (!tableCell) {
            tableCell = [[NSBundle mainBundle]loadNibNamed:@"CMTradeSearchCell" owner:nil options:nil].firstObject;
        }
        
       if (self.guanDianArr.count >0) {
            CMNewShiModel *media = self.guanDianArr[indexPath.row - 5 - self.purchaseArr.count];
           
           tableCell.nameLab.text = media.title;
        }
        return tableCell;
    }
        
    } else {
        
        CMShowOtherCell *editionCell = [tableView dequeueReusableCellWithIdentifier:@"CMShowOtherCell"];
    
        if (!editionCell) {
            editionCell=[[CMShowOtherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CMShowOtherCell"];
        }
        editionCell.barArray=self.NewProductArr;
        
        editionCell.delegate=self;
        return editionCell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
    
    if (indexPath.row == 3) { //申购更多
        [self showTabBarViewControllerType:1];
    } else if (indexPath.row > 3 && indexPath.row <=self.purchaseArr.count +3) { //申购详情
        CMPurchaseProduct *product = self.purchaseArr[indexPath.row-4];
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        webVC.ProductId=product.productId;
        webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url,CMStringWithPickFormat(@"/Products/Detail?pid=",CMStringWithFormat(product.productId)));
        webVC.showRefresh=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    /*
    else if (indexPath.row ==4+self.purchaseArr.count){
        
      CMNewShowController *commWebVC = (CMNewShowController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMNewShowController"];
    [self.navigationController pushViewController:commWebVC animated:YES];
    
    }else if ( indexPath.row>4+self.purchaseArr.count&& indexPath.row <=4+self.purchaseArr.count+self.NewProductArr.count){
        
        CMPurchaseProduct *product = self.NewProductArr[indexPath.row-5-self.purchaseArr.count];
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        webVC.ProductId=product.productId;
        webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url,CMStringWithPickFormat(@"/Products/Detail?pid=",CMStringWithFormat(product.productId)));
        webVC.showRefresh=YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }*/
    else if (indexPath.row >= 5+self.purchaseArr.count) { // 最新动态
        CMNewShiModel *media = self.guanDianArr[indexPath.row- 5 - self.purchaseArr.count];
        CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
        NSString *strUrl = CMStringWithPickFormat(kCMMZWeb_url,[NSString stringWithFormat:@"/Account/MessageDetail?nid=%ld",(long)media.mediaId])
        ;
        commWebVC.urlStr = strUrl;
        commWebVC.showRefresh=YES;
        commWebVC.fromAd=YES;
        [self.navigationController pushViewController:commWebVC animated:YES];
    }
        
    } else {
        
        CMNewShowController *commWebVC = (CMNewShowController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMNewShowController"];
        [self.navigationController pushViewController:commWebVC animated:YES];
    }
}

#pragma mark  路演专区
-(void)showOtherProductList{
    CMNewShowController *commWebVC = (CMNewShowController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMNewShowController"];
    [self.navigationController pushViewController:commWebVC animated:YES];
}
#pragma mark - CMEditionTableViewCellDelegate
//产品delegate CMEditionTableViewCellDelegate
- (void)cm_editionTableViewProductId:(NSString *)productId nameTitle:(NSString *)name{
    CMProductDetailsViewController *productDetailsVC = (CMProductDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMProductDetailsViewController"];
    productDetailsVC.titleName = name;
    productDetailsVC.codeName = productId;
    [self.navigationController pushViewController:productDetailsVC animated:YES];
}

#pragma mark - CMNewQualityCellDelegate
//众投宝
- (void)cm_newQualityProductId:(NSInteger)productid {
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Products/Detail?pid=%ld",(long)productid]);
    webVC.urlStr = webUrl;
    webVC.ProductId=productid;
    webVC.showRefresh=YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark 最新公告动态
-(void)cm_optionHeadMoreButtonEvent{
    CMBulletinViewController *bulletin = (CMBulletinViewController *)[CMBulletinViewController initByStoryboard];
    bulletin.selectIndex=2;
    [self.navigationController pushViewController:bulletin animated:YES];
}



#pragma mark - CMGoldMedalTableViewCellDelegate
- (void)cm_goldMedalAnalystsId:(NSInteger)analystsId {
//    CMAnalystDetailsViewController  *analystVC = (CMAnalystDetailsViewController *)[CMAnalystDetailsViewController initByStoryboard];
//    analystVC.analystsId = analystsId;
//    [self.navigationController pushViewController:analystVC animated:YES];
    [self cm_homeOptionAnalyst];
}
-(void)cm_goldOrganizationEnter{
  
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"/About/GoldService");
    [self.navigationController pushViewController:webVC animated:YES];
    
}
#pragma mark - CMSubscribeTableViewCellDelegate
- (void)cm_checkRoadshowLiveUrl:(NSString *)liveUrl {
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = liveUrl;
    webVC.showRefresh=YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)cm_checkImmediatelySubscribeEventWithPid:(NSInteger)productID{

    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = [NSString stringWithFormat:@"%@/Invest/Confirm?pid=%ld&pcont=1",kCMMZWeb_url,productID];
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - CMOptionTableViewCellDelegate 
//四个选项
- (void)cm_optionTableViewCellButTag:(NSInteger)btTag {
    
    switch (btTag) {
        case 0://交易指南
           
        {
            CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
           // webVC.urlStr = @"http://m.xinjingban.com/about/TradingGuideNew.aspx";
            webVC.urlStr =  CMStringWithPickFormat(kCMMZWeb_url, @"/about/TradingGuideNew.aspx");
            [self.navigationController pushViewController:webVC animated:YES];

        //  CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
//            //   CMMebersIncomeController *collectController = (CMMebersIncomeController *)[CMMebersIncomeController initByStoryboard];
       //[self.navigationController pushViewController:collectController animated:YES];
        }

            break;
        case 1://投资讲堂
        {
            CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
         //   webVC.urlStr = @"http://m.xinjingban.com/invesment.aspx";
            
            webVC.urlStr =  CMStringWithPickFormat(kCMMZWeb_url, @"/invesment.aspx");
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 2://安全保障
        {
            CMMoneyViewController  *newGuideVC=[[CMMoneyViewController alloc]init];
            newGuideVC.hidesBottomBarWhenPushed=YES;
            newGuideVC.titName = @"安全保障";//strength_serve_home
            newGuideVC.imageStr=@"insurance_serve_home";
            [self.navigationController pushViewController:newGuideVC animated:YES];
        }
            break;
        case 3://倍利宝
        {
           // if (_bankExits==YES) {
                CMBeiLiBaoController *webVC = (CMBeiLiBaoController *)[CMBeiLiBaoController initByStoryboard];
                
                [self.navigationController pushViewController:webVC animated:YES];
           // } else {
             //  [self cm_homeLoginOrAccountMethods];
            //}
          
        }
            break;
        case 4://开户 我的账户
        {
           // if (_bankExits==NO) {
            //   [self cm_homeOptionMore];
             
           // } else {
             [self cm_homeLoginOrAccountMethods];
           // }
            
        }
            break;
        default://更多
            [self cm_homeOptionMore];
            break;
    }
}
//注册或者我的账户按钮
- (void)cm_homeLoginOrAccountMethods {
//    UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//    [self presentViewController:nav animated:YES completion:nil];
    
    if (CMIsLogin()) {
        //已登录显示账户
//        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//        CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
//        tab.selectedIndex = 3;
        [self presentTabBarIndex];
        
    } else {
        //位登录。显示登录
        //位登录。显示登录
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTabBarIndex) name:@"loginWin" object:nil];
//        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//        [self presentViewController:nav animated:YES completion:nil];
        CMRegisterViewController *registerController=(CMRegisterViewController*)[[UIStoryboard loginStoryboard]viewControllerWithId:@"CMRegisterViewController"];
        [self.navigationController pushViewController:registerController animated:YES];
    }
    
}
- (void) presentTabBarIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 3;
}

//自选的跳转
- (void)cm_homeOptionalMethods {
    if (CMIsLogin()) {
        CMOptionalViewController *optionalVC = (CMOptionalViewController *)[CMOptionalViewController initByStoryboard];
        //optionalVC.name = @"财猫";
        [self.navigationController pushViewController:optionalVC animated:YES];

    } else {
        //位登录。显示登录
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
}
//更多
- (void)cm_homeOptionMore {
    CMAllServeViewController *optionalVC = (CMAllServeViewController *)[CMAllServeViewController initByStoryboard];
    //optionalVC.delegate = self;
    [self.navigationController pushViewController:optionalVC animated:YES];
}
//分析师
- (void)cm_homeOptionAnalyst {
    CMAnalystViewController *analystVC = (CMAnalystViewController *)[CMAnalystViewController initByStoryboard];
    [self.navigationController pushViewController:analystVC animated:YES];
}
//新观点
- (void)cm_homeOptionBulletin {
    CMBulletinViewController *bulletin = (CMBulletinViewController *)[CMBulletinViewController initByStoryboard];
      bulletin.selectIndex=1;
    [self.navigationController pushViewController:bulletin animated:YES];
}
//跳转到web站 
- (void)cm_commWebViewURL:(NSString *)url {
    if ([url isEqualToString:CMStringWithPickFormat(kCMMZWeb_url, @"/About/Description")]) {

        CMMoneyViewController  *newGuideVC=[[CMMoneyViewController alloc]init];
        newGuideVC.titName = @"新经板实力";//strength_serve_home
        newGuideVC.imageStr=@"strength_serve_home";
        newGuideVC.hidesBottomBarWhenPushed=YES;
       //newGuideVC.hideTabBar=YES;
        [self.navigationController pushViewController:newGuideVC animated:YES];
    } else {
//        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
//        webVC.urlStr = url;
//        webVC.showRefresh=YES;
//        [self.navigationController pushViewController:webVC animated:YES];
        CMWkWebViewController *webVc=[[CMWkWebViewController alloc]init];
        webVc.hidesBottomBarWhenPushed=YES;
        webVc.urlString=url;
      [self.navigationController pushViewController:webVc animated:YES];
        
    }
}

//- (void)cm_allServerViewControllerPopHomeVCType:(CMAllServerViewType)type {
//    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
//    tab.selectedIndex = 1;
//}
#pragma mark - btnClick
//更多动态
- (IBAction)moreBtnClick:(id)sender {
    [self cm_homeOptionBulletin];
}
#pragma mark - 登陆成功后的通知
- (void)loginSuccessful {
    
    NSIndexPath *tmpIndexpath=[NSIndexPath indexPathForRow:1 inSection:0];
    [_curTableView beginUpdates];
    [_curTableView reloadRowsAtIndexPaths:@[tmpIndexpath] withRowAnimation:UITableViewRowAnimationNone];
    [_curTableView endUpdates];

//
//    if (CMIsLogin()==YES) {
//
//    [self isHaveBankInformation];
//
//    }else{
//
//        [self.manyFulfilArr removeAllObjects];
//        _bankExits=NO;
//        [_curTableView reloadData];
//    }
//
    
    
}

#pragma mark - set get

- (NSMutableArray *)guanDianArr {
    if (!_guanDianArr) {
        _guanDianArr = [NSMutableArray array];
    }
    return _guanDianArr;
}
//三个
- (NSMutableArray *)proictArr {
    if (!_proictArr) {
        _proictArr = [NSMutableArray array];
    }
    return _proictArr;
}
//众投宝
- (NSMutableArray *)manyFulfilArr {
    if (!_manyFulfilArr) {
        _manyFulfilArr = [NSMutableArray array];
    }
    return _manyFulfilArr;
}
//

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - cmwebSocket
//后边也有页面用到。不想改了。以前粘贴复制。这个方法可以代替。
- (void)initWebSocket {
    if (!CMIsLogin()) {
        _webSocket = [[CMWebSocket alloc] initRequestUrl:CMStringWithPickFormat(kWebSocket_url, @"market/index")];
        _webSocket.delegate = self;
    } else {
        
        _webSocket = [[CMWebSocket alloc] initRequestUrl:CMStringWithPickFormat(kWebSocket_url, [NSString stringWithFormat:@"market/index?m=%@",[CMAccountTool sharedCMAccountTool].currentAccount.userName])];
        _webSocket.delegate = self;
    }
    
}
- (void)cm_webScketMessage:(NSString *)message {
    [self.proictArr removeAllObjects];
    NSString *contStr = [message substringWithRange:NSMakeRange(2, message.length - 2)];
    NSArray *marketArr = [contStr componentsSeparatedByString:@";"];
    if (marketArr.count>=3) {
        for (NSString *dataStr in marketArr) {
            NSArray *marketIndexArr = [dataStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            [self.proictArr addObject:marketIndexArr];
        }
    }
   
    [_curTableView beginUpdates];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [_curTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    [_curTableView endUpdates];
}





#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

*/
@end


















