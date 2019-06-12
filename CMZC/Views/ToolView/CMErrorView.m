//
//  CMErrorView.m
//  CMZC
//
//  Created by 财猫 on 16/5/16.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMErrorView.h"

@implementation CMErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame bgImageName:(NSString *)imageName titleName:(NSString*)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self getImageView:imageName andTitltName:title];
        self.backgroundColor = [UIColor cmBlockColor];
    }
    return self;
}
- (void)getImageView:(NSString *)imageName andTitltName:(NSString*)tittle {
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:imageName];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(100);
    }];
    UILabel *titleName=[[UILabel alloc]init];
    titleName.textColor=[UIColor clmHex:0x999999];
    titleName.font=[UIFont systemFontOfSize:16.0];
    titleName.text=tittle;
    
    [self addSubview:titleName];
    [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(image.mas_bottom).offset(20);
    }];
}
- (void)removeView {
    [self removeFromSuperview];
    
}
@end
