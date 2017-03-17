//
//  UITabBar+CMBadage.h
//  CMZC
//
//  Created by WangWei on 17/3/16.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (CMBadage)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
