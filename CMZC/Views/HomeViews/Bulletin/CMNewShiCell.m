//
//  CMNewShiCell.m
//  CMZC
//
//  Created by WangWei on 17/2/24.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMNewShiCell.h"

@implementation CMNewShiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
-(void)setShiModel:(CMNewShiModel *)ShiModel{
    _ShiModel=ShiModel;
    _nameLabel.text=ShiModel.title;
    _datelabel.text=ShiModel.created;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
