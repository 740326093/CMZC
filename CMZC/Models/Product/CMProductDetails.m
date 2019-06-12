//
//  CMProductDetails.m
//  CMZC
//
//  Created by MAC on 16/10/11.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMProductDetails.h"

@implementation CMProductDetails

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"productId":@"id",
             @"descri":@"description",
             @"typeName":@"typename",
             
             };
}
-(UIColor*)statusColor{
    
    if ([_status isEqualToString:@"立即申购"]) {
        return [UIColor clmHex:0xff6400];
    } else if([_status isEqualToString:@"预约中"]||[_status isEqualToString:@"预定中"]){
        return [UIColor clmHex:0x309830];
    }
    else if([_status isEqualToString:@"路演中"]){
        return [UIColor clmHex:0xff9a00];
    }else{
        
        
        return [UIColor clmHex:0xcccccc];
    }
}
@end
