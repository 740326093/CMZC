//
//  CMBarHeadView.m
//  CMZC
//
//  Created by WangWei on 17/3/3.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMBarHeadView.h"

@implementation CMBarHeadView

+(UIView*)barHeadViewWithImage:(NSString *)image{
    
    
    UIImage *imageName=[UIImage imageNamed:image];
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreen_width(), f_i5real(imageName.size.height));
    bgView.contentMode=UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds=YES;
    bgView.image=imageName;
    return bgView;
    
    
}
@end
