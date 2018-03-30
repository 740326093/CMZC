//
//  UIWebView+CMJavaScriptAlert.m
//  CMZC
//
//  Created by WangWei on 2017/12/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "UIWebView+CMJavaScriptAlert.h"

@implementation UIWebView (CMJavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame {
  
     UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
     [dialogue show];
  
    
}
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame{
    return NO;
}
@end
