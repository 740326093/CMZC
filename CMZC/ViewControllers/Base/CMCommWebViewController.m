//
//  CMCommWebViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 MAC. All rights reserved.
//

//#define kCMExternalLinksURL @"http://m.xinjingban.com/GrantAccess?targetUrl="
#define kCMExternalLinksURL CMStringWithPickFormat(kCMMZWeb_url, @"GrantAccess?targetUrl=")
//#define kCMExternalLinksURL @"http://testing.xinjingban.com/GrantAccess?targetUrl="
#import "CMCommWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "CMShareView.h"

@interface CMCommWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,CMConsultingAlertViewDelegate,CMBLBDetailBottomViewDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopLayout;

//@property (strong,nonatomic)NSString *currentTitle;
@property (nonatomic,copy) NSString *nextURL;
@property (strong,nonatomic)CMProductDetails *ProductDetails;
@property (copy,nonatomic) NSString *realUrl;
@property (strong,nonatomic) CMProductDetailBottomView*DetailBottomView;
@property(strong,nonatomic)CMBLBDetailBottomView *BLBDetailBottomView;
@end

@implementation CMCommWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
   
    if ([CMAccountTool sharedCMAccountTool].currentAccount.userName.length >0) {
        [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
            
            [self loadWebViewData];
        } fail:^(NSError *error) {
            UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
            [self presentViewController:nav animated:YES completion:nil];
        }];
    } else {
        [self loadWebViewData];
    }
 
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.showsVerticalScrollIndicator=NO;
    _webView.scrollView.showsHorizontalScrollIndicator=NO;
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0 animated:YES];
    
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
   
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
     self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    self.realUrl=_urlStr;
    _webView.hidden=YES;
    [self getProductDetaiWithProductID];

}


- (void)leftBarBtnClick {
    if ([self.webView canGoBack]) {
        if ([self.nextURL containsString:@"/Account/RechargeSuccess"]|| [self.nextURL containsString:@"yintong.com.cn"]|| [self.nextURL containsString:@"lianlianpay.com"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } else {
            [_webView goBack];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWebView) name:@"loginWin" object:nil];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView stopLoading];
    [_progressView removeFromSuperview];
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
      self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


- (void)loadWebViewData
{
    
 
    if (!CMIsLogin()) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];

        //4.查看请求头
        [_webView loadRequest:request];
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
    } else {
        [self LoadWebViewWithCookieAndUrl:_urlStr];
    }
     [self showDefaultProgressHUD];
}

