//
//  CMMebersHeadView.m
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMMebersHeadView.h"
@interface CMMebersHeadView()
@property (weak, nonatomic) IBOutlet UILabel *totalIncome;
@property (weak, nonatomic) IBOutlet UILabel *totalDesLab;

@property (weak, nonatomic) IBOutlet UILabel *curDayIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *investNumLab;
@property (weak, nonatomic) IBOutlet UILabel *leadPrNum;
@property (weak, nonatomic) IBOutlet UILabel *leadPrNam;


@end
@implementation CMMebersHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: _leadPrNam.text attributes:attribtDic];
    //赋值
    _leadPrNam.attributedText = attribtStr;
    
    
}

-(void)setAgenceMemberModel:(CMAgenceMemberModel *)AgenceMemberModel{
    _AgenceMemberModel=AgenceMemberModel;
    _totalIncome.text=AgenceMemberModel.Amount_Lj;
    
    _investNumLab.text=AgenceMemberModel.Tzr_Count;
    
    _curDayIncomeLab.text=AgenceMemberModel.YongJin_Today;

    if(AgenceMemberModel.OrgType==1){
         _leadPrNam.text=@"融资项目(个) >";
        
        _totalDesLab.text=@"累计融资额(万元)";
    }else if (AgenceMemberModel.OrgType==2){
          _leadPrNam.text=@"承销项目(个) >";
        _totalDesLab.text=@"累计承销额(万元)";
    }else if (AgenceMemberModel.OrgType==3){
        _leadPrNam.text=@"领投项目(个) >";
        _totalDesLab.text=@"累计领投额(万元)";
    }else{
        
        _leadPrNam.text=@"承销项目(个)>";
        _totalDesLab.text=@"累计承销额(万元)";
    }
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: _leadPrNam.text attributes:attribtDic];
    //赋值
    _leadPrNam.attributedText = attribtStr;
    
    _leadPrNum.text=AgenceMemberModel.ProjectCount;
}
- (IBAction)enterPrDetail:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(enterMyApplyListWithType:)]) {
        [self.delegate enterMyApplyListWithType:_AgenceMemberModel.OrgType];
    }
}

@end
