//
//  CMCodeAlert.m
//  CMZC
//
//  Created by WangWei on 2019/4/20.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMCodeAlert.h"
#import <WebKit/WebKit.h>
#import "CMWeakScriptMessageDelegate.h"

@interface CMCodeAlert ()<VPEmbedManagerDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (nonatomic, strong) VPEmbedManager *embedManager;
@property (nonatomic, strong) UIView  *bottomView;
//@property (nonatomic, strong) UIView  *BackContentView;

@property (strong, nonatomic) WKWebView *VaptchaWebView;

@property (nonnull, nonatomic, strong) CMWeakScriptMessageDelegate *handlerHelper;



@end
@implementation CMCodeAlert

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.frame=CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
        
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        
      UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
       [self.bottomView addGestureRecognizer:tap];
        //弹框背景
        [self addSubview:self.VaptchaWebView];
      //  5dce3a0b8713b71e70a41eba

     // 5b4d9c33a485e50410192331 demo
        
    [self.VaptchaWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://v.vaptcha.com/app/ios.html?vid=%@&lang=zh-CN&offline_server=https://www.vaptchadowntime.com/dometime",VPSDKAppKey]]]];
     
        
   
//        CGSize defaultSize = [self viewDefaultSize];
//        [self addSubview:self.embedManager.embedView];
//        CGFloat width = defaultSize.width;
//        CGFloat percentage = [VPEmbedManager embedViewWidthHeightPercentage];
//        [self.embedManager.embedView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(self);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(self.embedManager.embedView.mas_width).multipliedBy(1/percentage);
//        }];
//
//
    }
    return self;
}



#pragma mark Lazy
-(UIView*)bottomView{
    
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=[UIColor blackColor];
        _bottomView.alpha=0.52f;
    }
    return _bottomView;
    
}

//-(UIView*)BackContentView{
//    
//    if (!_BackContentView) {
//        _BackContentView=[[UIView alloc]init];
//        _BackContentView.backgroundColor=[UIColor whiteColor];
//        _BackContentView.layer.cornerRadius=5.0;
//        _BackContentView.clipsToBounds=YES;
//    }
//    return _BackContentView;
//    
//}

//设置webView
- (WKWebView *)VaptchaWebView {
    if (!_VaptchaWebView) {
        
        CGFloat hwPer =200/115;
        
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _VaptchaWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width*hwPer )
                                             configuration:configuration];
        _VaptchaWebView.navigationDelegate = self;

        CGRect centerFrame =_VaptchaWebView.frame;
        centerFrame.origin.y=self.center.y-self.bounds.size.width*hwPer/2.0;
        _VaptchaWebView.frame=centerFrame;
        
        [_VaptchaWebView.configuration.userContentController addScriptMessageHandler:self.handlerHelper name:@"signal"];
        //
       // [self addSubview:_VaptchaWebView];
        _VaptchaWebView.alpha = 0;
    }
    return _VaptchaWebView;
}

//设置helper
- (CMWeakScriptMessageDelegate *)handlerHelper {
    if (!_handlerHelper) {
        _handlerHelper = [[CMWeakScriptMessageDelegate alloc] initWithDelegate:self];
    }
    return _handlerHelper;
}
- (VPEmbedManager *)embedManager {
    if (!_embedManager) {
        _embedManager = [VPEmbedManager new];
        _embedManager.delegate = self;
    }
    return _embedManager;
}
- (CGSize)viewDefaultSize {
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGFloat min = MIN(screenFrame.size.width, screenFrame.size.height);
    min = MIN(min, 414.0);
    return CGSizeMake(min-15*2, 40.0);
}


-(void)dismissView{
     [self.VaptchaWebView.configuration.userContentController removeScriptMessageHandlerForName:@"signal"];
    [self removeFromSuperview];
    self.VaptchaWebView=nil;
}


-(void)resetCode{
    [self.embedManager reset];
}
#pragma mark Delagate
- (void)embedManagerVerifyPassedWithToken:(NSString *)token{
    
    
    if (token.length>0) {
        [self dismissView];
        [self.embedManager reset];
        if ([self.delagete respondsToSelector:@selector(validSuccessWithToken:)]) {
            [self.delagete validSuccessWithToken:token];
        }
    }
    
}
#pragma mark - WKNavigationDelegate
//
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    self.VaptchaWebView.alpha=1.0;
    
}


#pragma mark - WKScriptMessageHandler
//
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"signal"]) {
        //解析返回结果
        id body = message.body;
        MyLog(@"%@",body);
        if ([body isKindOfClass:NSString.class]) {
            NSString *jsonString = body;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            NSString *token =resultDic[@"data"];

            if (resultDic) {
                if ([resultDic[@"signal"] isEqualToString:@"pass"]) {
                  if (token.length>0) {
                      [self dismissView];
                      if ([self.delagete respondsToSelector:@selector(validSuccessWithToken:)]) {
                          [self.delagete validSuccessWithToken:token];
                      }
                  }
                    
                    
                }else if ([resultDic[@"signal"] isEqualToString:@"cancel"]) {
                    [self dismissView];
                }else if ([resultDic[@"signal"] isEqualToString:@"error"]) {
                    
                    
                }
            }
          

           
        }
    }
}



@end
