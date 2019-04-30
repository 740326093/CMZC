//
//  CMBeginNUmModel.h
//  CMZC
//
//  Created by WangWei on 2019/4/13.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMBeginNUmModel : NSObject
@property(nonatomic,copy)NSString *numer;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)UIColor *statusColor;

@end

NS_ASSUME_NONNULL_END
