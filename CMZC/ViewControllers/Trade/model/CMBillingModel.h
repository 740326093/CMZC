//
//  CMBillingModel.h
//  CMZC
//
//  Created by 云财富 on 2019/6/3.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMBillingModel : NSObject

///// 结算统计-时间
//public DateTime sscSettleTime
///// 结算统计-佣金金额
//public decimal sscSettleAmount

@property (copy, nonatomic) NSString *sscSettleTime;
@property (copy, nonatomic) NSString *sscSettleAmount;
@end

NS_ASSUME_NONNULL_END
