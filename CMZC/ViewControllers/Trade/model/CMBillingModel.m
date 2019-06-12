//
//  CMBillingModel.m
//  CMZC
//
//  Created by 云财富 on 2019/6/3.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMBillingModel.h"

@implementation CMBillingModel
-(NSString*)sscSettleAmount{
    
    return [_sscSettleAmount stringByAppendingString:@"元"];
}

@end
