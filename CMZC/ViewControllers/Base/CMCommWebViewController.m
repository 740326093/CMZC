//
//  CMCommWebViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 MAC. All rights reserved.
//

//#define kCMExternalLinksURL @"http://m.xinjingban.com/GrantAccess?targetUrl="
#define kCMExternalLinksURL CMStringWithPickFormat(kCMMZWeb_url, @"/GrantAccess?targetUrl=")
//#define kCMExternalLinksURL @"http://testing.xinjingban.com/GrantAccess?targetUrl="
#import "CMCommWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "CMShareView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CMJsModel.h"
@interface CMCommWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,CMConsultingAlertViewDelegate,CMBLBDetailBottomViewDelegate,UIActionSheetDelegate,CMWebModelDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    
    int photoIndex;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopLayout;

//@property (strong,nonatomic)NSString *currentTitle;
@property (nonatomic,copy) NSString *nextURL;
@property (strong,nonatomic)CMProductDetails *ProductDetails;
@property (copy,nonatomic) NSString *realUrl;
//@property (strong,nonatomic) CMProductDetailBottomView*DetailBottomView;
//@property(strong,nonatomic)CMBLBDetailBottomView *BLBDetailBottomView;
@property (strong,nonatomic) JSContext *context;
@property (strong,nonatomic) CMJsModel *JsModel;
@property (assign,nonatomic) BOOL isNotFirstLoad;
@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *contentTitle;
@property (nonatomic,copy) NSString *imageUrl;

@end

@implementation CMCommWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    
    if ([CMAccountTool sharedCMAccountTool].isLogin) {
    
        
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
 self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    self.realUrl=_urlStr;
    _webView.hidden=YES;
   // [self getProductDetaiWithProductIDWithUrl:_urlStr];
    
   

//
    
   
    
    
    

}


- (void)leftBarBtnClick {
    if ([self.webView canGoBack]) {
        
        if([self.nextURL rangeOfString:@"/Account/RechargeSuccess"].location!=NSNotFound||[self.nextURL rangeOfString:@"yintong.com.cn"].location!=NSNotFound||[self.nextURL rangeOfString:@"lianlianpay.com"].location!=NSNotFound||[_urlStr rangeOfString:self.nextURL].location!=NSNotFound||[self.nextURL rangeOfString:@"type=cmall"].location!=NSNotFound){
        
//        if ([self.nextURL containsString:@"/Account/RechargeSuccess"]|| [self.nextURL containsString:@"yintong.com.cn"]|| [self.nextURL containsString:@"lianlianpay.com"]) {
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
  //  [[NSURLCache sharedURLCache]removeAllCachedResponses];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    
}


- (void)loadWebViewData
{
    
 
    if (!CMIsLogin()) {
//  NSString *url=[[NSBundle mainBundle]pathForResource:@"JavaScriptTest" ofType:@"html"];
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
       NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
        //4.查看请求头
         
        [_webView loadRequest:request];
        _webView.scrollView.bounces = NO;

    } else {
        
        [self LoadWebViewWithCookieAndUrl:_urlStr];
    }
        [self showDefaultProgressHUD];
}

-(void)LoadWebViewWithCookieAndUrl:(NSString*)urlStr{
    
   // NSString *external =[NSString stringWithFormat:@"%@%@",kCMExternalLinksURL,urlStr];
  
 
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];

    //[self loadCookieWith:request];
    //4.查看请求头
   //  [self loadCookies];
   // NSString *name = GetDataFromNSUserDefaults(@"name");
   // NSString *value = GetDataFromNSUserDefaults(@"value");
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    NSString *cookieValue = [NSString stringWithFormat:@"%@=%@",name,value];
//    [mutableRequest addValue:cookieValue forHTTPHeaderField:@"Cookie"];
//
    
    
    
//             //NSString *cookieString = [[NSString alloc] initWithFormat:@"%@=%@",name,value];
    if (GetDataFromNSUserDefaults(@"Set-Cookie")) {


NSDictionary *setCookieDic = [NSDictionary dictionaryWithObject:GetDataFromNSUserDefaults(@"Set-Cookie") forKey:@"Set-Cookie"];
  NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:setCookieDic forURL:[NSURL URLWithString:kCMMZWeb_url]];

               // 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
               [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie  forURL:[NSURL URLWithString:kCMMZWeb_url]                 mainDocumentURL:nil];
              [_webView loadRequest:request];
   
  //  MyLog(@"allHTTPHeaderFields++%@",request.allHTTPHeaderFields);
             _webView.scrollView.bounces = NO;

   }else{

        [self showHUDWithMessage:@"登录失效,请重新登录!" hiddenDelayTime:2];
       DeleteDataFromNSUserDefaults(@"Set-Cookie");
        DeleteDataFromNSUserDefaults(@"userid");

   }
   
    
}

