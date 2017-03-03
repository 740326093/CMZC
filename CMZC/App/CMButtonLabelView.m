//
//  CMButtonLabelView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMButtonLabelView.h"

@implementation CMButtonLabelView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomLabel];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(34);
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            
        }];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(14);
            make.centerX.width.equalTo(self);
            make.top.equalTo(self.topImageView.mas_bottom).offset(2);
            
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

-(UILabel*)bottomLabel{
    if (!_bottomLabel) {

        _bottomLabel=[[UILabel alloc]init];
        _bottomLabel.font=[UIFont systemFontOfSize:13.0];
        _bottomLabel.textColor=[UIColor clmHex:0x333333];
        _bottomLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    
    
    return _bottomLabel;
    
}
@end

