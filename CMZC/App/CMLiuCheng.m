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
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 15)];
        title.text=@"投资流程";
        title.font=[UIFont systemFontOfSize:14.0];
        title.textColor=[UIColor clmHex:0x333333];
        [self addSubview:title];
    
        
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"add_img1-06"];
        image.frame=CGRectMake(40,30, 310, 245/2.0);
        
        [self addSubview:image];
        
        
    }
    return self;
}

@end
