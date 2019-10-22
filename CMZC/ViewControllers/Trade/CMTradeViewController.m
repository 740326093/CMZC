//
//  CMTradeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMTradeViewController.h"
#import "CMTradeMeansTableViewCell.h"
#import "CMTradeTitleView.h"
#import "CMFunctionTableViewCell.h"
#import "CMTradeSonInterfaceController.h"
#import "CMOptionalViewController.h"
#import "CMCarryNowViewController.h"
#import "CMInstallViewController.h"
#import "CMStatementViewController.h"
#import "CMMyBankCardViewController.h"
#import "CMLoginViewController.h"
#import "CMAccountinfo.h"
#import "CMCommWebViewController.h"
#import "CMTabBarViewController.h"
#import "CMCarryDetailsViewController.h"
#import "CMMessageViewController.h"
#import "CMMySubScribeController.h"
#import "CMAgencyMmbersCell.h"
#import  "CMAgencyCheckController.h"
#import "CMAgencyMebersController.h"
#import "CMMebersIncomeController.h"
#import "CMCheackStateModel.h"
#import "CMNewNoticeController.h"
@interface CMTradeViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CMTradeMeansTableViewCellDelegate,CMTradeTitleViewDelegate>{
    NSArray *_titImageArr;//头图片Image
    NSArray *_titLabNameArr;//名字lab
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) CMTradeTitleView *tradeTitleView;
@property (strong, nonatomic) CMAccountinfo *tinfo;
@property (weak, nonatomic) IBOutlet UIImageView *tradeImage;
@property (strong, nonatomic) CMCheackStateModel *CheackStateModel;


@end

@implementation CMTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tradeTitleView = [CMTradeTitleView initByNibForClassName];
    _tradeTitleView.delegate = self;
    _curTableView.tableHeaderView = _tradeTitleView;
    _curTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 10)];
    
    _titLabNameArr = @[@"我的申购",@"我的基金",@"安全认证",@"我的邀请",@"我的收藏",@"我的消息",@"新手交易指南",@"设置"];
    _titImageArr = @[@"subscribe_trade",@"funds_trade",@"bankCard_trade",@"invate_trade",@"collection_trade",@"message_trade",@"new_trade",@"set_trade"];
    //判断一下是否登录
    //if (CMIsLogin()) {
    
    //}
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:@"loginWin" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchase) name:@"productPurchase" object:nil];
 //[self addRequestDataMeans];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:@"loginWin" object:nil];
    //添加下拉刷新
[_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    if (CMIsLogin()) {
        [self addRequestDataMeans];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccessed) name:@"TiXianSuccess" object:nil];
    //
    //
    
}

