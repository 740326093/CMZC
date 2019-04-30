//
//  CMSliderTitleCell.m
//  CMZC
//
//  Created by WangWei on 2019/3/6.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMSliderTitleCell.h"

@implementation CMSliderTitleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.linView];
//        [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@1);
//            make.left.right.bottom.equalTo(self.contentView);
//        }];
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.top.bottom.equalTo(self.contentView);
        // make.bottom.equalTo(self.linView.mas_top);
            
        }];
    }
    
    return self;
}




-(UILabel*)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=[UIColor whiteColor];
        _titleLab.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLab;
}
-(UIView*)linView{
    if (!_linView) {
        
        _linView=[[UIView alloc]init];
        //_linView.backgroundColor=[UIColor cmThemeCheng];
    }
    
    return _linView;
    
}
@end
