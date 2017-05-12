//
//  CMNoCollectView.m
//  CMZC
//
//  Created by WangWei on 2017/4/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMNoCollectView.h"

@implementation CMNoCollectView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topImage];
        [self addSubview:self.bottomLab];
        
    }
    return self;
}
#pragma mark Lazy
-(UIImageView*)topImage{
    if (!_topImage) {
        _topImage=[[UIImageView alloc]init];
        
    }
    return _topImage;
}
-(UILabel*)bottomLab{
    if (!_bottomLab) {
       
        _bottomLab=[[UILabel alloc]init];
        _bottomLab.textColor=[UIColor clmHex:0x333333];
        _bottomLab.font=[UIFont systemFontOfSize:15.0];
        _bottomLab.textAlignment=NSTextAlignmentCenter;
        
    }
    return _bottomLab;
    
}
   
-(void)setImageName:(NSString *)imageName{
    _topImage.image=[UIImage imageNamed:imageName];
    [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.height.mas_equalTo(_topImage.image.size.height);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(_topImage.image.size.width);
        
    }];
    [_bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topImage.mas_bottom).offset(10);
        make.left.width.equalTo(self);
        make.height.equalTo(@20);
    }];
}


@end
