//
//  CMMyConcessionCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMyConcessionCell.h"
@interface CMMyConcessionCell()

@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *realAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *percentLab;
@property (weak, nonatomic) IBOutlet UILabel *yongAmountlab;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@end

@implementation CMMyConcessionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setYongJinListModel:(CMYongJinListModel *)YongJinListModel{
    
    _statusLab.text=YongJinListModel.JieSuanStatus;
    _statusLab.textColor=YongJinListModel.statusLabColor;
    
    _realAmountLab.text=YongJinListModel.Amount_SX;
    
    _percentLab.text=YongJinListModel.Percent;
    
    _yongAmountlab.text=YongJinListModel.Amount_YongJin;
    
    _titlelab.text=YongJinListModel.cpTitle;
}

@end
