//
//  CMTitleView.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMTitleViewBlock)(NSInteger index,UIButton *selectBtn);

@interface CMTitleView : UIView
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) UIView *markView;
@property (nonatomic,copy) CMTitleViewBlock  block;

@end
