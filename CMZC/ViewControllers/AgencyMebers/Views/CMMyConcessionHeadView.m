//
//  CMMyConcessionHeadView.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMyConcessionHeadView.h"
@interface CMMyConcessionHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *totalYongJin;
@property (weak, nonatomic) IBOutlet UILabel *alreadyLab;
@property (weak, nonatomic) IBOutlet UILabel *waitingLab;

@end
@implementation CMMyConcessionHeadView


-(void)setYongjinModel:(CMYongJingHeadModel *)yongjinModel{
    
    _totalYongJin.text=yongjinModel.Amount_YJ_Total;
    _alreadyLab.text=yongjinModel.Amount_YJ_YJS;
    _waitingLab.text=yongjinModel.Amount_YJ_WJS;
    
}

@end
