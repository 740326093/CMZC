//
//  CMErrorView.h
//  CMZC
//
//  Created by 财猫 on 16/5/16.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMErrorView : UIView
/**
 *  初始化view
 *
 *  @param frame     坐标
 *  @param imageName 图片名字
 */
- (instancetype)initWithFrame:(CGRect)frame bgImageName:(NSString *)imageName titleName:(NSString*)title;

- (void)removeView;

@end
