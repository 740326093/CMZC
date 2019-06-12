//
//  CMCentComCell.m
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMCentComCell.h"
@interface CMCentComCell()
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *willCentlab;
@property (weak, nonatomic) IBOutlet UILabel *BillingLab;
@property (weak, nonatomic) IBOutlet UILabel *curStateLab;

@end
@implementation CMCentComCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCentModel:(CMCentModel *)CentModel{
    
    if (CentModel) {
        _phoneLab.text=CentModel.scPhone;
        _dateLab.text=[CentModel.scTime stringByAppendingString:@" 申购"];
        _willCentlab.text=CentModel.scExpectAmount;
        _BillingLab.text=CentModel.scActuaAmount;
        _curStateLab.text=CentModel.scState;
        _curStateLab.textColor=CentModel.scStateColor;
        
    }
    
}
@end
