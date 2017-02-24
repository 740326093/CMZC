//
//  CMServerCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMServerCollectionViewCell.h"

@implementation CMServerCollectionViewCell



-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.titleImage];
        
    }
    
    return self;
}
-(UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage=[[UIImageView alloc]init];
    }
    return _titleImage;
    
}
-(void)setImageString:(NSString *)imageString{
    
   self.titleImage.image=[UIImage imageNamed:imageString];
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.titleImage.image.size.height);
        make.width.mas_equalTo(self.titleImage.image.size.width);
        make.center.equalTo(self);
    }];
}

@end
