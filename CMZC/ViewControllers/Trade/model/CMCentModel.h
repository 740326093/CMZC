//
//  CMCentModel.h
//  CMZC
//
//  Created by 云财富 on 2019/6/3.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMCentModel : NSObject
//"scPhone": "18750000044",
//"scExpectAmount": 20.000,
//"scActuaAmount": 0.000,
//"scTime": "2019-05-28T16:16:02.103",
//"scState": "待结算"

@property (copy, nonatomic) NSString *scPhone;
@property (copy, nonatomic) NSString *scExpectAmount;
@property (copy, nonatomic) NSString *scActuaAmount;
@property (copy, nonatomic) NSString *scTime;
@property (copy, nonatomic) NSString *scState;
@property (strong, nonatomic) UIColor *scStateColor;
@end

NS_ASSUME_NONNULL_END
