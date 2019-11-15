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
#import "CMAppUpdate.h"

#import "CMNewNoticeController.h"
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
//#endif
static NSString *UPDATEMODEL = @"updateModel";
@interface AppDelegate ()<CMAppUpdateDelegate>
@property (strong, nonatomic) UIAlertView *appUpdateAlert;
@property(nonatomic,copy)NSDictionary *userDict;

@property(nonatomic,assign)BOOL fromForeground;
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
    
//    if (@available(ios 11.0,*)) {
//        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        UITableView.appearance.estimatedRowHeight = 0;
//        UITableView.appearance.estimatedSectionFooterHeight = 0;
//        UITableView.appearance.estimatedSectionHeaderHeight = 0;
//    }

    
    //添加浏览器标识符
    UIWebView* tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString *oldAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"
                          ];
    
    
    NSString *newAgent  = [NSString stringWithFormat:@"%@ XJBapp"
                           ,oldAgent];
    
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent",nil ];
    [[NSUserDefaults standardUserDefaults] registerDefaults
     :dictionnary];

    if(CMIsLogin()){
        [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
            
           
        } fail:^(NSError *error) {
           
        }];
    
    }
    [JPUSHService  registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        MyLog(@"%@",registrationID);
        
    }];
        return YES;
}
-(void)SetNavigationBar{
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"UINavigationBar"]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor cmThemeCheng]];
    
  
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
     [[[CMRequestAPI alloc]init]cheackNetWorking];
    if (CMIsLogin()) {
       
    }
    
    for (UIView *vc in self.window.subviews) {
         MyLog(@"+++%@",vc);//UILayoutContainerView
        //        if ([vc isKindOfClass:[CMShareTextView class]]||[vc isKindOfClass:[CMAddressList class]]||[vc isKindOfClass:[CMMyTipsView class]]||[vc isKindOfClass:[RAlertView class]]||[vc isKindOfClass:[CMLLSupportBank class]]||[vc isKindOfClass:[CMLLWarningView class]]||[vc isKindOfClass:[CMNewpayView class]]) {
        //            [vc removeFromSuperview];
        //        }
        NSString *classStr=NSStringFromClass([vc class]);
       //if (![classStr isEqualToString:@"UILayoutContainerView"]) {
          //  [vc removeFromSuperview];
        //}
    }
    
    _fromForeground=YES;
    
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
    
    CMAppUpdate *AppUpdate=[[CMAppUpdate alloc]init];
    AppUpdate.updateDelegate=self;
}
-(void)isMustUpdateAPPVersion:(CMVersionModel*)VersionModel{
    [_appUpdateAlert removeFromSuperview];
    if(VersionModel.content.length<=0||VersionModel.content==nil){
        VersionModel.content=@"发现需要升级的版本,现在去更新";
    }
    
    if (VersionModel.updateStatus) {
        
        _appUpdateAlert=[[UIAlertView alloc]initWithTitle:@"新版本提示" message:VersionModel.content delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_appUpdateAlert show];
        
        objc_setAssociatedObject(_appUpdateAlert, &UPDATEMODEL, VersionModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        
    }else{
        
       if (_fromForeground==NO){
        _appUpdateAlert=[[UIAlertView alloc]initWithTitle:@"新版本提示" message:VersionModel.content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [_appUpdateAlert show];
        
        objc_setAssociatedObject(_appUpdateAlert, &UPDATEMODEL, VersionModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag==101) {
        if (buttonIndex==1) {
            
            NSString *urlStr = [self.userDict objectForKey:@"ext"];
            [self pushWebviewWithURL:urlStr];
            
            
            
        }
    } else {
        
  
    CMVersionModel *versionModel=objc_getAssociatedObject(alertView, &UPDATEMODEL);
    
    if (versionModel.updateStatus) {
        
        
        if (buttonIndex==0) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:versionModel.downAddress]];
        }
        
        
    }else{
        if (buttonIndex==1) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:versionModel.downAddress]];
        }
        
    }
    
      }
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


// 有外部app通过URL Scheme 的方法打开本应用

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //NSString *test = url.host; // 这就是参数
//    NSLog(@"host = %@",test);
//    NSLog(@"url = %@", url);
//    NSLog(@"url = %@", [url query] );
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
//    NSLog(@"%@",urlComponents.scheme);
//    NSLog(@"%@",urlComponents.user);
//    NSLog(@"%@",urlComponents.password);
//    NSLog(@"%@",urlComponents.host);
//    NSLog(@"%@",urlComponents.port);
 //   NSLog(@"%@",urlComponents.query);
    
    //包含query的各个参数
    NSLog(@"%@",urlComponents.queryItems);
 
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    return YES;
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
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    NSLog(@"---%@",userActivity.webpageURL);
    return YES;
}


- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity API_AVAILABLE(ios(13.0)){
    NSLog(@"---%@",userActivity.webpageURL);
    
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
    //[self addOrRemoveController];
    
    if (!isFirstRunThisVersion) {
        
        self.viewController = self.window.rootViewController;
        self.window.rootViewController=[[CMGuideController alloc]init];
        SaveDataToNSUserDefaults([NSNumber numberWithBool:YES], versionKey);
    }
    
    
}


-(void)addOrRemoveController{
    
    CMTabBarViewController *tabBar=(CMTabBarViewController*)self.window.rootViewController;

    NSMutableArray *tabbarControllersArray=[NSMutableArray arrayWithArray:tabBar.viewControllers];
    if (CMIsLogin()) {
        
        if (tabbarControllersArray.count!=4) {
            
        CMNewNoticeController *VC =  [CMNewNoticeController initByStoryboard];
        UINavigationController *NaVC = [[UINavigationController alloc] initWithRootViewController:VC];
        NaVC.tabBarItem.title = @"转让";
        NaVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_line_select"];
        NaVC.tabBarItem.image = [UIImage imageNamed:@"tab_line"];
        
        [tabbarControllersArray insertObject:NaVC atIndex:2];
            
            
        }
        
        tabBar.viewControllers=tabbarControllersArray;
        
        
        self.window.rootViewController =tabBar;
        
        
    } else {
      
        
        if (tabbarControllersArray.count ==4) {
            
        
        [tabbarControllersArray removeObjectAtIndex:2];
            
            
        }
        
        tabBar.viewControllers=tabbarControllersArray;
        
        
        self.window.rootViewController =tabBar;
        
        
        
    }
    
    
}

@end
