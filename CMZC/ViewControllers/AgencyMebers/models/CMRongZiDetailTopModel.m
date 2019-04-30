//
//  CMRongZiDetailTopModel.m
//  CMZC
//
//  Created by WangWei on 2018/3/24.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMRongZiDetailTopModel.h"

@implementation CMRongZiDetailTopModel
-(NSString*)Amount_SG{
    if ([_Amount_SG floatValue]>0) {
        return _Amount_SG;
    }else{
        
        return @"--";
    }
    
}

@end
