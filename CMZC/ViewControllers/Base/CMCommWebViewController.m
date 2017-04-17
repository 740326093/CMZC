//
//  CMCommWebViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

//#define kCMExternalLinksURL @"http://m.xinjingban.com/GrantAccess?targetUrl="
#define kCMExternalLinksURL CMStringWithPickFormat(kCMMZWeb_url, @"GrantAccess?targetUrl=")
//#define kCMExternalLinksURL @"http://testing.xinjingban.com/GrantAccess?targetUrl="
#import "CMCommWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

#import "CMShareView.h"
#import <TFHpple.h>

@interface CMCommWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,CMConsultingAlertViewDelegate,CMJSProtocolDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic)NSString *currentURL;
@property (strong,nonatomic)NSString *currentTitle;
@property (nonatomic,copy) NSString *nextURL;
@property (strong,nonatomic)CMProductDetails *ProductDetails;
@property (copy,nonatomic) NSString *realUrl;
@property (strong,nonatomic) CMProductDetailBottomView*DetailBottomView;
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
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
   
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [rightBarBtn setImage:[UIImage imageNamed:@"refresh_line_thren"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.realUrl=_urlStr;

    [self getProductDetaiWithProductID];
}
//http://m.xinjingban.com/Account/Recharge

- (void)leftBarBtnClick {
    if ([self.webView canGoBack]) {
        if ([self.nextURL containsString:@"/Account/RechargeSuccess"]|| [self.nextURL containsString:@"yintong.com.cn"]) {
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
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


- (void)loadWebViewData
{
    
  //  _urlStr=@"http://192.168.1.225:8886/Products/Detail?pid=55463";
  // _urlStr=@"https://mp.58ycf.com/live/home/details?liveid=306";
    if (!CMIsLogin()) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];

        //4.查看请求头
        [_webView loadRequest:request];
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
    } else {
        [self LoadWebViewWithCookieAndUrl:_urlStr];
    }
    
   
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
    self.currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // 获取当前页面的title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.currentURL = webView.request.URL.absoluteString;
 
    if ([webView.request.URL.path containsString:@"/Products/Detail"]&&![self.currentTitle containsString:@"倍利宝"]) {
        
        self.DetailBottomView.ProductDetails=self.ProductDetails;
     [self.view addSubview: self.DetailBottomView];
        [self.view bringSubviewToFront:self.DetailBottomView];
        self.DetailBottomView.hidden=NO;
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('xq-footer')[0].style.display='none'"];
        
        
        
    }    else{
        self.DetailBottomView.hidden=YES;
        
    }
   
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    self.nextURL = request.URL.absoluteString;
   
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
         UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
         CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
         tab.selectedIndex = 1;
         if (_isJPush) {
             [self removeController];
         }
         
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
            [rightBarBtn setImage:[UIImage imageNamed:@"refresh_line_thren"] forState:UIControlStateNormal];
            [rightBarBtn addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
        }
        
        

    }else{
        UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
        [rightBarBtn setImage:[UIImage imageNamed:@"refresh_line_thren"] forState:UIControlStateNormal];
        [rightBarBtn addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    if ([webView.request.URL.path containsString:@"/Products/Detail"]&&![[webView stringByEvaluatingJavaScriptFromString:@"document.title"] containsString:@"倍利宝"]) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('xq-footer')[0].style.display='none'"];
        
        
        
    }
    
    return YES;
}

- (void)share:(NSString *)key{
      MyLog(@"Get:%@", key);
  

    
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


@end
