//
//  CMApplyListCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMApplyListCell.h"
#import "CMCircleProgress.h"

@interface CMApplyListCell ()
@property (weak, nonatomic) IBOutlet UILabel *applyTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *applyAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadAppliAmountLab;
@property (weak, nonatomic) IBOutlet CMCircleProgress *ApplyProgressView;

@property (weak, nonatomic) IBOutlet UIButton *projectBtnState;

@property (weak, nonatomic) IBOutlet UILabel *applyAmountDesLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadyApplyDesLab;

@property (weak, nonatomic) IBOutlet UILabel *progressDesLab;
@property (weak, nonatomic) IBOutlet UIImageView *listImage;

@end
@implementation CMApplyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _projectBtnState.layer.cornerRadius=4.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(NSInteger)type{
    _type=type;
    switch (type) {
        case 1:
        {  //融资
            _applyAmountDesLab.text=@"融资金额(万元)";
            _alreadyApplyDesLab.text=@"已申购(万元)";
            _progressDesLab.text=@"申购进度";
            
        }
            
            break;
        case 2:
        {  //承销
            _applyAmountDesLab.text=@"承销金额(万元)";
            _alreadyApplyDesLab.text=@"实际承销(万元)";
            _progressDesLab.text=@"承销进度";
            [_projectBtnState setTitle:@"分享" forState:UIControlStateNormal];
            [_projectBtnState setBackgroundColor:[UIColor clmHex:0xff6400]];
            
        }
            break;
        case 3:
        {  //领投
            _applyAmountDesLab.text=@"融资金额(万元)";
            _alreadyApplyDesLab.text=@"领投金额(万元)";
            _progressDesLab.text=@"领投比例";
            
            
        }
            
            break;
            
        default:
            break;
    }
    
    
}


-(void)setApplyModel:(CMApplyModel *)applyModel{
  //  MyLog(@"+++%@",applyModel);
    _applyModel=applyModel;
    _applyTitleLab.text=applyModel.cpName;
    _applyAmountLab.text=applyModel.Amount_CX;
    _alreadAppliAmountLab.text=applyModel.Amount_SX;
    _ApplyProgressView.progress=applyModel.progress;
   
    [_projectBtnState setTitle:@"分享" forState:UIControlStateNormal];
    [_projectBtnState setBackgroundColor:[UIColor clmHex:0xff6400]];
}
-(void)setRongZiModel:(CMRongZiModel *)RongZiModel{
    
    _applyTitleLab.text=RongZiModel.cpName;
    _applyAmountLab.text=RongZiModel.Amount;
    _alreadAppliAmountLab.text=RongZiModel.shengouAmount;
    _ApplyProgressView.progress=RongZiModel.rongziJinDu;
    
    [_projectBtnState setTitle:RongZiModel.cpStatusText forState:UIControlStateNormal];
    [_projectBtnState setBackgroundColor:RongZiModel.Btncolor];
    if (RongZiModel.enterDetail) {
        _listImage.hidden=NO;
    }else{
        _listImage.hidden=YES;
        
    }
    
    
    
}
-(void)setLingTouModel:(CMLingTouModel *)LingTouModel{
    _LingTouModel=LingTouModel;
    _applyTitleLab.text=LingTouModel.cpTitle;
    _applyAmountLab.text=LingTouModel.Amount;
    _alreadAppliAmountLab.text=LingTouModel.LingTouAmount;
    
    _ApplyProgressView.progress=LingTouModel.LingTouPercent;
    
    [_projectBtnState setTitle:LingTouModel.ProdeuctStatus forState:UIControlStateNormal];
    [_projectBtnState setBackgroundColor:LingTouModel.btnColor];
   
    
}
- (IBAction)clickEvent:(id)sender {
    switch (_type) {
        case 2:
            if ([self.delegate respondsToSelector:@selector(ApplyShareEventWith:)]) {
                [self.delegate ApplyShareEventWith:_applyModel];
            }

            break;
//        case 3:
//            if (_LingTouModel.isConsult) {
//                if ([self.delegate respondsToSelector:@selector(LiTouZiXunEvent:)]) {
//                    [self.delegate LiTouZiXunEvent:_LingTouModel];
//                }
//            }
//            
            
            break;
            
        default:
            break;
    }
   
    
}
@end
