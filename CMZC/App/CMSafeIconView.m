//
//  CMSafeIconView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMSafeIconView.h"

@implementation CMSafeIconView
-(instancetype)init{
    self=[super init];
    if (self) {
        
        [self addSubview:self.topImageView];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self);
            make.height.mas_equalTo(f_i5real(70));
            make.width.mas_equalTo(f_i5real(70));
        }];
        [self addSubview:self.midLabel];
        [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(self);
            make.top.equalTo(self.topImageView.mas_bottom).offset(10);
            make.height.equalTo(@15);
            
        }];
        
        [self addSubview:self.bottomLabel];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.midLabel.mas_bottom).offset(5);
            make.height.equalTo(@90);
            
        }];
       
        
    }
    return self;
}

-(UIImageView*)topImageView{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc]init];
    }
    return _topImageView;
}
-(UILabel*)midLabel{
    if (!_midLabel) {
        _midLabel=[[UILabel alloc]init];
        _midLabel.textAlignment=NSTextAlignmentCenter;
        _midLabel.font=[UIFont systemFontOfSize:14.0];
        _midLabel.textColor=[UIColor clmHex:0x111111];
    }
    return _midLabel;
}
-(UILabel*)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.textAlignment=NSTextAlignmentCenter;
        _bottomLabel.font=[UIFont systemFontOfSize:11.0];
        _bottomLabel.textColor=[UIColor clmHex:0x666666];
        _bottomLabel.numberOfLines=4;
        _bottomLabel.contentMode=UIViewContentModeTop;

    }
    return _bottomLabel;
}


@end
