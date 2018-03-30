//
//  CMMySubCell.m
//  CMZC
//
//  Created by WangWei on 2017/12/5.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMMySubCell.h"
@interface CMMySubCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;


@end
@implementation CMMySubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cm_functionTileLabNameStr:(NSString *)titName
                   titleImageName:(NSString *)imgName{
    
    
    _leftImage.image=[UIImage imageNamed:imgName];
    _namelabel.text=titName;
    
}
@end
