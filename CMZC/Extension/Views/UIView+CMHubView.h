//
//  UIView+CMHubView.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CMHubView)

- (void)showHubView:(UIView *)hView messageStr:(NSString *)message time:(NSTimeInterval)tim;

- (void)showHubTacit;

- (void)hideHubTacit;

@end
