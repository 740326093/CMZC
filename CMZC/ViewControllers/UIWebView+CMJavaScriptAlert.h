//
//  UIWebView+CMJavaScriptAlert.h
//  CMZC
//
//  Created by WangWei on 2017/12/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (CMJavaScriptAlert)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;
@end
