//
//  CMBillingCell.m
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMBillingCell.h"
@interface CMBillingCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *amounLab;

@end
@implementation CMBillingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBillingMode:(CMBillingModel *)BillingMode{
    
    _dateLab.text=BillingMode.sscSettleTime;
    _amounLab.text=BillingMode.sscSettleAmount;
}
@end
