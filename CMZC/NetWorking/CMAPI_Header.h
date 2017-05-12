//
//  CMAPI_Header.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 MAC. All rights reserved.
//

#ifndef CMAPI_Header_h
#define CMAPI_Header_h

#define kCMTableFoot_isPage NSInteger total = [responseObject[@"data"][@"total"] integerValue];\
BOOL isPage = NO;\
if (page * 10 < total) {\
isPage = YES;\
}

#import "CMRequestAPI.h"
#import "CMNetWorkConstants.h"
#import "CMRequestAPI+Trends.h"
#import "CMRequestAPI+HomePage.h"
#import "CMRequestAPI+Login.h"
#import "CMRequestAPI+TradeInquire.h"
#import "CMRequestAPI+Product.h"
#import "CMRequestAPI+ProductMark.h"

#endif /* CMAPI_Header_h */
