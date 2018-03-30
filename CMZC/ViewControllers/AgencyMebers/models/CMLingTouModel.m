//
//  CMLingTouModel.m
//  CMZC
//
//  Created by WangWei on 2018/3/22.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMLingTouModel.h"

@implementation CMLingTouModel

-(UIColor*)btnColor{
    if ([_ProdeuctStatus isEqualToString:@"待审核"]) {
        return [UIColor clmHex:0xffb600];
    }else if ([_ProdeuctStatus isEqualToString:@"审核中"]){
        
        return [UIColor clmHex:0x39b54a];
    }else if ([_ProdeuctStatus isEqualToString:@"审核未通过"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_ProdeuctStatus isEqualToString:@"审核未通过"]){
        
        return [UIColor clmHex:0xff6400];
    }
    else if ([_ProdeuctStatus isEqualToString:@"融资已结束"]){
        
        return [UIColor clmHex:0xcacaca];
    }
    else if ([_ProdeuctStatus isEqualToString:@"待上架"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_ProdeuctStatus isEqualToString:@"即将开始"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_ProdeuctStatus isEqualToString:@"融资进行中"]){
        
        return [UIColor clmHex:0xff6400];
    }
    else if ([_ProdeuctStatus isEqualToString:@"申购暂停"]){
        
        return [UIColor clmHex:0xcacaca];
    }
    else if ([_ProdeuctStatus isEqualToString:@"预热中"]){
        
        return [UIColor clmHex:0xfe9900];
    }
    else if ([_ProdeuctStatus isEqualToString:@"预订中"]){
        
        return [UIColor clmHex:0xfe9900];
    }
    else if ([_ProdeuctStatus isEqualToString:@"路演中"]){
        
        return [UIColor clmHex:0xfe9900];
    }
    else if ([_ProdeuctStatus isEqualToString:@"预定结束"]){
        
        return [UIColor clmHex:0xcacaca];
    }
    else if ([_ProdeuctStatus isEqualToString:@"预订结束"]){
        
        return [UIColor clmHex:0xcacaca];
    } else if ([_ProdeuctStatus isEqualToString:@"路演结束"]){
        
        return [UIColor clmHex:0xcacaca];
    }else{
        
        return [UIColor clmHex:0xff6400];
    }
    
}
//-(BOOL)isConsult{
//    if ([_ProdeuctStatus isEqualToString:@"融资进行中"]) {
//        return YES;
//    }else{
//        return NO;
//    }
//    
//}


@end
