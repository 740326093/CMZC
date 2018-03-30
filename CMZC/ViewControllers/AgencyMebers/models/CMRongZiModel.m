//
//  CMRongZiModel.m
//  CMZC
//
//  Created by WangWei on 2018/3/13.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMRongZiModel.h"

@implementation CMRongZiModel
-(UIColor*)Btncolor{
    if ([_cpStatusText isEqualToString:@"待审核"]) {
        return [UIColor clmHex:0xffb600];
    }else if ([_cpStatusText isEqualToString:@"审核中"]){
        
        return [UIColor clmHex:0x39b54a];
    }else if ([_cpStatusText isEqualToString:@"审核未通过"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_cpStatusText isEqualToString:@"审核未通过"]){
        
        return [UIColor clmHex:0xff6400];
    }
    else if ([_cpStatusText isEqualToString:@"交易结束"]){
        
        return [UIColor clmHex:0xcacaca];
    }
    else if ([_cpStatusText isEqualToString:@"待上架"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_cpStatusText isEqualToString:@"即将开始"]){
        
        return [UIColor clmHex:0x39b54a];
    }
    else if ([_cpStatusText isEqualToString:@"立即申购"]){
        
        return [UIColor clmHex:0xff6400];
    }
    else if ([_cpStatusText isEqualToString:@"申购暂停"]){
        
        return [UIColor clmHex:0xcacaca];
    }
    else if ([_cpStatusText isEqualToString:@"预热中"]){
        
        return [UIColor clmHex:0xfe9900];
    }
    else if ([_cpStatusText isEqualToString:@"路演中"]){
        
        return [UIColor clmHex:0xfe9900];
    }
    else if ([_cpStatusText isEqualToString:@"预热结束"]){
        
        return [UIColor clmHex:0xcacaca];
    } else if ([_cpStatusText isEqualToString:@"路演结束"]){
        
        return [UIColor clmHex:0xcacaca];
    }else{
        
        return [UIColor clmHex:0xff6400];
    }
    
}
-(BOOL)enterDetail{
    if (_cpIsEnable !=0) {
        return YES;
    }else{
        return NO;
    }
    
}
-(NSString*)shengouAmount{
    if ([_shengouAmount floatValue]>0) {
        return _shengouAmount;
    }else{
        return @"--";
    }
}
@end
