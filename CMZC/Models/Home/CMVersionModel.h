//
//  CMVersionModel.h
//  CMZC
//
//  Created by 云财富 on 2019/7/4.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMVersionModel : NSObject

@property (copy, nonatomic) NSString *number; //版本号
@property (copy, nonatomic) NSString *downAddress; //下载地址
@property (assign, nonatomic) BOOL updateStatus; //是否强制更新
@property (nonatomic,copy) NSString *content; //更新内容


@end

NS_ASSUME_NONNULL_END
