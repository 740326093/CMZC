//
//  CMFunctionTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMFunctionTableViewCell.h"

@interface CMFunctionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;


@end


@implementation CMFunctionTableViewCell

- (void)awakeFromNib {
     
     [super awakeFromNib];
    _messageLabel.layer.cornerRadius=10.0;
    _messageLabel.clipsToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cm_functionTileLabNameStr:(NSString *)titName titleImageName:(NSString *)imgName {
    _nameLab.text = titName;
    _titleImage.image = [UIImage imageNamed:imgName];
    
    [_titleImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_titleImage.image.size.height);
        make.width.mas_equalTo(_titleImage.image.size.width);
        make.centerY.equalTo(self);
    }];
}



@end
