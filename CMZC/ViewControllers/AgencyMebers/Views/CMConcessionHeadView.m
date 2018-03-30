//
//  CMConcessionHeadView.m
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMConcessionHeadView.h"
#import "CMCircleProgress.h"
@interface CMConcessionHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UILabel *headState;
@property (weak, nonatomic) IBOutlet UILabel *incomeLa;
@property (weak, nonatomic) IBOutlet UILabel *concessionLab;
@property (weak, nonatomic) IBOutlet UILabel *concessionIcomeLab;
@property (weak, nonatomic) IBOutlet CMCircleProgress *circleView;
@property (weak, nonatomic) IBOutlet UILabel *incomeUnitslab;
@property (weak, nonatomic) IBOutlet UILabel *concessionUnitsLab;
@property (weak, nonatomic) IBOutlet UILabel *concessionIncomeUnitsLab;

@end
@implementation CMConcessionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setNewType:(CMAgencesDetailType)newType{
    _newType=newType;
    switch (newType) {
        case CMMyApplyDetail:
            _headState.hidden=YES;
            _concessionIcomeLab.hidden=YES;
            _circleView.hidden=NO;
            _incomeUnitslab.text=@"承销金额(万元)";
            _concessionUnitsLab.text=@"实际承销(万元)";
            _concessionIncomeUnitsLab.text=@"承销进度";
            break;
        case CMMyConcessionDetail:
            _headState.hidden=NO;
            _concessionIcomeLab.hidden=NO;
            _circleView.hidden=YES;
            _incomeUnitslab.text=@"实际承销(万元)";
            _concessionUnitsLab.text=@"佣金(%)";
            _concessionIncomeUnitsLab.text=@"佣金金额(元)";
            break;
        case CMFinancingDetail:
            _headState.hidden=YES;
            _concessionIcomeLab.hidden=YES;
            _circleView.hidden=NO;
            _incomeUnitslab.text=@"融资金额(万元)";
            _concessionUnitsLab.text=@"已申购(万元)";
            _concessionIncomeUnitsLab.text=@"申购进度";
            
            break;
        default:
            break;
    }
    
}

-(void)setApplyModel:(CMApplyModel *)ApplyModel{
    
   // switch (_newType) {
      //  case CMMyApplyDetail:
            _headTitle.text=ApplyModel.cpName;
            _incomeLa.text=ApplyModel.Amount_CX;
            _concessionLab.text=ApplyModel.Amount_SX;
            
            _circleView.progress=ApplyModel.progress;
           
          //  break;
       // case CMMyConcessionDetail:
        
           // break;
        //case CMFinancingDetail:
         
           // break;
        //default:
           // break;
    //}
    
}
-(void)setYongJinListModel:(CMYongJinListModel *)YongJinListModel{
    _headTitle.text=YongJinListModel.cpTitle;
    
    _headState.textColor=YongJinListModel.statusLabColor;
    _headState.text=YongJinListModel.JieSuanStatus;
    
    _incomeLa.text=YongJinListModel.Amount_SX;
    
    _concessionLab.text=YongJinListModel.Percent;
    
    _concessionIcomeLab.text=YongJinListModel.Amount_YongJin;
    
    
    
    
}

-(void)setRongZiDetailTopModel:(CMRongZiDetailTopModel *)RongZiDetailTopModel{
    
    _headTitle.text=RongZiDetailTopModel.cpTitle;
    _incomeLa.text=RongZiDetailTopModel.Amount;
    _concessionLab.text=RongZiDetailTopModel.Amount_SG;
    _circleView.progress=RongZiDetailTopModel.Percent;
    
    
}
@end
