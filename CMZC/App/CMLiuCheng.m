//
//  CMLiuCheng.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMLiuCheng.h"

@implementation CMLiuCheng
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 40)];
        title.text=@"投资流程";
        title.font=[UIFont systemFontOfSize:17.0];
        title.textColor=[UIColor clmHex:0x111111];
        [self addSubview:title];
    
        UIImage *imagebg=[UIImage imageNamed:@"add_img1-06"];
        UIImageView *image=[[UIImageView alloc]init];
        image.image=imagebg;
  
        [self addSubview:image];
        [image mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(25);
            make.width.mas_equalTo(imagebg.size.width);
            make.height.mas_equalTo(imagebg.size.height);
            make.top.equalTo(title.mas_bottom);
        }];
        
        
    }
    return self;
}

@end
