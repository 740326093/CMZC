//
//  CMOptionCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/4/6.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMOptionCollectionViewCell.h"

@interface CMOptionCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


@implementation CMOptionCollectionViewCell

- (void)cm_optionCollectionCellTitleImageName:(NSString *)titleName nameLabStr:(NSString *)nameStr {
    _titleImage.image = [UIImage imageNamed:titleName];
    _nameLab.text = nameStr;
    [_titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_titleImage.image.size.height);
        make.width.mas_equalTo(_titleImage.image.size.width);
        make.centerX.equalTo(self);
    }];
}

@end
