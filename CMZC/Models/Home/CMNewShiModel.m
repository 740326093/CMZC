//
//  CMNewShiModel.m
//  CMZC
//
//  Created by WangWei on 17/2/24.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMNewShiModel.h"

@implementation CMNewShiModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mediaId":@"id",
             @"descrip":@"description"
             };
}


@end
