//
//  CMWkWebViewController.m
//  CMZC
//
//  Created by 云财富 on 2019/10/14.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMWkWebViewController.h"
#import <WebKit/WebKit.h>
#import "CMWeakScriptMessageDelegate.h"
static NSString *injectJS = @"var JSBridge = {};var xd_jscallback_center={_callbackbuf:{},addCallback:function(a,c){\"function\"==typeof c&&(this._callbackbuf[a]=c)},fireCallback:function(a,c){if(\"string\"==typeof a){var f=this._callbackbuf[a];\"function\"==typeof f&&(void 0===c?f():f(c))}}};";
static NSString *patternJS = @"%@.%@=function(){var a=arguments.length,e={methodName:\"%@\"},l=Array.from(arguments);a>0&&(\"function\"==typeof l[a-1]?(e.callbackId=\"%@\",e.params=a-1>0?l.slice(0,a-1):[]):e.params=l),null!=e.callbackId&&xd_jscallback_center.addCallback(e.callbackId,l[a-1]),window.webkit.messageHandlers.WKJB.postMessage(e)};";



@interface CMWkWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
@property (copy, nonatomic) NSString *nextUrl;

@end

@implementation CMWkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (@available(ios 11.0,*)){ self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.view addSubview:self.webView];
    

    [self requestLoadUrlWithUrl:@"http://192.168.1.213:8080"];
    [self initNavUI];
    [self.webView addObserver:self forKeyPath:@"URL"options:NSKeyValueObservingOptionNew context:nil];
    [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    
//    /// 监听将要弹起
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow) name:UIKeyboardWillShowNotification object:nil];
//    /// 监听将要隐藏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    
}

