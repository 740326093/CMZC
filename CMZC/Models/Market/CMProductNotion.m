//
//  CMProductNotion.m
//  CMZC
//
//  Created by 财猫 on 16/6/1.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMProductNotion.h"

@implementation CMProductNotion
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"notionId":@"id",
             @"descri":@"description"
             };
}
@end
