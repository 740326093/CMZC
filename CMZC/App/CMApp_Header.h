//
//  CMApp_Header.h
//  CMZC
//
//  Created by 财猫 on 16/3/24.
//  Copyright © 2016年 MAC. All rights reserved.
//

#ifndef CMApp_Header_h
#define CMApp_Header_h
//#import "UMSocial.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaSSOHandler.h"
#import "JPUSHService.h"
#import <IQKeyboardManager.h>

#define kUMSocial_Appkey @"56f48900e0f55a1a4e001fdc" //友盟分享的key

#define kUMSocial_url @"http://mz.58cm.com/About/APPClient"

#define kCMWebHeader_Url @"http://mz.58cm.com/"
  //5cba7267fc650e1d04e504c1    5dce39de8713b71e70a41eb9    新的5dce3a0b8713b71e70a41eba
static NSString *const VPSDKAppKey= @"5dce3a0b8713b71e70a41eba";

//qq
#define kUMSocial_QQAppId @"1105314915" //qq appid
#define kUMSocail_QQAppKey @"dQhZB4PpJSNGNnJR"  //qq app key

//wechat
#define kUMSocial_WechatId @"wx54df45fc4b5da723"  //微信  appid
#define kUMSocial_wechatSecret @"3a7af9ff6b849a77c94786ca79f4efac" // 微信 appSecret

//webo
#define kUMSocial_sinaAppKey @"1910812301"  //新浪微博app key
#define kUMSocial_sinaAppSecret @"f41e14fb0c5e91d60f5811666a4800f0"  //app secret


//*************JP 

#define kJPushAppKey @"059c7efbd0eab9d7160a5761"   // 极光推送appk
#define kJPushMesterSecret @"f0b54d9671d58d7a8fae7150" // secret 后台用。就记录下
#define KJPushChannel @"Publish channel"

//#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX  [UIScreen mainScreen].bounds.size.height>=812

#endif /* CMApp_Header_h */