//-(void)loadCookieWith:(NSURLRequest*)request{
//    NSString *name = GetDataFromNSUserDefaults(@"name");
//    NSString *value = GetDataFromNSUserDefaults(@"value");
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    NSString *cookieValue = [NSString stringWithFormat:@"%@=%@",name,value];
//    [mutableRequest addValue:cookieValue forHTTPHeaderField:@"Cookie"];
//
//}

- (void)loadCookies{
    NSString *name = GetDataFromNSUserDefaults(@"name");
    NSString *value = GetDataFromNSUserDefaults(@"value");
  
    if (name==nil&&value==nil) {
        return ;
    }
//    NSMutableDictionary *cookiePreperties = [NSMutableDictionary dictionary];
//    [cookiePreperties setObject:name forKey:NSHTTPCookieName];
//    [cookiePreperties setObject:value forKey:NSHTTPCookieValue];
//
 
NSURL *url= [NSURL URLWithString:self.urlStr];
    MyLog(@"++%@",url.host);
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    NSMutableArray *mutcookies=[NSMutableArray arrayWithArray:cookies];
    
    NSMutableDictionary *cookiePreperties = [NSMutableDictionary dictionary];
    [cookiePreperties setObject:name forKey:NSHTTPCookieName];
    [cookiePreperties setObject:value forKey:NSHTTPCookieValue];
    [cookiePreperties setObject:url.host forKey:NSHTTPCookieDomain];
    [cookiePreperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookiePreperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    NSDictionary *cookiePreperties = [NSDictionary dictionaryWithObjectsAndKeys:
//                           name,NSHTTPCookieName,
//                           value,NSHTTPCookieValue,
//                           @"/",NSHTTPCookiePath,
//                           @"0",NSHTTPCookieVersion,
//                                      [NSURL URLWithString:_urlStr],NSHTTPCookieOriginURL,
//                                      [NSURL URLWithString:_urlStr],NSHTTPCookieOriginURL,
//                         [NSURL URLWithString:_urlStr],NSHTTPCookieOriginURL,
//                           [NSDate dateWithTimeIntervalSinceNow:60*60],NSHTTPCookieExpires,
//                           nil];
    NSHTTPCookie *CustomCookie = [NSHTTPCookie cookieWithProperties:cookiePreperties];
    [mutcookies insertObject:CustomCookie atIndex:0];
    for (NSHTTPCookie *cookie in mutcookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
 
}
#pragma mark 分享
-(void)shareView{
    
    

    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
   shareView.contentUrl =self.realUrl;
    shareView.titleConten = self.ProductDetails.title;
    shareView.controller=self;
//   NSString *content = [NSString stringWithFormat:@"一起来众投,100%%保底保息,预期收益%@(包含保底年收益+浮动)[%@];",self.ProductDetails.income,self.ProductDetails.descri];
   shareView.contentStr = self.ProductDetails.descri;
   shareView.ShareImageName=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.ProductDetails.picture]];
   

}
-(void)pageShareView{
    
  //  MyLog(@"+++%@",self.realUrl);
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies])
//    {
//        [storage deleteCookie:cookie];
//    }
//    //缓存web清除
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
     shareView.contentUrl =self.realUrl;
     shareView.controller=self;
    if(_fromAd){
        
        shareView.titleConten = self.shareTitle;
        shareView.contentStr = self.contentTitle;
        
        if (self.imageUrl.length>0) {
        shareView.ShareImageName=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]]];
           
        }else{
            
          shareView.ShareImageName=[UIImage imageNamed:@"share_image"];
        }
        
        return;
    }
    
   
    shareView.titleConten = self.title;
    shareView.controller=self;
    NSString *content =nil;
    if ([self.realUrl isEqualToString:@"http://m.xjb51.com/listing.aspx"]||[self.realUrl isEqualToString:@"http://m.xinjingban.com/listing.aspx"]) {
      content= @"挂牌融资，就上新经板。十天免费融千万，IPO直通+转板。速度快、流程简单，一站式企业金融服务…";
    }else{
       content=shareView.titleConten;
    }
    shareView.contentStr = content;
    shareView.ShareImageName=[UIImage imageNamed:@"share_image"];
  
    
}
- (void)refreshWebView
{
  // [self loadWebViewData];
   
    
    if ([CMAccountTool sharedCMAccountTool].currentAccount.refresh_token.length >0) {
        [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
            
            [self loadWebViewData];
        } fail:^(NSError *error) {
        }];
    } else {
        [self loadWebViewData];
    }
    
}

