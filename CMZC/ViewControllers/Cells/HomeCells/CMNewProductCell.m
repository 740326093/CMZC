//
//  CMNewProductCell.m
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMNewProductCell.h"
@interface CMNewProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *PrDetailLab;

@property (weak, nonatomic) IBOutlet UILabel *PrTitleLab;
@end
@implementation CMNewProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPurchaseModel:(CMPurchaseProduct *)purchaseModel
{
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:purchaseModel.picture]];
    _PrTitleLab.text=purchaseModel.title;
    _PrDetailLab.text=purchaseModel.descri;
    
    
}


@end
