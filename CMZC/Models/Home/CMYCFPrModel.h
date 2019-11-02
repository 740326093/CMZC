//
//  CMYCFPrModel.h
//  CMZC
//
//  Created by 云财富 on 2019/11/1.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMYCFPrModel : NSObject

//period = 0;
//periodUnit = 0;
//price = "0.01";
//productId = 638;
//productName = "\U5bcc\U56fd\U5bcc\U94b1\U5305\U8d27\U5e01";
//productTypeDescription = "\U8d27\U5e01\U57fa\U91d1";
//qurl = "https://m.58ycf.com/product/product/questions?id=1001003543";
//rate = "2.29";
//rateDescription = "\U8fd17\U65e5\U5e74\U5316";
//recommend = 0;
//reward = 0;
//rewarddays = 0;
//url = "https://m.58ycf.com/Product/CurrencyFund/Detail?fundCode=000638";


@property (copy, nonatomic) NSString *productName;
@property (copy, nonatomic) NSString *productTypeDescription;
@property (copy, nonatomic) NSString *rateDescription;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *qurl;

@property (assign, nonatomic) int periodUnit;
@property (copy, nonatomic) NSString *period;

@property (assign, nonatomic) float rate;
@property (assign, nonatomic) float reward;
@end

NS_ASSUME_NONNULL_END