-(void)LoadWebViewWithCookieAndUrl:(NSString*)urlStr{
    
    NSString *external =[NSString stringWithFormat:@"%@%@",kCMExternalLinksURL,urlStr];
    
    NSString *name = GetDataFromNSUserDefaults(@"name");
    NSString *value = GetDataFromNSUserDefaults(@"value");
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:external]];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *cookieValue = [NSString stringWithFormat:@"%@=%@",name,value];
    [mutableRequest addValue:cookieValue forHTTPHeaderField:@"cookie"];
    request = [mutableRequest copy];
    //4.查看请求头
    [self loadCookies];
    [_webView loadRequest:request];
  //  MyLog(@"allHTTPHeaderFields++%@",request.allHTTPHeaderFields);
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
   
   
    
}
- (void)loadCookies{
    NSString *name = GetDataFromNSUserDefaults(@"name");
    NSString *value = GetDataFromNSUserDefaults(@"value");
  
    if (name==nil&&value==nil) {
        return ;
    }
    NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
    [cookieDict setObject:name forKey:NSHTTPCookieName];
    [cookieDict setObject:value forKey:NSHTTPCookieValue];
    NSDictionary *prop1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           name,NSHTTPCookieName,
                           value,NSHTTPCookieValue,
                           @"/",NSHTTPCookiePath,
                           @"0",NSHTTPCookieVersion,
                           [NSURL URLWithString:_urlStr],NSHTTPCookieOriginURL,
                           [NSDate dateWithTimeIntervalSinceNow:60],NSHTTPCookieExpires,
                           nil];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:prop1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
}
#pragma mark 分享
-(void)shareView{
    
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
//    CMShareView *shareView = [[NSBundle mainBundle] loadNibNamed:@"CMShareView" owner:nil options:nil].firstObject;
    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    shareView.center = window.center;
    shareView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
   shareView.contentUrl =self.realUrl;
    shareView.titleConten = self.ProductDetails.title;
    shareView.controller=self;
   NSString *content = [NSString stringWithFormat:@"一起来众筹,100%%保底保息,预期收益%@(包含保底年收益+浮动)[%@];",self.ProductDetails.income,self.ProductDetails.descri];
   shareView.contentStr = content;
   shareView.ShareImageName=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.ProductDetails.picture]];
    [window addSubview:shareView];

}
-(void)pageShareView{
    
    MyLog(@"+++%@",self.realUrl);
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    shareView.center = window.center;
    shareView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    shareView.contentUrl =self.realUrl;
    shareView.titleConten = self.title;
    shareView.controller=self;
    NSString *content =nil;
    if ([self.realUrl isEqualToString:@"http://m.xinjingban.com/listing.aspx"]) {
      content= @"挂牌融资，就上新经板。十天免费融千万，IPO直通+转板。速度快、流程简单，一站式企业金融服务…";
    }else{
       content=shareView.titleConten;
    }
    shareView.contentStr = content;
    shareView.ShareImageName=[UIImage imageNamed:@"share_image"];
    [window addSubview:shareView];
    
}
- (void)refreshWebView
{
   [self loadWebViewData];
   
}

-(CMProductDetailBottomView*)DetailBottomView{
    if (!_DetailBottomView) {
        _DetailBottomView=[[CMProductDetailBottomView  alloc]initWithFrame:CGRectMake(0, CMScreen_height()-50, CMScreen_width(), 50)];
        _DetailBottomView.delegate=self;
    }
    return _DetailBottomView;
}
-(CMBLBDetailBottomView*)BLBDetailBottomView{
    if (!_BLBDetailBottomView) {
        _BLBDetailBottomView=[[CMBLBDetailBottomView  alloc]initWithFrame:CGRectMake(0, CMScreen_height()-50, CMScreen_width(), 50)];
        _BLBDetailBottomView.delegate=self;
    }
    return _BLBDetailBottomView;
}

#pragma mark - webDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //包含登录页面
    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Login")]) {
        //跳转到登录
        [webView stopLoading];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self hiddenProgressHUD];
   
    MyLog(@"+++%@",webView.request.URL.host);
   
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('page-header navbar navbar-default navbar-static-top')[0].hidden=true"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('live_headbg')[0].hidden=true"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElements.getElementsByClassName('header')[0].hidden=true"];


   
    if (!webView.loading) {
        [self performSelector:@selector(webViewHiddenNot:) withObject:webView afterDelay:1.5];
  
    }

    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([self.title containsString:@"连连支付"]) {
        self.TopLayout.constant=-42;//隐藏连连导航
    }else{
         self.TopLayout.constant=0;//隐藏连连导航
    }
    if ([webView.request.URL.absoluteString containsString:CMStringWithPickFormat(kCMMZWeb_url,@"about/TradingGuideNew.aspx")]) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('join-in')[0].hidden=true"];
        [self TradingGuideNewButton];
    }
    
    if ([webView.request.URL.absoluteString containsString:CMStringWithPickFormat(kCMMZWeb_url,@"About/APPClient")]) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('footer')[0].hidden=true"];
        
       
    }
    
    
}




