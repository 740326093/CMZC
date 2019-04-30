//
//  CMjackDetailCell.m
//  CMZC
//
//  Created by WangWei on 2019/3/20.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMjackDetailCell.h"
@interface CMjackDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *supplyLab;

@property (weak, nonatomic) IBOutlet UILabel *num_01;

@property (weak, nonatomic) IBOutlet UILabel *SubNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *numbwe_03;

@end
@implementation CMjackDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPrwin:(CMWinning *)Prwin{
    
    _supplyLab.text =Prwin.jptime;
    _num_01.text = Prwin.numCount;
    _SubNumberLab.text = Prwin.phtime;
    _numbwe_03.text = Prwin.zqNum;
    
    
    
}
@end
