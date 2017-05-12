//
//  CMServeReusableView.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMServeReusableView.h"

@implementation CMServeReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.backgroundColor=[UIColor clmHex:0xEFEFF4];
        [self addSubview:self.titleLab];
        
    }
    return self;
}

-(UILabel*)titleLab{
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        _titleLab.textColor = [UIColor cmTacitlyFontColor];
    }
    return _titleLab;
}
@end
