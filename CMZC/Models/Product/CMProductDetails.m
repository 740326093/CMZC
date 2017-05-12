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

@end
