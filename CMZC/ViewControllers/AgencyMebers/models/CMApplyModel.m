//
//  CMApplyModel.m
//  CMZC
//
//  Created by WangWei on 2018/3/9.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMApplyModel.h"

@implementation CMApplyModel
-(float)progress{
    float sx=[_Amount_SX floatValue]; //实销
    float cx=[_Amount_CX floatValue];  //承销
    //NSString *flaotStr=[NSString stringWithFormat:@"%.2f",sx/cx];
    
    return round(sx/cx*100)/100;
}
@end