//-(CMProductDetailBottomView*)DetailBottomView{
//    if (!_DetailBottomView) {
//        _DetailBottomView=[[CMProductDetailBottomView  alloc]initWithFrame:CGRectMake(0, CMScreen_height()-50, CMScreen_width(), 50)];
//        _DetailBottomView.delegate=self;
//    }
//    return _DetailBottomView;
//}
//-(CMBLBDetailBottomView*)BLBDetailBottomView{
//    if (!_BLBDetailBottomView) {
//        _BLBDetailBottomView=[[CMBLBDetailBottomView  alloc]initWithFrame:CGRectMake(0, CMScreen_height()-50, CMScreen_width(), 50)];
//        _BLBDetailBottomView.delegate=self;
//    }
//    return _BLBDetailBottomView;
//}

#pragma mark - webDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
 
    //包含登录页面
    if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Login")].location!=NSNotFound) {
//
//
//    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Login")]) {
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
   
    

    

    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('page-header navbar navbar-default navbar-static-top')[0].hidden=true"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('live_headbg')[0].hidden=true"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElements.getElementsByClassName('header')[0].hidden=true"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('header')[0].hidden=true"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('header ng-scope')[0].style.display='none'"];
//

//    [webView stringByEvaluatingJavaScriptFromString:@" document.getElementsByTagName('p')[0].innerText='新经板'"];
    
    

    
    
//    if (!webView.loading) {
//        [self performSelector:@selector(webViewHiddenNot:) withObject:webView afterDelay:1.5];
//
//    }

    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.shareTitle=self.title;
    self.imageUrl=[webView stringByEvaluatingJavaScriptFromString:@" document.getElementsByTagName('img')[0].src"];
    self.contentTitle=[webView stringByEvaluatingJavaScriptFromString:@" document.getElementsByTagName('p')[2].innerText"];
    
    if(self.title.length>12){
        self.title=[NSString stringWithFormat:@"%@...",[self.title substringToIndex:11]];
    }
    if ([self.title rangeOfString:@"认证支付"].location!=NSNotFound){
   // if ([self.title containsString:@"连连支付"]) {
        self.TopLayout.constant=-42;//隐藏连连导航
    }else{
         self.TopLayout.constant=0;//隐藏连连导航
    }
    if ([webView.request.URL.absoluteString rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/about/TradingGuideNew.aspx")].location!=NSNotFound) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('join-in')[0].hidden=true"];
        [self TradingGuideNewButton];
    }
    
    if ([webView.request.URL.absoluteString rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/About/APPClient")].location!=NSNotFound) {
        
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('footer')[0].hidden=true"];
        
       
    }
    
    if(self.title){
        if(self.showRefresh==YES){
            
        UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
        [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
        [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        }
    }
    
    
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //异常捕获
    self.context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        MyLog(@"%@", exception);
        con.exception = exception;
    };
    [self hiddenAllProgressHUD];
    _webView.hidden=NO;
   self.JsModel=[[CMJsModel alloc]init];
   self.context[@"XJBapp"]=_JsModel;
    self.JsModel.delegate=self;
    //__weak typeof(self) weakSelf = self;
//    self.context[@"isApp"]=^{
//
//
//        // 取出JS方法的参数
//        NSArray *args = [JSContext currentArguments];
//        for (id obj in args) {
//            MyLog(@"%@",obj); // 打印JS方法接收到的所有参数
//        }
//        [weakSelf appLog];
//    };
  
    
  //  MyLog(@"webViewDidFinishLoad+++%@+++++%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies], webView.request.URL.absoluteString);
    
    //为了解决js对象丢失想到的笨方法，，还没找到合适的
    
    if ([webView.request.URL.absoluteString rangeOfString:@"type=cmall"].location!=NSNotFound&&[webView.request.URL.absoluteString rangeOfString:@"code"].location!=NSNotFound) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *tempCookie in cookies) {
            if ([tempCookie.name rangeOfString:@"xjbcookie"].location!=NSNotFound) {
                [self appLog];
            }
        }
        
    }
        
  
    
    

    
    
    
    
    
    
    
}




