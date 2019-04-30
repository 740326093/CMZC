//
//  CMHotApplyCell.m
//  CMZC
//
//  Created by WangWei on 2018/3/12.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMHotApplyCell.h"
#import "CMCircleProgress.h"
@interface CMHotApplyCell ()

@property (weak, nonatomic) IBOutlet UILabel *applyTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *applyAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadAppliAmountLab;
@property (weak, nonatomic) IBOutlet CMCircleProgress *ApplyProgressView;

@property (weak, nonatomic) IBOutlet UIButton *projectBtnState;

@property (weak, nonatomic) IBOutlet UILabel *applyAmountDesLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadyApplyDesLab;

@property (weak, nonatomic) IBOutlet UILabel *progressDesLab;

@end
@implementation CMHotApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _projectBtnState.layer.cornerRadius=4.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)applyEventClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(applyChengXiaoEventWith:)]) {
        [self.delegate applyChengXiaoEventWith:_HotApplyModel.cpid];
    }
    
}


-(void)setHotApplyModel:(CMHotApplyModel *)HotApplyModel{
    
    _HotApplyModel=HotApplyModel;
    _applyTitleLab.text=HotApplyModel.cpName;
    _applyAmountLab.text=HotApplyModel.Amount;
    _alreadAppliAmountLab.text=HotApplyModel.shengouAmount;
    _ApplyProgressView.realProgress=YES;
    _ApplyProgressView.progress=HotApplyModel.rongziJinDu;
    
}
@end