#pragma mark - addObserverKeyboard
/// 键盘将要弹起
- (void)keyBoardShow {
    //    CGPoint point = self.webView.scrollView.contentOffset;
    //    self.keyBoardPoint = point;
    if (@available(iOS 12.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    
}
/// 键盘将要隐藏
- (void)keyBoardHidden {
    // self.webView.scrollView.contentOffset = self.keyBoardPoint;
    if (@available(iOS 12.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}



#pragma mark Lazy
- (WKWebView *)webView {
    if (!_webView) {
        // 进行配置控制器
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // 实例化对象
        configuration.userContentController = [WKUserContentController new];
        //  configuration.allowsInlineMediaPlayback=YES;
        
        
#pragma mark 开始注入JS方法  隐藏导航
        //  NSString *jsFounction =@"function hideOther(){var headers = document.getElementsByTagName('header');var lastHeader =headers[headers.length-1];lastHeader.remove();}";
        
        NSString *jsFounction=@"function hideOther(){setTimeout(function(){var headers = document.getElementsByTagName('header');var lastHeader=headers[headers.length-1];lastHeader.remove();var headerOne = document.getElementsByClassName('header');var lastHeaderOne=headerOne[headerOne.length-1];lastHeaderOne.remove(); }, 200);}";
        
        // 根据JS字符串初始化WKUserScript对象
        WKUserScript *script = [[WKUserScript alloc] initWithSource:jsFounction injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:script];
        
        
        
        
#pragma mark 开始注入JS方法  获取标题
        NSString *titleFounction =@"function getTitle(){var titleStr =document.getElementsByClassName('mint-header-title')[0].innerText;window.webkit.messageHandlers.showMessage.postMessage(titleStr);}";
        WKUserScript *scriptOne = [[WKUserScript alloc] initWithSource:titleFounction injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:scriptOne];
        
        
       /*
#pragma mark 开始注入JS方法 注入cookie
        
        NSString *appStr = @"ycfappid";
        NSString *appid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSData *cookieData = GetDataFromNSUserDefaults(@"cookieData");
        NSMutableArray *cookiesArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:cookieData]];
        NSHTTPCookie *cookie=cookiesArr.firstObject;
        
        
        NSString *cookString=[NSString stringWithFormat:@"document.cookie ='%@=%@';document.cookie = '%@=%@';",appStr,appid,cookie.name,cookie.value];
        
        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:cookString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:cookieScript];
        */
       
      
        
        NSString *name = GetDataFromNSUserDefaults(@"name");
        NSString *value = GetDataFromNSUserDefaults(@"value");
        
        NSString *cookString=[NSString stringWithFormat:@"document.cookie = '%@=%@';",name,value];
        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:cookString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:cookieScript];
#pragma mark 开始注入JS方法  银行理财隐藏导航
        // NSString *bankjsFounction =@"function hideBankOther(){var headers = document.getElementsByClassName('vux-header');var lastHeader=headers[headers.length-1];lastHeader.remove();}";
        
        NSString *timeJs=@"function hideBankOther(){setTimeout(function(){var headers = document.getElementsByClassName('vux-header');var lastHeader=headers[headers.length-1];lastHeader.remove(); }, 1000);}";
        
        
        // var timer=setInterval(function() {var header = document.querySelector('.header');if (header) {header.parentNode.removeChild(header);document.querySelector('p.ng-binding').innerHTML='北京云财富金融服务外包股份有限公司';clearInterval(timer);}});
        //    NSString *bankjsFounction =@"function hideBankOther(){var headers = document.getElementsByClassName('vux-header'); headers.parentNode.removeChild(headers);}";
        // 根据JS字符串初始化WKUserScript对象
        WKUserScript *bankscript = [[WKUserScript alloc] initWithSource:timeJs injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:bankscript];
        
        /*
         #pragma mark 开始注入JS方法  获取Video
         NSString *videojsFounction =@"function getVideo(){var Media = document.getElementById('videoNEW');Media.play();}";
         // 根据JS字符串初始化WKUserScript对象
         WKUserScript *videoscript = [[WKUserScript alloc] initWithSource:videojsFounction injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
         [configuration.userContentController addUserScript:videoscript];
         
         */
        
#pragma mark 开始注入JS方法  银行理财获取标题
        
        
        // NSString *banktitleFounction =@"function getBankTitle(){var titleStr =document.getElementsByClassName('xheader-title')[0].innerText;window.webkit.messageHandlers.showMessage.postMessage(titleStr);}";
        NSString *banktitleFounction=@"function getBankTitle(){setTimeout(function(){var titleStr =document.getElementsByClassName('xheader-title')[0].innerText;window.webkit.messageHandlers.showMessage.postMessage(titleStr);},1000);}";
        
        WKUserScript *BankscriptOne = [[WKUserScript alloc] initWithSource:banktitleFounction injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:BankscriptOne];
        
        
        
#pragma mark 开始注入JS方法  理财获取标题
        
        
        
        NSString *LCtitleFounction=@"function getLCTitle(){setTimeout(function(){var titleStr =document.getElementsByClassName('headerCt')[0].innerText;window.webkit.messageHandlers.showMessage.postMessage(titleStr);},1000);}";
        
        WKUserScript *LcscriptOne = [[WKUserScript alloc] initWithSource:LCtitleFounction injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:LcscriptOne];
        
        
        
        
        CMWeakScriptMessageDelegate *weakMessage=[[CMWeakScriptMessageDelegate alloc]initWithDelegate:self];
        //配置调用方法的名称
        [configuration.userContentController addScriptMessageHandler:weakMessage name:@"showMessage"];
        
#pragma mark 注入js交互方法
        [configuration.userContentController addScriptMessageHandler:weakMessage name:@"WKJB"];
        
        
#pragma mark 注入js方法
        WKUserScript *injectScript = [[WKUserScript alloc] initWithSource:injectJS injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:injectScript];
#pragma mark 注入js对象
        NSString *jsObjectName=@"XJBapp";
        NSString *jsStr = [NSString stringWithFormat:@"var %@ = {};",jsObjectName];
        WKUserScript *JSObjectScript = [[WKUserScript alloc] initWithSource:jsStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:JSObjectScript];
        /*
#pragma mark 注入js方法名称
        NSString *jsActiveName=@"webGoBack";
        NSString *jsMethodStr = [NSString stringWithFormat:patternJS,jsObjectName,jsActiveName,jsActiveName,jsActiveName];
        WKUserScript *methodScript = [[WKUserScript alloc] initWithSource:jsMethodStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:methodScript];
        
        NSString *jsActiveBack=@"GoHome";
        NSString *jsMethodBackStr = [NSString stringWithFormat:patternJS,jsObjectName,jsActiveBack,jsActiveBack,jsActiveBack];
        WKUserScript *methodBackScript = [[WKUserScript alloc] initWithSource:jsMethodBackStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:methodBackScript];
        
        
        NSString *jsActiveCode=@"getBankCode";
        NSString *jsMethodCodeStr = [NSString stringWithFormat:patternJS,jsObjectName,jsActiveCode,jsActiveCode,jsActiveCode];
        WKUserScript *methodCodeScript = [[WKUserScript alloc] initWithSource:jsMethodCodeStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:methodCodeScript];
         */
#pragma mark 注入js分享方法名称
        NSString *jsShareCode=@"share";
        NSString *jsMethodShareCodeStr = [NSString stringWithFormat:patternJS,jsObjectName,jsShareCode,jsShareCode,jsShareCode];
        WKUserScript *methodShareCodeScript = [[WKUserScript alloc] initWithSource:jsMethodShareCodeStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [configuration.userContentController addUserScript:methodShareCodeScript];
        
   
        
        // 进行偏好设置
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptEnabled = YES;
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        //   preferences.minimumFontSize = 0.0;
        configuration.preferences = preferences;
        

        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:configuration];
        
        _webView.scrollView.bounces=NO;
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        
#pragma mark 注入浏览器表示
    
        if (@available(iOS 12.0, *)){
            NSString *baseAgent = [_webView valueForKey:@"applicationNameForUserAgent"];
            NSString *userAgent = [NSString stringWithFormat:@"%@ XJBapp",baseAgent];
            [_webView setValue:userAgent forKey:@"applicationNameForUserAgent"];
        }
        
        [_webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            
            NSString *oldAgent = result;
            if ([oldAgent rangeOfString:@"XJBapp"].location != NSNotFound) {
                return ;
            }
            NSString *newAgent = [NSString stringWithFormat:@"%@ %@", oldAgent, @"ycfapp"];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (@available(iOS 9.0, *)) {
                [self->_webView setCustomUserAgent:newAgent];
            } else {
                [self->_webView setValue:newAgent forKey:@"applicationNameForUserAgent"];
            }
        }];
        
    }
    return _webView;
}

-(void)initNavUI
{
    self.navigationController.navigationItem.hidesBackButton=YES;
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];//p_fenxiang
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
}


#pragma mark BtnClick
//返回按钮
- (void)leftBarBtnClick
{
    
    
    WKBackForwardList * backForwardList = [self.webView backForwardList];
    //可返回的页面列表, 存储已打开过的网页
    // DLog(@"返回列表+++%@",backForwardList.backItem.URL.absoluteString);
    if (backForwardList.backItem.URL.absoluteString.length>0||[backForwardList.backItem.URL.absoluteString rangeOfString:@"mainpage"].location ==NSNotFound) {
        
        [backForwardList.backList enumerateObjectsUsingBlock:^(WKBackForwardListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.URL.absoluteString rangeOfString:@"pay"].location !=NSNotFound||[obj.URL.absoluteString rangeOfString:@"finish"].location !=NSNotFound) {
                //  DLog(@"返回+++%ld+++++%@",idx,obj.URL.absoluteString);
                
                //  DLog(@"返回列表+++%@",backForwardList.backList);
                if(idx==0){
                    
                    [self.webView goBack];
                    return ;
                }
                if (idx-1>0) {
                    
                    [self.webView goToBackForwardListItem:backForwardList.backList[idx-1]];
                }else{
                    [self.webView goToBackForwardListItem:backForwardList.backList.firstObject];
                }
                
                
            }else{
                // WKNavigation *navgation=          [self.webView  goBack];
                
                if (self.webView.canGoBack==YES) {
                    //返回上级页面
                    // [self.webView goBack];
                    [self.webView evaluateJavaScript:@"window.history.back()" completionHandler:^(id object, NSError * _Nullable error) {
                    }];
                    
                    if([backForwardList.backItem.URL.absoluteString rangeOfString:@"digitalin"].location !=NSNotFound&&[backForwardList.backItem.URL.absoluteString rangeOfString:@"index"].location!=NSNotFound){
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                    
                }
                //  [self.webView goToBackForwardListItem:backForwardList.backItem];
                
            }
            
            
        }];
        
        
       
        
    } else {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}


-(void)requestLoadUrlWithUrl:(NSString*)url{
    
    
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    if (CMIsLogin()) {
        
        
//        NSData *cookieData = GetDataFromNSUserDefaults(@"cookieData");
//
//        NSMutableArray *cookiesArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:cookieData]];
//        NSHTTPCookie *cookie=cookiesArr.firstObject;
        NSString *name = GetDataFromNSUserDefaults(@"name");
        NSString *value = GetDataFromNSUserDefaults(@"value");
        
        
//        if (cookie.value&&cookie.name) {
//            NSString *cookieStr=[NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
//            [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];
//        }
        
                if (value&&name) {
                    NSString *cookieStr=[NSString stringWithFormat:@"%@=%@",name,value];
                    [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];
                }
    }
    
    
    [self.webView loadRequest: request];
    
    
    
    
    
}


#pragma mark 实现WKNavigationDelegate代理方法

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //  DLog(@"页面开始加载时调用");
    
//    NSData *cookieData = GetDataFromNSUserDefaults(@"cookieData");
//
//    NSMutableArray *cookiesArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:cookieData]];
//    NSHTTPCookie *cookie=cookiesArr.firstObject;
//    NSString *name = GetDataFromNSUserDefaults(@"name");
//    NSString *value = GetDataFromNSUserDefaults(@"value");
//
//    NSString *cookString=[NSString stringWithFormat:@"document.cookie = '%@=%@';",name,value];
//
//    [webView evaluateJavaScript:cookString completionHandler:nil];
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容开始返回时调用");
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    
    
    NSLog(@"加载完成");
    
    [self.webView evaluateJavaScript:@"document.getElementsByTagName('title')[0].innerText" completionHandler:^(id object, NSError * _Nullable error) {
        //  DLog(@"obj:%@---error:%@", object, error);
        if(object){
            self.title=(NSString*)object;
        }
    }];
    [self.webView evaluateJavaScript:@"document.getElementsByClassName('title')[0].innerText" completionHandler:^(id object, NSError * _Nullable error) {
        //  DLog(@"obj:%@---error:%@", object, error);
        if(object){
            self.title=(NSString*)object;
        }
    }];

    [self.webView evaluateJavaScript:@"backToday()" completionHandler:^(id object, NSError * _Nullable error) {
         NSLog(@"aa:%@---error:%@", object, error);
        
    }];
    
    [self.webView evaluateJavaScript:@"hideOther()" completionHandler:^(id object, NSError * _Nullable error) {
        
        
    }];
    
    [self.webView evaluateJavaScript:@"getLCTitle()" completionHandler:^(id object, NSError * _Nullable error) {
        // DLog(@"getTitle():%@---error:%@", object, error);
    }];
    
    [self.webView evaluateJavaScript:@"getTitle()" completionHandler:^(id object, NSError * _Nullable error) {
        // DLog(@"getTitle():%@---error:%@", object, error);
    }];
    
    
   /*
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect navRect = self.navigationController.navigationBar.frame;
    CGFloat navHeight=  statusRect.size.height+navRect.size.height;
    
    // CGFloat tabbarHeight=self.tabBarController.tabBar.bounds.size.height;
    
    
    
    
    
    
    
    if (self.webView.frame.size.height ==kScreenHeight) {
        
        
        self.webView.frame=CGRectMake(self.webView.frame.origin.x,
                                      self.webView.frame.origin.y, self.webView.frame.size.width,kScreenHeight-navHeight);
        //        if (_fromHome==YES ) {
        //
        //
        //            self.webView.frame=CGRectMake(self.webView.frame.origin.x,
        //                                         self.webView.frame.origin.y, self.webView.frame.size.width,kScreenHeight-navHeight-tabbarHeight);
        //        }
        
        
    }else{
        
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        
        //DLog(@"systemVersion:%.f-", systemVersion.doubleValue);
        if (systemVersion.doubleValue<11.0) {
            
            self.webView.frame=CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width,kScreenHeight-(navHeight));
        }
        
    }
    
    [MBProgressHUD hiddenProgressHUD:self.view];
    ///Product/CurrentBtl/Buy
    if ([webView.URL.absoluteString rangeOfString:@"/Product/CurrentBtl/Buy"].location !=NSNotFound) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shSuccess" object:nil];
        
    }
    */
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载失败时调用");
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    //DLog(@"接收到服务器跳转请求之后再执行");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"在收到响应后，决定是否跳转");
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"在发送请求之前，决定是否跳转");
    //这句是必须加上的，不然会异常
    
    //DLog(@"-----%@",requestURL.absoluteString);
    
    
    //此处是在页面跳转时，防止cookie丢失做的处理
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    NSDictionary *headFields = navigationAction.request.allHTTPHeaderFields;
    
    
    NSString *cookie = headFields[@"Cookie"];
    if (cookie == nil) {
        if(CMIsLogin()){
            //在跳转新的web页面时，把cookie传过去
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:navigationAction.request.URL];
//            NSData *cookieData = GetDataFromNSUserDefaults(@"cookieData");
//
//            NSMutableArray *cookiesArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:cookieData]];
//            NSHTTPCookie *cookie=cookiesArr.firstObject;
//            if (cookie.value&&cookie.name) {
//                NSString *cookieStr=[NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
//                [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];
//            }
            NSString *name = GetDataFromNSUserDefaults(@"name");
            NSString *value = GetDataFromNSUserDefaults(@"value");
            
            if (value&&name) {
                                NSString *cookieStr=[NSString stringWithFormat:@"%@=%@",name,value];
                                [request addValue:cookieStr forHTTPHeaderField:@"Cookie"];
              }
          [webView loadRequest:request];
            policy = WKNavigationActionPolicyCancel;
        }
    }
    
    
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    
    self.nextUrl = navigationAction.request.URL.absoluteString;
    if ([self.nextUrl rangeOfString:@"Login"].location !=NSNotFound) {//登录
        
        [webView stopLoading]; // webView停止加载 弹出登录页面
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    return;
    }
    