//隐藏底部footer
-(void)webViewHiddenNot:(id)objc{
    UIWebView *web=(UIWebView*)objc;
    [self hiddenAllProgressHUD];
    /*
    if ([web.request.URL.path rangeOfString:@"/Products/Detail"].location!=NSNotFound) {
      
        if ([self.title rangeOfString:@"倍利宝"].location==NSNotFound) {
            
            
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

    */
     _webView.hidden=NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
//    NSDictionary *requestHeaders = request.allHTTPHeaderFields;
//
//if (!requestHeaders[@"Cookie"]) {
//
//    NSString *name = GetDataFromNSUserDefaults(@"name");
//    NSString *value = GetDataFromNSUserDefaults(@"value");
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    NSString *cookieValue = [NSString stringWithFormat:@"%@=%@",name,value];
//    [mutableRequest addValue:cookieValue forHTTPHeaderField:@"Cookie"];
//
//       [webView loadRequest:mutableRequest];
//    return NO;
//}
   
    
    
    self.nextURL = request.URL.absoluteString;
  //  MyLog(@"+++%@",self.nextURL);
//    if ([self.nextURL rangeOfString:@"Products/NewFundListByCMall?type=cmall&page=fundlistbycmall&code="].location!=NSNotFound) {
//      
//        
//        [self LoadWebViewWithCookieAndUrl:self.nextURL];
//    }
     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('page-header navbar navbar-default navbar-static-top')[0].hidden=true"];
if ([self.nextURL rangeOfString:@"pid"].location!=NSNotFound) {
    _showRefresh=NO;
    
    
}
    if ([self.nextURL rangeOfString:@"RobFound_New"].location!=NSNotFound) {
        _showRefresh=YES;
        
        
    }
//    if ([self.nextURL rangeOfString:@"/Products/Detail"].location!=NSNotFound) {
//        [self getProductDetaiWithProductIDWithUrl:self.nextURL];
//    }
//
    if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Products/FundList")].location!=NSNotFound) {
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
    
    
    
     if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Products/List")].location!=NSNotFound) {
        [webView stopLoading];
         CMSubscribeViewController *webVC = (CMSubscribeViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSubscribeViewController"];
         
         [self.navigationController pushViewController:webVC animated:YES];
         if (_isJPush) {
             [self removeController];
         }
         
         return NO;
     }
    if ([self.nextURL isEqualToString:CMStringWithPickFormat(kCMMZWeb_url,@"/Account/")]) {
        [webView stopLoading];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        return NO;
    }
   
    if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Register")].location!=NSNotFound) {
        [webView stopLoading];
        CMRegisterViewController *registerController=(CMRegisterViewController*)[[UIStoryboard loginStoryboard]viewControllerWithId:@"CMRegisterViewController"];
        [self.navigationController pushViewController:registerController animated:YES];
        return NO;
    }
    if ([self.nextURL isEqualToString:@"http://m.xjb51.com/Account/"]||[self.nextURL isEqualToString:@"http://m.xinjingban.com/Account/"]) {
        [webView stopLoading];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    
    if ([self.nextURL isEqualToString:CMStringWithPickFormat(kCMMZWeb_url, @"/")]) {
        [webView stopLoading];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    
    if([self.nextURL rangeOfString:@"Login"].location!=NSNotFound){
        [webView stopLoading];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    if([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url, @"/Login")].location!=NSNotFound){
        [webView stopLoading];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    
    if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url, @"/ApplicationService.html")].location!=NSNotFound) {
        [webView stopLoading];
        CMServiceApplicationViewController *serviceVC = (CMServiceApplicationViewController *)[CMServiceApplicationViewController initByStoryboard];
        [self.navigationController pushViewController:serviceVC animated:YES];
        return NO;
    }
   
    
    
    
    
    if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Account/RechargeRecords")].location==NSNotFound) {
        
        if ([self.nextURL rangeOfString:CMStringWithPickFormat(kCMMZWeb_url,@"/Account/Recharge")].location!=NSNotFound) {
            UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBarBtn.frame = CGRectMake(0, 0, 100, 40);
            rightBarBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
            [rightBarBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [rightBarBtn setTitle:@"充值记录" forState:UIControlStateNormal];
            [rightBarBtn addTarget:self action:@selector(intoRecharegeRecode) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            
            
        }
        

        
    }else{
        
        if(self.showRefresh==YES){
            
            UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
            [rightBarBtn setImage:[UIImage imageNamed:@"newShare"] forState:UIControlStateNormal];
            [rightBarBtn addTarget:self action:@selector(pageShareView) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            
            
        }else{
              self.navigationItem.rightBarButtonItem = nil;
        }
        
    }


   
    
    
    
   
    return YES;
}

       
-(void)intoRecharegeRecode{
    
    [self LoadWebViewWithCookieAndUrl:CMStringWithPickFormat(kCMMZWeb_url,@"/Account/RechargeRecords")];
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
            //self.BLBDetailBottomView.hidden=YES;
           // _urlStr=[NSString stringWithFormat:@"%@/Invest/Confirm?pid=%ld&pcont=1",kCMMZWeb_url,(long)self.ProductId];
            
            [self loadWebViewData];
            break;
        case RedeemClick: //赎回
           // self.BLBDetailBottomView.hidden=YES;
            _urlStr=[NSString stringWithFormat:@"%@/Account/FundSubcribeRedeem?productId=%ld",kCMMZWeb_url,(long)self.ProductId];
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
            _urlStr=[NSString stringWithFormat:@"%@/Invest/Confirm?pid=%ld&pcont=1",kCMMZWeb_url,(long)self.ProductDetails.productId];
            if([self.nextURL rangeOfString:@"type=cmall"].location!=NSNotFound){
            _urlStr=[NSString stringWithFormat:@"%@/Invest/Confirm?pid=%ld&type=cmall",kCMMZWeb_url,(long)self.ProductDetails.productId];
            }
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



-(void)getProductDetaiWithProductIDWithUrl:(NSString*)urlstr{
    NSDictionary *urlParmeter=[self parameterWithURL:[NSURL URLWithString:urlstr]];
    
    if (urlParmeter[@"pid"]) {
        self.ProductId=[urlParmeter[@"pid"]integerValue];
    
    }
    
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


-(NSDictionary *) parameterWithURL:(NSURL *) url {
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    
    return parm;
    
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
#pragma mark  JS分享
- (void)share:(NSString *)title describeContent:(NSString *)content interlnkageSite:(NSString *)siteUrl pictureStie:(NSString *)pictureUrl {
    
    MyLog(@"分享share:%@",title);
  
    CMShareView *shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height())];
    shareView.contentUrl =siteUrl;
    shareView.titleConten = title;
    shareView.controller=self;
    shareView.contentStr = content;
    shareView.ShareImageName=[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureUrl]];

    
}
-(void)appLogin{
    
    UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)appLog{
    
MyLog(@"webViewDidFinishLoad+++++%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
[self cookieLogin];
            

    
    
    
    
}
#pragma mark 调用相机和相册

-(void)callCameraOrPhotosLibrary:(int)type{
    photoIndex=type;
       dispatch_async(dispatch_get_main_queue(), ^{
            
            UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"相机", @"从相册选择", nil ,nil];
            // 显示
            [actionsheet showInView:self.view];
           
            
            
   });
        
 

    
}
-(void)cookieLogin{
    
    NSDictionary *dict = @{
                           @"client_id":@"CC67712F-4614-40CF-824E-10D784C2A3D7",
                           @"client_secret":@"c0aa7577b892ff2ff4ee0109f2932321",
                           @"grant_type":@"password",
                           @"platform":@"1"
                           };
    NSMutableDictionary *MutableDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    if ([JPUSHService registrationID]) {
        
        [MutableDict setObject:[JPUSHService registrationID] forKey:@"id"];
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPMaximumConnectionsPerHost = 8;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kCMBaseApiURL] sessionConfiguration:configuration];
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    
    NSURLSessionDataTask *dataTask = [manager POST:kCMLoginURL parameters:MutableDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"errcode"] integerValue] == 0) {
            //删除
            DeleteDataFromNSUserDefaults(@"value");
            DeleteDataFromNSUserDefaults(@"userid");
            //获得cookies
            NSDictionary *fields = [(NSHTTPURLResponse *)task.response allHeaderFields];
            //  NSLog(@"fields :%@",fields);
            //  NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:[NSURL URLWithString:kCMBaseApiURL]];
            
            //NSHTTPCookie *cookie = cookies.firstObject;
            //  NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kCMBaseApiURL]];
            DeleteDataFromNSUserDefaults(kVerifyStareDateKey);
            
            NSString *cookieString = [fields valueForKey:@"Set-Cookie"];
            NSArray *arr= [cookieString componentsSeparatedByString:@";"];
            NSString *newString=arr.firstObject;
            NSArray *arr1= [newString componentsSeparatedByString:@"="];
            MyLog(@"++%@",newString);
            // if(cookie.name&&cookie.value){
            // SaveDataToNSUserDefaults(cookie.name, @"name");
            // SaveDataToNSUserDefaults(cookie.value, @"value");
            // }else{
            SaveDataToNSUserDefaults(arr1.firstObject, @"name");
            SaveDataToNSUserDefaults(arr1.lastObject, @"value");
            SaveDataToNSUserDefaults(newString, @"Set-Cookie");
            SaveDataToNSUserDefaults([NSDate date], kVerifyStareDateKey);
            //}
            
            CMAccount *loginAccount = [[CMAccount alloc] initWithDict:responseObject];
             [[CMAccountTool sharedCMAccountTool] addAccount:loginAccount];
            //存储以下当前时间
            [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
                MyLog(@" account : %@",account);
               
                SaveDataToNSUserDefaults(account.userid, @"userid");
                loginAccount.userName=account.sj;
                SaveDataToNSUserDefaults(account.sj, @"accountName");
                [[CMAccountTool sharedCMAccountTool] addAccount:loginAccount];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginWin" object:self];
            } fail:^(NSError *error) {
                
            }];
            
           
         
        } else {
            NSError *cmError = [NSError errorWithDomain:responseObject[@"errmsg"] code:[responseObject[@"errcode"] integerValue] message:[NSString errorMessageWithCode:[responseObject[@"errcode"] integerValue]]];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code==-1011) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *body = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
            
            if (body) {
                
               
            }
        }else{
            //请求失败
            
            NSError *cmError = [NSError errorWithDomain:error.domain code:error.code message:[NSString errorMessageWithCode:error.code]];
           
        }
        
        
        
    }];
    
    [dataTask resume];
    

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    MyLog(@"buttonIndex=%ld", buttonIndex);
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    picker.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    picker.navigationBar.barTintColor =[UIColor cmThemeCheng];
    //判断是否可以打开照相机
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            MyLog(@"相机为来源");
        }
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            //图片库
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            MyLog(@"图片库为来源");
        }
        
     
    }
    
   [ self  presentViewController:picker animated:YES completion:nil];
   
}




-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [CMRequestAPI cm_upLoadPic:resultImage success:^(NSString *urlPath) {
        
        if (urlPath) {
            
            NSString *jsFunctStr = [NSString stringWithFormat:@"callback('%@','%d')",urlPath,photoIndex];
            
            [_context evaluateScript:jsFunctStr];
        }
        
        
        
        
    } fail:^(NSError *error) {
        
    }];
  

    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//点击cancle按钮是调用的协议方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}






@end
