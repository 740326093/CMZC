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
#import "CMTabBarViewController.h"
#import "CMTradeViewController.h"

//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
//#endif
@interface AppDelegate ()
@property(nonatomic,strong)NSDictionary *userDict;
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
    NSDictionary *isJpushMessage=[[CMThirdPartlyCommad sharedCMThirdPartlyCommad] setupWithOptions:launchOptions WithDlelegate:nil];
    if (isJpushMessage) {
        MyLog(@"有消息");
    }else{
        
    }
    //配置键盘回收
    [CMThirdPartlyCommad configureBoardManager];
    


    [self SetNavigationBar];
    
    [CMMessageDao createTable];
    
    UIWebView* tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
   // NSLog(@"old agent :%@", oldAgent);
    //add my info to the new agent
    NSString *newAgent  = [NSString stringWithFormat:@"%@ xjbapp",oldAgent];;
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
   // NSLog(@"new agent :%@", newAgent);
    
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
//    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0)
//    {
 if (self.isAppIconLaunching==NO) {
        if (self.userDict.allKeys!=0) {
             NSString *urlStr = [self.userDict valueForKey:@"ext"];
             [self pushWebviewWithURL:urlStr];
            self.isAppIconLaunching=YES;
        }
        
        
    //}
    }
    
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
    NSString *urlStr = [userInfo valueForKey:@"ext"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSString *time=[NSString currentDateFormatter:@"yyyy/MM/dd HH:mm:ss"];
    self.userDict=userInfo;

   // if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0)
    //{
    if(application.applicationState == UIApplicationStateActive){

        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"忽略"
                                              otherButtonTitles:@"查看", nil];
        alert.tag=101;
        [alert show];
   
        
        NSString *page=[NSString dictionaryToJson:self.userDict];
        
      
        [CMMessageDao insertWithMessage:content andMessageUrl:urlStr andTime:time andIsread:@"1" andPage:page];
        
        
    }else{
        
        static BOOL isOk;
        if (isOk==NO) {
         

            NSString *page=[NSString dictionaryToJson:userInfo];
    
            [CMMessageDao insertWithMessage:content andMessageUrl:urlStr andTime:time andIsread:@"1" andPage:page];
            
            self.isAppIconLaunching=NO;
          
            
        }else{
 
            
            [self pushWebviewWithURL:urlStr];
            self.isAppIconLaunching=YES;
           
            
        }
        isOk =!isOk;
        
  

//        
//        NSString *page=[NSString dictionaryToJson:self.userDict];
//        [CMMessageDao insertWithMessage:content andMessageUrl:urlStr andTime:time andIsread:@"1" andPage:page];
//        
//         [self pushWebviewWithURL:urlStr];
        
        
        
    }
    
  //  }
    
    [CMThirdPartlyCommad  handleRemoteNotification:userInfo completion:completionHandler]; //处理收到的 APNs 消息

    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if (buttonIndex==1) {
        
       NSString *urlStr = [self.userDict objectForKey:@"ext"];
        [self pushWebviewWithURL:urlStr];
        
        
       
    }
    
    
}
-(void)pushWebviewWithURL:(NSString*)urlStr{
    if (urlStr!=nil) {
        
   
    CMTabBarViewController *tabBar=(CMTabBarViewController*)self.window.rootViewController;
    UINavigationController *nvc=(UINavigationController*)tabBar.selectedViewController;
    CMBaseViewController * baseVC = (CMBaseViewController *)nvc.visibleViewController;
    CMCommWebViewController *vc = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    //vc.hidesBottomBarWhenPushed=YES;
    vc.urlStr=urlStr;
    vc.isJPush=YES;
    [baseVC.navigationController pushViewController:vc animated:NO];
    
    }
}
/*
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
        
        
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *urlStr = [userInfo valueForKey:@"ext"];
        NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        NSString *time=[NSString currentDateFormatter:@"yyyy/MM/dd HH:mm:ss"];
        
        
        NSString *page=[NSString dictionaryToJson:self.userDict];
        
        [CMMessageDao insertWithMessage:content andMessageUrl:urlStr andTime:time andIsread:@"1" andPage:page];
        self.userDict=userInfo;
        
        [self pushWebviewWithURL:urlStr];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
//                                                        message:userInfo[@"aps"][@"alert"]
//                                                       delegate:self
//                                              cancelButtonTitle:@"忽略"
//                                              otherButtonTitles:@"查看", nil];
//        alert.tag=101;
//        [alert show];
//
//        
        
    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}


// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
        MyLog(@"iOS10程序关闭后通过点击推送进入程序弹出的通知: %@", message);
        NSString *page=[NSString dictionaryToJson:self.userDict];
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *urlStr = [userInfo valueForKey:@"ext"];
        NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        NSString *time=[NSString currentDateFormatter:@"yyyy/MM/dd HH:mm:ss"];
        [self pushWebviewWithURL:urlStr];
        [CMMessageDao insertWithMessage:content andMessageUrl:urlStr andTime:time andIsread:@"1" andPage:page];
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif


*/


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With 《，Error: %@", error);
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
