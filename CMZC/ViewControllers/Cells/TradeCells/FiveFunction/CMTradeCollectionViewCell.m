//
//  CMTradeCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeCollectionViewCell.h"

@interface CMTradeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;//头像image
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//买入lab
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;//介绍lab

@end


@implementation CMTradeCollectionViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
}
- (void)cm_tradeCollectionNameStr:(NSString *)name introduceStr:(NSString *)introduce titleImageName:(NSString *)titImage {
    _nameLab.text = name;
    _introduceLab.text = introduce;
    _titleImage.image = [UIImage imageNamed:titImage];
    [_titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_titleImage.image.size.height);
        make.width.mas_equalTo(_titleImage.image.size.width);
        make.centerY.equalTo(self);
    }];
}


@end
