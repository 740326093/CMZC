//
//  CMMediaNewsCell.m
//  CMZC
//
//  Created by WangWei on 2017/5/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMMediaNewsCell.h"

@implementation CMMediaNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setShiModel:(CMNewShiModel *)ShiModel{

    _titleLab.text=ShiModel.title;
    _detailLab.text=ShiModel.descrip;
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:ShiModel.picture] placeholderImage:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
