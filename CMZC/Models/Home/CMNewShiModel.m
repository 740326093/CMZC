//
//  CMNewShiModel.m
//  CMZC
//
//  Created by WangWei on 17/2/24.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMNewShiModel.h"

@implementation CMNewShiModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mediaId":@"id",
             @"descrip":@"description"
             };
}
-(NSString*)picture{
    
    return [_picture stringByReplacingOccurrencesOfString:@"|" withString:@""];
}

@end
