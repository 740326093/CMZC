//
//  CMAssociateDetailCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAssociateDetailCell.h"
@interface CMAssociateDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *leftDetailLab;



@end
@implementation CMAssociateDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLeftImage:(NSString *)leftImage{
    _leftImageView.image=[UIImage imageNamed:leftImage];
    
}
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitleLab.text=leftTitle;
}
-(void)setLeftDetail:(NSString *)leftDetail{
    _leftDetailLab.text=leftDetail;
    
}

@end
