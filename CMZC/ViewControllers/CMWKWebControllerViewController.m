//
//  CMWKWebControllerViewController.m
//  CMZC
//
//  Created by WangWei on 2017/6/7.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMWKWebControllerViewController.h"
#import <WebKit/WebKit.h>

#define kCMExternalLinksURL CMStringWithPickFormat(kCMMZWeb_url, @"GrantAccess?targetUrl=")
@interface CMWKWebControllerViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *wkWeb;
@property(nonatomic,copy)NSString *tranStr;
@end

@implementation CMWKWebControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.wkWeb = [[WKWebView alloc]
                  initWithFrame:CGRectMake(0, 60, CMScreen_width(), CMScreen_height()-60)];
    self.wkWeb.navigationDelegate=self;
   
   
    [self loadWebViewData];
    [self.view addSubview:self.wkWeb];
    
//   [self.wkWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
 
    if ([keyPath isEqualToString:@"title"])
    {
        self.tranStr=self.wkWeb.title;
        
        self.title=self.tranStr;
        if ([self.title containsString:@"连连支付"] ) {
            
                [self.wkWeb evaluateJavaScript:@"document.documentElement.getElementsByClassName('header')[0].hidden=true" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    
                }];
//            [self.wkWeb evaluateJavaScript:@"document.documentElement.getElementsByClassName('header ng-scope')[0].hidden=true" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                
//            }];
//            
            
                [self.wkWeb evaluateJavaScript:@"document.documentElement.getElementsByClassName('ng-binding')[4].innerText='ceshi'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    MyLog(@"void+++%@",response);
                }];
            [self.wkWeb removeObserver:self forKeyPath:@"title"];
                [self.wkWeb reload];
           
        }
        
    }
 
}

 */
- (void)loadWebViewData
{
    
    
    if (!CMIsLogin()) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
        
        //4.查看请求头
        [self.wkWeb loadRequest:request];
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
    [self.wkWeb loadRequest:request];
    //  MyLog(@"allHTTPHeaderFields++%@",request.allHTTPHeaderFields);
  
    
   
    
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
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   MyLog(@"didStartProvisionalNavigation");
    
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    MyLog(@"didReceiveServerRedirectForProvisionalNavigation");
 
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
     MyLog(@"didCommitNavigation");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
   MyLog(@"didFinishNavigation");
   // MyLog(@"++%@",webView.URL.absoluteString);
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        self.title=(NSString*)response;
        
    }];
    
    [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('page-header navbar navbar-default navbar-static-top')[0].hidden=true" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    
        
    }];
 
        
     [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        MyLog(@"void+++%@",response);
         if([response isEqualToString:@"complete"]){
             
            if ([webView.URL.absoluteString containsString:@"https://wap.lianlianpay.com/index.html#"]) {
 
                 [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('header')[0].hidden=true" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                     
                 }];
          
                
                 [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('ng-binding')[4].innerText='ceshi'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                     
                 }];
            }

         }
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