- (void)loginSuccessed {
    
    [_curTableView beginHeaderRefreshing];
    
}
/*
- (void)productPurchase {
    //已登录显示账户
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 1;
    
}
 */
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    [self showDefaultProgressHUD];
    //显示菊花
    [self requestListWithPageNo:1];
   
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    if (CMIsLogin()) {
        _tradeTitleView.loginView.hidden = NO;
    }
    //判断token
    [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
        [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
           //MyLog(@" account : %@",account);
            
            [self hiddenAllProgressHUD];

           
            _tradeTitleView.tinfo = account;
            _tinfo = account;
            SaveDataToNSUserDefaults(account.userid, @"userid");
             [_curTableView endRefresh];
            [self cheackStatecheackStateWithUserId:account.userid];
        } fail:^(NSError *error) {
            [_curTableView endRefresh];
            [self hiddenAllProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    } fail:^(NSError *error) {
        
        [self hiddenAllProgressHUD];
        [_curTableView endRefresh];
        //[self showHUDWithMessage:@"请登录账户" hiddenDelayTime:2];
    }];
    
    
    
    
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titLabNameArr.count+2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row ==0){
        return 0.001;
         // return 190;
    }
    else if (indexPath.row > 0&&indexPath.row<=_titLabNameArr.count) {
        return 40;
    } else {
        return 70;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
//        CMAgencyMmbersCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMAgencyMmbersCell" forIndexPath:indexPath];
//        return tableCell;
        
//
//        CMTradeMeansTableViewCell *tradeMeansCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeMeansTableViewCell" forIndexPath:indexPath];
//        tradeMeansCell.delegate = self;
       UITableViewCell *tradeMeansCell=[tableView dequeueReusableCellWithIdentifier:@"tradeMeansCell"];
             if (!tradeMeansCell) {
                 tradeMeansCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tradeMeansCell"];
                 tradeMeansCell.selectionStyle=UITableViewCellSelectionStyleNone;
             }
            
        
        return tradeMeansCell;
    }
   else if (indexPath.row > 0&&indexPath.row<=_titLabNameArr.count) {
       CMFunctionTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMFunctionTableViewCell" forIndexPath:indexPath];
       [tableCell cm_functionTileLabNameStr:_titLabNameArr[indexPath.row-1]
                             titleImageName:_titImageArr[indexPath.row - 1]];
       
       if (indexPath.row == 4) {
           tableCell.tradeImage.hidden = NO;
       } else {
           tableCell.tradeImage.hidden = YES;
       }
       
       
       return tableCell;
        
       
    } else {
        CMAgencyMmbersCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMAgencyMmbersCell" forIndexPath:indexPath];
             return tableCell;
//        CMFunctionTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMFunctionTableViewCell" forIndexPath:indexPath];
//        [tableCell cm_functionTileLabNameStr:_titLabNameArr[indexPath.row-2]
//                              titleImageName:_titImageArr[indexPath.row - 2]];
//
//        if (indexPath.row == 7) {
//            tableCell.tradeImage.hidden = NO;
//        } else {
//            tableCell.tradeImage.hidden = YES;
//        }
//
//
//        return tableCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *commonalityVC ;
    if (!CMIsLogin()) {
        //没有登录过。跳转到登录界面
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        loginVC.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else {
        
        
        if (indexPath.row>_titLabNameArr.count) {
            MyLog(@"机构会员标识+++%ld",_tinfo.bjigou);
            //  CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
            // CMMebersIncomeController *collectController = (CMMebersIncomeController *)[CMMebersIncomeController initByStoryboard];
            // commonalityVC = collectController;
            //bjigou  机构会员标识0非机构会员 1会员审核状态 2机构会员
            
            switch (_tinfo.bjigou) {
                case 0:{
                    MyLog(@"++++++%@",_CheackStateModel);
                    if (_CheackStateModel) {
                        if (_CheackStateModel.Status==2) {
                            CMAgencyCheckController *collectController = (CMAgencyCheckController *)[CMAgencyCheckController initByStoryboard];
                            collectController.stateType=CMCheackFail;
                            collectController.StateLab=_CheackStateModel.beizhu;
                            [self.navigationController pushViewController:collectController animated:YES];
                            return;
                        }
                        
                    }
                    CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
                    commonalityVC = collectController;
                    
                    
                    
                }
                    break;
                case 1:
                {
                    CMAgencyCheckController *collectController = (CMAgencyCheckController *)[CMAgencyCheckController initByStoryboard];
                    collectController.stateType=CMCheacking;
                    commonalityVC = collectController;
                    
                }
                    break;
                case 2:
                {
                    CMMebersIncomeController *collectController = (CMMebersIncomeController *)[CMMebersIncomeController initByStoryboard];
                    commonalityVC = collectController;
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            if (indexPath.row==1) {
                CMMySubScribeController *SubScribeController = [[CMMySubScribeController alloc]init];
                SubScribeController.hidesBottomBarWhenPushed=YES;
                commonalityVC = SubScribeController;
            }else if (indexPath.row==2){
                [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/JijinList")];
            } else if (indexPath.row==3){
                //                if (_tinfo.bankcardisexists) {
                //                    //判断是否绑定过银行卡
                //                    CMMyBankCardViewController *bankCardVC = (CMMyBankCardViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMyBankCardViewController"];
                //                    commonalityVC = bankCardVC;
                //                } else {
                //没有绑定过银行卡。现在还没有m站地址
                [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/SecurityCertification")];
               
                
            }
            
            else if (indexPath.row==4){
                CMMyInviteController *collectController = (CMMyInviteController *)[CMMyInviteController initByStoryboard];
                commonalityVC = collectController;
                //                }
            }else if (indexPath.row==5){
                
                CMMyCollectController *collectController = (CMMyCollectController *)[CMMyCollectController initByStoryboard];
                commonalityVC = collectController;
            }else if (indexPath.row==6){
                CMMessageViewController *statementVC = (CMMessageViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMessageViewController"];
                statementVC.block=^{
                    [self.curTableView reloadData];
                };
                commonalityVC = statementVC;
            }else if (indexPath.row==7){
                CMStatementViewController *statementVC = (CMStatementViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMStatementViewController"];
                statementVC.baserType = CMBaseViewDistinctionTypeDetails;
                statementVC.title = @"新手交易指南";
                commonalityVC = statementVC;
            }else {
                CMInstallViewController *installVC = (CMInstallViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMInstallViewController"];
                commonalityVC = installVC;
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*
        switch (indexPath.row) {
                
            case 0: //我的申购
            {
                MyLog(@"机构会员标识+++%ld",_tinfo.bjigou);
             //  CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
            // CMMebersIncomeController *collectController = (CMMebersIncomeController *)[CMMebersIncomeController initByStoryboard];
               // commonalityVC = collectController;
                //bjigou  机构会员标识0非机构会员 1会员审核状态 2机构会员
           
                switch (_tinfo.bjigou) {
                    case 0:{
                        MyLog(@"++++++%@",_CheackStateModel);
                        if (_CheackStateModel) {
                            if (_CheackStateModel.Status==2) {
                                CMAgencyCheckController *collectController = (CMAgencyCheckController *)[CMAgencyCheckController initByStoryboard];
                                collectController.stateType=CMCheackFail;
                                collectController.StateLab=_CheackStateModel.beizhu;
                                 [self.navigationController pushViewController:collectController animated:YES];
                                return;
                            }
                            
                        }
                   CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
                   commonalityVC = collectController;
                        
                       
                        
                    }
                        break;
                    case 1:
                    {
                        CMAgencyCheckController *collectController = (CMAgencyCheckController *)[CMAgencyCheckController initByStoryboard];
                        collectController.stateType=CMCheacking;
                        commonalityVC = collectController;
                        
                    }
                        break;
                    case 2:
                    {
                        CMMebersIncomeController *collectController = (CMMebersIncomeController *)[CMMebersIncomeController initByStoryboard];
                        commonalityVC = collectController;
                        }
                        break;
                        
                    default:
                        break;
                }
               
                
                
            }
                break;
            case 2: //我的申购
            {
                CMMySubScribeController *SubScribeController = [[CMMySubScribeController alloc]init];
                SubScribeController.hidesBottomBarWhenPushed=YES;
                commonalityVC = SubScribeController;
            
            }
                break;
                case 3: //我的基金
            {
                 [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/JijinList")];
            }
                break;
            case 4://银行卡认证
                //这里需要坐下判断，是否登录过，是否是认证过的。如果是，跳转到详情，如果不是，就不跳转
            {
//                if (_tinfo.bankcardisexists) {
//                    //判断是否绑定过银行卡
//                    CMMyBankCardViewController *bankCardVC = (CMMyBankCardViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMyBankCardViewController"];
//                    commonalityVC = bankCardVC;
//                } else {
                    //没有绑定过银行卡。现在还没有m站地址
                    [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/SecurityCertification")];
//                }
            }
                break;
                
            case 5:{
                //我的收藏
               // [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"Account/collectList.aspx")];
        
                CMMyCollectController *collectController = (CMMyCollectController *)[CMMyCollectController initByStoryboard];
                commonalityVC = collectController;
            }
                break;
            case 6://我的消息
            {
                CMMessageViewController *statementVC = (CMMessageViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMessageViewController"];
                statementVC.block=^{
                    [self.curTableView reloadData];
                };
                commonalityVC = statementVC;
               // [self performSegueWithIdentifier:idMessageViewController sender:self];
            }
                break;
            case 7://新手交易指南
            {
                CMStatementViewController *statementVC = (CMStatementViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMStatementViewController"];
                statementVC.baserType = CMBaseViewDistinctionTypeDetails;
                statementVC.title = @"新手交易指南";
                commonalityVC = statementVC;
                
            }
                
                break;
            case 8://设置
            {
                //设置
                CMInstallViewController *installVC = (CMInstallViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMInstallViewController"];
                commonalityVC = installVC;
            }
                break;
            default:
                break;
        }
        */
        [self.navigationController pushViewController:commonalityVC animated:YES];
    }
}

#pragma mark - CMTradeTitleViewDelegate
- (void)cm_tradeViewControllerType:(CMTradeTitleViewType)type {
    if (!CMIsLogin()) {
        //没有登录过。跳转到登录界面
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        loginVC.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else {
        switch (type) {
            case CMTradeTitleViewTypeCertification: //认证过
            {
                CMCarryDetailsViewController *carryNowVC = (CMCarryDetailsViewController *)[[UIStoryboard mainStoryboard]viewControllerWithId:@"CMCarryDetailsViewController"];
                carryNowVC.nameStr = _tinfo.realname;
                [self.navigationController pushViewController:carryNowVC animated:YES];
            }
                break;
            case CMTradeTitleViewTypeNotCertification:  //没有认证过
            {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"请先认证银行卡" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                aler.tag = 2008;
                [aler show];
                
            }
                break;
            default:
                break;
        }
    }
}
- (void)cm_tradeViewControllerLogin:(CMTradeTitleView *)titleView {
    CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
    loginVC.modalPresentationStyle=UIModalPresentationFullScreen;
    [self presentViewController:loginVC animated:YES completion:nil];
    
}
//充值
/*
- (void)cm_tradeViewControllerRecharge:(CMTradeTitleView *)titleView {
    [self pushCommWebViewVCUrlStr: CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Account/Recharge"])];
}
 */
//充值
-(void)cm_tradeViewControllerRechargeEvent:(CMTradeTitleViewType)type{
    
    switch (type) {
        case CMTradeTitleViewTypeCertification: //认证过
        {
//            CMWKWebControllerViewController *wk=[[CMWKWebControllerViewController alloc]init];
//            wk.urlStr=CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Account/Recharge"]);
//            wk.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:wk animated:YES];
            
            [self pushCommWebViewVCUrlStr: CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Account/Recharge"])];
        }
            break;
        case CMTradeTitleViewTypeNotCertification:  //没有认证过
        {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"请先认证银行卡" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aler.tag = 2008;
            [aler show];
            
        }
            break;
        default:
            break;
    }

}

- (void)pushCommWebViewVCUrlStr:(NSString *)url {
    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    commWebVC.urlStr = url;
    [self.navigationController pushViewController:commWebVC animated:YES];
}
-(void)cm_tradeViewControllerMoneyRecord{
    
     [self pushCommWebViewVCUrlStr: CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"/Account/CapitalRecords"])];
}
#pragma mark - CMTradeMeansTableViewCellDelegate
- (void)cm_tradeMeadsTableViewIndex:(NSInteger)index {
    //跳转到界面
    if (index == 100) {
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        loginVC.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    
    if (index<5) {
        CMTradeSonInterfaceController *tradeSonVC = (CMTradeSonInterfaceController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTradeSonInterfaceController"];
        tradeSonVC.itemIndex = index;
        tradeSonVC.tinfo = _tinfo;
        [self.navigationController pushViewController:tradeSonVC animated:YES];
    } else {
         NSLog(@"----%ld",(long)index);
        //自选界面
        CMOptionalViewController *optionalVC = (CMOptionalViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMOptionalViewController"];
        //需要传入数据
        
        [self.navigationController pushViewController:optionalVC animated:YES];
    }
}

#pragma mark - btn 
//退出账号
- (IBAction)quitBtnClick:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"你确定退出账号？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 2009;
    [aler show];
    
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 2008) {
        if (buttonIndex == 1) {
            [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/BankCardCertification")];
        }
    } else if (alertView.tag == 2009) {
        if (buttonIndex == 1) {
            [[CMAccountTool sharedCMAccountTool] removeAccount];
            //删除
            DeleteDataFromNSUserDefaults(@"name");
           DeleteDataFromNSUserDefaults(@"value");
            DeleteDataFromNSUserDefaults(@"Set-Cookie");
            DeleteDataFromNSUserDefaults(@"userid");
            _tradeTitleView.tinfo = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exitLogin" object:nil];
            
            AppDelegate *app = [AppDelegate shareDelegate];
               CMTabBarViewController *tabBar=(CMTabBarViewController*)app.window.rootViewController;

                       NSMutableArray *tabbarControllersArray=[NSMutableArray arrayWithArray:tabBar.viewControllers];
                   
                           
                           if (tabbarControllersArray.count ==4) {
                               
                       
                           [tabbarControllersArray removeObjectAtIndex:2];
                               
                               
                           }
                           
                           tabBar.viewControllers=tabbarControllersArray;
                           
                           
                           app.window.rootViewController =tabBar;
                  tabBar.selectedIndex = 0;
                           
        if (_isHidebottom) {
               [self.navigationController  popViewControllerAnimated:YES];
     }
           // else{
//            UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//            CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
//            tab.selectedIndex = 0;
//            }
//
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
            
            //删除cookie
            for (NSHTTPCookie *tempCookie in cookies) {
                [cookieStorage deleteCookie:tempCookie];
            }
               
            
              [[NSURLCache sharedURLCache] removeAllCachedResponses];

            
        }
    }
}


#pragma mark -机构审核状态
#pragma mark 审核状态
-(void)cheackStatecheackStateWithUserId:(NSString*)userID{
    
    
    NSDictionary *messageDict=@{@"hyid":userID};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetJiGouCheckStatus" andMessage:messageDict success:^(id responseObj) {
        //MyLog(@"审核状态+++%@",responseObj);
        
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
            
          
            id tmp = [NSJSONSerialization JSONObjectWithData:[responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
            
            if (tmp) {
                
                
                if ([tmp isKindOfClass:[NSArray class]]) {
                    
                    //NSDictionary *messDict=tmp[0];
                    //MyLog(@"审核状态++++++%@",messDict);
                    _CheackStateModel=[CMCheackStateModel  yy_modelWithDictionary:tmp[0]];
                    
                //[_curTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    [_curTableView reloadData];
                    
                    
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginWin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"exitLogin"];
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
