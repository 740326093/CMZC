//
//  CMThirdPartlyCommad.h
//  CMZC
//
//  Created by WangWei on 17/2/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMThirdPartlyCommad : NSObject

singleton_interface(CMThirdPartlyCommad)
// 在应用启动的时候调用
-(NSDictionary*)setupWithOptions:(NSDictionary *)launchOptions WithDlelegate:(id)Delegate;

// 在appdelegate注册设备处调用
+(void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+(void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

+(void)configureBoardManager;//键盘回收

//友盟配置
+(void)umsocialData;

@end
