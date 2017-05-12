//
//  CMHoldTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/4.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMHoldTableViewCell.h"


@interface CMHoldTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;

@end

@implementation CMHoldTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)titleName:(NSString *)title introduce:(NSString *)introduce {
    _titleName.text = title;
    _detailsLab.text = introduce;
    
}
@end
