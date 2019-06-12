//
//  CMLatestTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/3.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMLatestTableViewCell.h"

@interface CMLatestTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation CMLatestTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
     
}

- (void)setNotice:(CMNewShiModel *)notice {
    
   // [_titleImage sd_setImageWithURL:[NSURL URLWithString:notice.picture] placeholderImage:[UIImage imageNamed:@"title_log"]];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage getImageFromUrl:[NSURL URLWithString:notice.picture] imgViewWidth:CMScreen_width() imgViewHeight:131];
        dispatch_async(dispatch_get_main_queue(), ^{
            _titleImage.image=image;
        });
    });
    
   
    _titleLab.text = notice.title;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
