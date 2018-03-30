//
//  CMSettingNetWorkView.m
//  CMZC
//
//  Created by WangWei on 2018/3/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMSettingNetWorkView.h"
@interface CMSettingNetWorkView ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation CMSettingNetWorkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    _backView.layer.cornerRadius=5.0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}
-(void)dismiss{
    [self removeFromSuperview];
}
@end
