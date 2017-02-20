//
//  CMServerCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMServerCollectionViewCell.h"

@implementation CMServerCollectionViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
    UIImage *image=[UIImage imageNamed:@"strength_brand_home"];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(image.size.height);
        make.width.mas_equalTo(image.size.width);
        make.center.equalTo(self);
    }];
}



@end