//        if ([[self.nextUrl lowercaseString] rangeOfString:@"/member/user/bank"].location !=NSNotFound||[[self.nextUrl lowercaseString] rangeOfString:@"/member/user/userbtl"].location !=NSNotFound) {
//            //  DLog(@"++++++%@",self.navigationController.viewControllers);
//            for (UIViewController *tempController in self.navigationController.viewControllers) {
//
//                if ([tempController isKindOfClass:[CFBTLViewController class]]||[tempController isKindOfClass:[CFBankLiCaiController class]]) {
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"shSuccess" object:nil];
//                    [self.navigationController popToViewController:tempController animated:YES];
//
//                    decisionHandler(WKNavigationActionPolicyCancel);
//                    return;
//
//                }
//
//            }
//
//
//
//        }
    
        
        
        
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // DLog(@"%@",NSStringFromSelector(_cmd));
     NSLog(@"%@",message);
    
 
    if ([message.name isEqualToString:@"showMessage"]) {
        self.title=message.body;
        
    }
    if ([message.name isEqualToString:@"WKJB"]) {
        NSDictionary *methodDict=message.body;
        
        if (methodDict) {
            NSString *methodName=methodDict[@"methodName"];
            
           
            
        }
        
    }
    
}
#pragma mark 实现WKUIDelegate代理事件,主要实现与js的交互

//显示一个JS的Alert（与JS交互）

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"runJavaScriptAlertPanelWithMessage");
}

//弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
}

//显示一个确认框（JS的）

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    NSLog(@"runJavaScriptConfirmPanelWithMessage");
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    [self.webView evaluateJavaScript:@"hideOther()" completionHandler:^(id object, NSError * _Nullable error) {
        
        
    }];
    if ([keyPath isEqualToString:@"URL"]){
        
 NSLog(@"URl++++%@",change);
    }
    
    
    
    
}



- (void)dealloc{
    
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:@"showMessage"];
    
    [self.webView removeObserver:self forKeyPath:@"URL"];
    
    
}
@end
