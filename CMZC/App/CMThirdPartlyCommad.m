//
//  CMThirdPartlyCommad.m
//  CMZC
//
//  Created by WangWei on 17/2/22.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMThirdPartlyCommad.h"
#import "CMApp_Header.h"

static BOOL isProduction = YES;
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
//#endif
@implementation CMThirdPartlyCommad
singleton_implementation(CMThirdPartlyCommad)
- (NSDictionary*)setupWithOptions:(NSDictionary *)launchOptions WithDlelegate:(id)Delegate {
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//      #ifdef NSFoundationVersionNumber_iOS_9_x_Max
//            JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
//            [JPUSHService registerForRemoteNotificationConfig:entity delegate:Delegate];
//        #endif
//          }
//  else
    
      if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey channel:KJPushChannel apsForProduction:isProduction];
    NSDictionary *message = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            MyLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            MyLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
        return message;
    
    
    
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    return;
}

+(void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion {
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (completion) {
        completion(UIBackgroundFetchResultNewData);
    }
    
    return;
}



+(void)configureBoardManager{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}

+(void)umsocialData{
    
    [[UMSocialManager defaultManager]openLog:YES];
  [[UMSocialManager defaultManager] setUmSocialAppkey:kUMSocial_Appkey];
    //  [UMSocialData setAppKey:kUMSocial_Appkey];
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
  [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_QQ appKey:kUMSocial_QQAppId appSecret:kUMSocail_QQAppKey redirectURL:kUMSocial_url];
     [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Qzone appKey:kUMSocial_QQAppId appSecret:kUMSocail_QQAppKey redirectURL:kUMSocial_url];
 //[UMSocialQQHandler setQQWithAppId:kUMSocial_QQAppId appKey:kUMSocail_QQAppKey url:kUMSocial_url];
    
    
    //设置微信AppId、appSecret，分享url
//[UMSocialWechatHandler setWXAppId:kUMSocial_WechatId appSecret:kUMSocial_wechatSecret url:kUMSocial_url];
     [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatSession  appKey:kUMSocial_WechatId appSecret:kUMSocial_wechatSecret redirectURL:kUMSocial_url];
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_WechatTimeLine  appKey:kUMSocial_WechatId appSecret:kUMSocial_wechatSecret redirectURL:kUMSocial_url];
//    
    //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
  // [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kUMSocial_sinaAppKey
                              //                secret:kUMSocial_sinaAppSecret
                               //   RedirectURL:kUMSocial_url];
  
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Sina  appKey:kUMSocial_sinaAppKey appSecret:kUMSocial_sinaAppSecret redirectURL:kUMSocial_url];
}


@end
