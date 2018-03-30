//
//  CMAssociateCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAssociateCell.h"
@interface CMAssociateCell()
@property (weak, nonatomic) IBOutlet UILabel *ManagerName;

@property (weak, nonatomic) IBOutlet UILabel *ManagerPoSt;
@property (weak, nonatomic) IBOutlet UIImageView *managerHeadImage;


@end
@implementation CMAssociateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setAgencyModel:(CMAgenceMemberModel *)agencyModel{
    
    _ManagerName.text=agencyModel.THJLName;
    [_managerHeadImage sd_setImageWithURL:[NSURL URLWithString:agencyModel.THJLPhotoPic] placeholderImage:[UIImage imageNamed:@"associateHeadImage"]];
    
}

- (IBAction)CallManagerEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(callManagerEvent)]) {
        [self.delegate callManagerEvent];
    }
    
}


@end
