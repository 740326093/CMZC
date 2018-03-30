//
//  CMConcessionDetailCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMConcessionDetailCell.h"
@interface CMConcessionDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *lenderNameLab;
@property (weak, nonatomic) IBOutlet UILabel *lenderTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *lenderImage;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyunitLab;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyUnitLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *unitRightConstraints;

@end
@implementation CMConcessionDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setNewType:(CMAgencesDetailType)newType{
    
    switch (newType) {
        case CMMyApplyDetail:
        {
            _payMoneyLab.hidden=YES;
            _payMoneyunitLab.hidden=YES;
            _rightMoneyUnitLab.text=@"购买";
            _rightMoneyUnitLab.textAlignment=NSTextAlignmentRight;
            _rightMoneyLab.textAlignment=NSTextAlignmentRight;
            _rightConstraints.constant=10;
            _unitRightConstraints.constant=10;
            _lenderImage.hidden=YES;
        }
            break;
        case CMMyConcessionDetail:
        {
            _payMoneyLab.hidden=NO;
            _payMoneyunitLab.hidden=NO;
            _rightMoneyUnitLab.text=@"返佣(元)";
            _rightMoneyUnitLab.textAlignment=NSTextAlignmentCenter;
            _rightMoneyLab.textAlignment=NSTextAlignmentCenter;
            _rightConstraints.constant=0;
            _unitRightConstraints.constant=0;
            _lenderImage.hidden=YES;
        }
            break;
        case CMFinancingDetail:
        {
            _payMoneyLab.hidden=YES;
            _payMoneyunitLab.hidden=YES;
            _rightMoneyUnitLab.text=@"购买";
            _rightMoneyUnitLab.textAlignment=NSTextAlignmentRight;
            _rightMoneyLab.textAlignment=NSTextAlignmentRight;
            _rightConstraints.constant=10;
            _unitRightConstraints.constant=10;
            _lenderImage.hidden=YES;
        }
            break;
            
        default:
            break;
    }
}
-(void)setListMode:(CMCSDetailListModel *)listMode{
    
    _lenderNameLab.text=listMode.sname;
    _lenderTimeLab.text=listMode.jptime;
    _rightMoneyLab.text=listMode.jpamount;
    
}
-(void)setYongJinDetailListModel:(CMYongJinDetailListModel *)YongJinDetailListModel{
    
    _lenderNameLab.text=YongJinDetailListModel.XingMing;
    _lenderTimeLab.text=YongJinDetailListModel.jptime;
    _payMoneyLab.text=YongJinDetailListModel.jpamount;
    _rightMoneyLab.text=YongJinDetailListModel.Amount_YongJin;
    
}
-(void)setRongZiDetailList:(CMRongZiDetailList *)RongZiDetailList{
    
    _lenderNameLab.text=RongZiDetailList.sname;
    _lenderTimeLab.text=RongZiDetailList.jptime;
    _rightMoneyLab.text=RongZiDetailList.jpamount;
    if (RongZiDetailList.IsLingTou) {
        _lenderImage.hidden=NO;
    }else{
        _lenderImage.hidden=YES;
    }
}
@end
