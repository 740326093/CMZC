//
//  CMBaseViewController+HUD.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMBaseViewController+HUD.h"
#import <WebKit/WebKit.h>
@implementation CMBaseViewController (HUD)

// 显示默认加载框
- (void)showDefaultProgressHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = nil;
}

// 隐藏最新加入的加载框
- (void)hiddenProgressHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// 隐藏所有的加载框
- (void)hiddenAllProgressHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

// 弹出一个1秒后自动隐藏的HUD
- (void)showAutoHiddenHUDWithMessage:(NSString *)message {
    [self showHUDWithMessage:message hiddenDelayTime:1.0];
}

// 弹出一个`delayTime`秒后自动隐藏的HUD
- (void)showHUDWithMessage:(NSString *)message hiddenDelayTime:(NSTimeInterval)delayTime {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    
    [hud hide:YES afterDelay:delayTime];
}

- (void)showIsLoginViewController {
    if (!CMIsLogin()) {
        UIViewController *logingVC = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:logingVC animated:YES completion:nil];
    }
}
/*
+(void)load{
    
//    const char *className = object_getClassName(self);
//    if([[NSString stringWithUTF8String:className] isEqualToString:@"CMWKWebControllerViewController"]){
    //交换方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        //webViewDidFinishLoad:
//        SEL originalSelector = @selector(webView:didFinishNavigation:);
//        SEL swizzledSelector = @selector(statisticalPage_webViewDidFinishLoad:);
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(statisticalPage_viewDidAppear:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
    //}
    
}

- (void)statisticalPage_viewDidAppear:(BOOL)animated {

    [self statisticalPage_viewDidAppear:animated];
    
        const char *className = object_getClassName(self);
        if([[NSString stringWithUTF8String:className] isEqualToString:@"CMWKWebControllerViewController"]){
    //交换方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        //webViewDidFinishLoad:
                SEL originalSelector = @selector(webView:didFinishNavigation:);
                SEL swizzledSelector = @selector(statisticalPage_webViewDidFinishLoad:);
       
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
    }

    
}
-(void)statisticalPage_webViewDidFinishLoad:(WKWebView*)webView {

    MyLog(@"web+++%@",webView);
    

}
 */

@end
