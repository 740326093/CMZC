//
//  AppDelegate.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 财毛. All rights reserved.
//

#import "AppDelegate.h"
#import "CMThirdPartlyCommad.h"
#import "CMGuideController.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareDelegate{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:[UIColor cmThemeOrange]];
    
    //***********    调试登录
    
    
    //由于分享要真机。不然会出现错误。所哟，先注销掉。测试时在借助
    [CMThirdPartlyCommad umsocialData];
    
    //显示引导页
    [self showWelcome];
    
    //推送
    NSDictionary *isJpushMessage=[[CMThirdPartlyCommad sharedCMThirdPartlyCommad] setupWithOptions:launchOptions WithDlelegate:self];
    if (isJpushMessage) {
        MyLog(@"有消息");
    }else{
        
    }
    //配置键盘回收
    [CMThirdPartlyCommad configureBoardManager];
   
    [self SetNavigationBar];
    return YES;
}
-(void)SetNavigationBar{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"UINavigationBar"]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor cmThemeOrange]];
}

//程序将要进入后台的时候
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    if (CMIsLogin()) {
        
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//程序将要回复
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    // 当程序从后台将要重新回到前台时候调用
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if (CMIsLogin()) {
        
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    // Required 注册要处理的远程通知类型
    [CMThirdPartlyCommad registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    MyLog(@" %@",[userInfo description]);
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
     NSMutableArray *contentArr = [NSMutableArray array];
    [contentArr addObject:content];
    NSArray *alertArr = GetDataFromNSUserDefaults(@"alertArr");
    if (alertArr.count > 0) {
        for (NSString *alert in alertArr) {
            [contentArr addObject:alert];
        }
    }
    SaveDataToNSUserDefaults(contentArr, @"alertArr");
    
    // IOS 7 Support Required
    [CMThirdPartlyCommad  handleRemoteNotification:userInfo completion:completionHandler]; //处理收到的 APNs 消息
    
}


#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        
        NSString *message = [NSString stringWithFormat:@"will%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        MyLog(@"iOS10程序在前台时收到的推送: %@", message);
        
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}


// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        MyLog(@"iOS10程序关闭后通过点击推送进入程序弹出的通知: %@", message);
        
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif





- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With 《，Error: %@", error);
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    
}
- (void)networkDidMessage:(NSNotification *)notification {
    
}

/**
 *  显示引导页
 */
- (void)showWelcome {
//    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *versionKey = [NSString stringWithFormat:@"isFirstRun"];
    BOOL isFirstRunThisVersion = [GetDataFromNSUserDefaults(versionKey) boolValue];
    if (!isFirstRunThisVersion) {
       
    
        
        self.viewController = self.window.rootViewController;
        self.window.rootViewController=[[CMGuideController alloc]init];
        SaveDataToNSUserDefaults([NSNumber numberWithBool:YES], versionKey);
    }
    
}
#pragma mark - 开启定时器 刷新token


@end