//隐藏底部footer
-(void)webViewHiddenNot:(id)objc{
    UIWebView *web=(UIWebView*)objc;
    
    if ([web.request.URL.path containsString:@"/Products/Detail"]) {
      
        if (![self.title containsString:@"倍利宝"]) {
            
            
            self.DetailBottomView.ProductDetails=self.ProductDetails;
            [self.view addSubview: self.DetailBottomView];
            [self.view bringSubviewToFront:self.DetailBottomView];
            self.DetailBottomView.hidden=NO;
            self.BLBDetailBottomView.hidden=YES;
            [web  stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('xq-footer')[0].style.display='none'"];
            
        } else{
//            self.BLBDetailBottomView.ProductDetails=self.ProductDetails;
//            [self.view addSubview: self.BLBDetailBottomView];
//            [self.view bringSubviewToFront:self.BLBDetailBottomView];
//            self.BLBDetailBottomView.hidden=NO;
            self.DetailBottomView.hidden=YES;
            
        }
        
    } else{
        
        self.DetailBottomView.hidden=YES;
        self.BLBDetailBottomView.hidden=YES;
        
    }

    
     _webView.hidden=NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    self.nextURL = request.URL.absoluteString;
    MyLog(@"+++%@",self.nextURL);
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('page-header navbar navbar-default navbar-static-top')[0].hidden=true"];
    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Products/FundList")]) {
        //跳转到登录
        [webView stopLoading];

        if (!_isJPush) {
          [self removeController];
        }

        
        CMBeiLiBaoController *webVC = (CMBeiLiBaoController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMBeiLiBaoController"];
        [self.navigationController pushViewController:webVC animated:NO];
        if (_isJPush) {
            [self removeController];
        }
      
   
    
        return NO;
    }
    
    
    
     if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Products/List")]) {
        [webView stopLoading];
         CMSubscribeViewController *webVC = (CMSubscribeViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSubscribeViewController"];
         
         [self.navigationController pushViewController:webVC animated:YES];
         if (_isJPush) {
             [self removeController];
         }
         
         return NO;
     }
    
   
    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Register")]) {
        [webView stopLoading];
        CMRegisterViewController *registerController=(CMRegisterViewController*)[[UIStoryboard loginStoryboard]viewControllerWithId:@"CMRegisterViewController"];
        [self.navigationController pushViewController:registerController animated:YES];
        return NO;
    }
    if ([self.nextURL isEqualToString:@"http://m.xinjingban.com/Account/"]) {
        [webView stopLoading];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    
    if([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url, @"Login")]){
        [webView stopLoading];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    
    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url, @"ApplicationService.html")]) {
        [webView stopLoading];
        CMServiceApplicationViewController *serviceVC = (CMServiceApplicationViewController *)[CMServiceApplicationViewController initByStoryboard];
        [self.navigationController pushViewController:serviceVC animated:YES];
        return NO;
    }
   
    
    
    
    
    if (![self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Account/RechargeRecords")]) {
        if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Account/Recharge")]) {
            UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBarBtn.frame = CGRectMake(0, 0, 100, 40);
            rightBarBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
            [rightBarBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [rightBarBtn setTitle:@"充值记录" forState:UIControlStateNormal];
            [rightBarBtn addTarget:self action:@selector(intoRecharegeRecode) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            
            
        }else{
            UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
            [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
            [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
        }
        
        

    }else{
        UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
        [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
        [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
   
    return YES;
}

       
-(void)intoRecharegeRecode{
    
    [self LoadWebViewWithCookieAndUrl:CMStringWithPickFormat(kCMMZWeb_url,@"Account/RechargeRecords")];
}
-(void)removeController{
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[self class]]) {
            
            [arr removeObject:vc];
            break;
        }
        
    }
    self.navigationController.viewControllers=arr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark CMBLBDetailBottomViewDelegate
-(void)CMBLBDetailBottomViewBtnEventWith:(BLBDetailBtnType)type{
    
    switch (type) {
        case ConsultBtnClick:
            if (CMIsLogin()) {
                [self sendMesage];
            } else {
                UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
                [self presentViewController:nav animated:YES completion:nil];
            }
            break;
        case CollectClick:
            if (CMIsLogin()) {
            } else {
                UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
                [self presentViewController:nav animated:YES completion:nil];
            }
            break;
        case TransferClick: //转让
            self.BLBDetailBottomView.hidden=YES;
            _urlStr=[NSString stringWithFormat:@"%@Invest/Confirm?pid=%ld&pcont=1",kCMMZWeb_url,(long)self.ProductId];
            
            [self loadWebViewData];
            break;
        case RedeemClick: //赎回
            self.BLBDetailBottomView.hidden=YES;
            _urlStr=[NSString stringWithFormat:@"%@Account/FundSubcribeRedeem?productId=%ld",kCMMZWeb_url,(long)self.ProductId];
            [self loadWebViewData];
            break;
            
            
        default:
            break;
    }
    
    
}
#pragma mark CMProductDetailBottomViewDelegate
-(void)CMProductDetailBottomViewBtnEventWith:(ProductDetailbtnType)type{
    
    
    switch (type) {
        case consultingBtnClick:
         
    if (CMIsLogin()) {
         [self sendMesage];
         } else {
             UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
                [self presentViewController:nav animated:YES completion:nil];
           }
      
             //  [self.context evaluateScript:@"topic()"];
       // [self.webView stringByEvaluatingJavaScriptFromString:@"topic()"];

            break;
        case shareBtnClick:
            [self shareView];
            break;
   case collectBtnClick:{

       if (CMIsLogin()) {
                } else {
           UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
           [self presentViewController:nav animated:YES completion:nil];
       }
       
   }
          break;
        case subStateBtnClick:
            
           // if (CMIsLogin()) {
            _urlStr=[NSString stringWithFormat:@"%@Invest/Confirm?pid=%ld",kCMMZWeb_url,(long)self.ProductDetails.productId];
                [self loadWebViewData];
//            } else {
//                UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//                [self presentViewController:nav animated:YES completion:nil];
//            }
//            
            break;
            
        default:
            break;
    }
}

-(void)sendMesage{

   CMConsultingAlertView *ConsultingAlertView=[[CMConsultingAlertView alloc]initWithFrame:self.view.frame];
   ConsultingAlertView.delegate=self;
    [self.view addSubview:ConsultingAlertView];
    [self.view  bringSubviewToFront:ConsultingAlertView];

}
//发送咨询信息
-(void)postConsultingInformation:(NSString*)Information{
    
 
   [CMRequestAPI cm_marketFetchCreateDetailProductPcode:CMStringWithFormat(self.ProductDetails.productId) content:Information success:^(BOOL isWin) {
        
       if(isWin){
          
        [self showHUDWithMessage:@"发布成功!" hiddenDelayTime:2];
          [self.webView reload];
       }
       
   } fail:^(NSError *error) {
       
   }];
    
}



-(void)getProductDetaiWithProductID{
    
    if (self.ProductId) {
    
    [CMRequestAPI cm_applyFetchProductDetailsListProductId:self.ProductId success:^(CMProductDetails *listArr) {
  
            dispatch_async(dispatch_get_main_queue(), ^{
           
                self.ProductDetails=listArr;
                
            });
            
     
        
       
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
        
    }];
        
          }
}

-(void)TradingGuideNewButton{
    UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    CancleBtn.frame=CGRectMake(0, CMScreen_height()-53, CMScreen_width(), 53);
    CancleBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
    [CancleBtn setBackgroundColor:[UIColor clmHex:0xff5b2a]];
    [CancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancleBtn setTitle:@"加入新经板" forState:UIControlStateNormal];
    [CancleBtn addTarget:self action:@selector(TradingGuideNewButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancleBtn];
    [self.view bringSubviewToFront:CancleBtn];
    
}
-(void)TradingGuideNewButtonEvent{
    if (CMIsLogin()) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        CMRegisterViewController *registerController=(CMRegisterViewController*)[[UIStoryboard loginStoryboard]viewControllerWithId:@"CMRegisterViewController"];
        [self.navigationController pushViewController:registerController animated:YES];
    }
    
}


@end
