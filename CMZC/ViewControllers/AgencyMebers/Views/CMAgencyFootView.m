//
//  CMAgencyFootView.m
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyFootView.h"
@interface CMAgencyFootView ()
{
    CGRect myframe;
}

@end
@implementation CMAgencyFootView




-(id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:@"CMAgencyFootView" owner:nil options:nil];
        
        self=[nibs objectAtIndex:0];
        
        
        
        myframe = frame;
        
    }
    
    return self;
    
}

-(void)drawRect:(CGRect)rect

{
    
    self.frame=myframe;//关键点在这里
    
    
}

@end
