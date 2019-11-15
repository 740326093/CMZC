//
//  CMBaseViewController.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMBaseViewController.h"
#import "CMTabBarViewController.h"


@interface CMBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation CMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSArray *arr = self.navigationController.viewControllers;
    if (arr.count >1) {
        UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
        [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
        [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
        self.navigationItem.leftBarButtonItem = btnItem;
    }
   
    //这个地方。千万不能写dele 如果写要做一下判断。 因为iOS7上是不支持的。就是因为这个搞了我一天。真傻比。
   // self.navigationController.delegate = self;
    self.navigationController.navigationBar.barTintColor=[UIColor cmThemeOrange];
       [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}




- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *arr = navigationController.viewControllers;
    if (arr.count >1) {
        UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
        [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
        [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
        self.navigationItem.leftBarButtonItem = btnItem;
    }
 
    
}



/**
 *   是否允许弹窗
 */
-(BOOL)allowShowLocationAlert{
    
    NSDate *now = [NSDate date];
    //当前时间的时间戳
    NSTimeInterval nowStamp = [now timeIntervalSince1970];
    //当天零点的时间戳
    NSTimeInterval zeroStamp = [[[NSUserDefaults standardUserDefaults] objectForKey:@"zeroStamp"] doubleValue];
    //一天的时间戳
    NSTimeInterval oneDay = 60* 60 * 24;
    
    /**
     "showedLocation"代表了是否当天是否提醒过开启定位，NO代表没有提醒过，YES代表已经提醒过
     */
    
    if(nowStamp - zeroStamp> oneDay){
        
        zeroStamp = [self getTodayZeroStampWithDate:now];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:zeroStamp] forKey:@"zeroStamp"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"showedLocation"];
        return YES;
        
    }else{
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showedLocation"]) {
            return NO;
            
        }else{
            return YES;
        }
        
    }
    
}

/**
 * 获取当天零点时间戳
 */
- (double)getTodayZeroStampWithDate:(NSDate *)date{
    
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy年MM月dd日";
    NSString *original = [dateFomater stringFromDate:date];
    NSDate *ZeroDate = [dateFomater dateFromString:original];
    // 今天零点的时间戳
    NSTimeInterval zeroStamp = [ZeroDate timeIntervalSince1970];
    return zeroStamp;
    
}

-(void)listenNetWorkingStatus{
    //1:创建网络监听者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    //2:获取网络状态
    /*
     AFNetworkReachabilityStatusUnknown          = 未知网络，
     AFNetworkReachabilityStatusNotReachable     = 没有联网
     AFNetworkReachabilityStatusReachableViaWWAN = 蜂窝数据
     AFNetworkReachabilityStatusReachableViaWiFi = 无线网
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有联网");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网");
                break;
            default:
                break;
        }
    }];
    
    //开启网络监听
    [manager startMonitoring];
}


- (void)leftBarBtnClick {
   // NSLog(@"----%u",self.navigationController.viewControllers.count);
    [self.navigationController popViewControllerAnimated:YES];
//    if (iOS7) {
////        NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
////        for (UIViewController *vc in vcs) {
////            if ([vc isKindOfClass:[self class]]) {
////                [vcs removeObject:vc];
////                break;
////            }
////        }
////        self.navigationController.viewControllers = vcs;
//         [self.navigationController popViewControllerAnimated:YES];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//这事我能想到了最容易的了。有好的话希望改正，求告知。
+ (UIViewController *)initByStoryboard {
    NSString *nibName = NSStringFromClass([self class]);
    return [[UIStoryboard mainStoryboard] viewControllerWithId:nibName];
}

- (void)showTabBarViewControllerType:(NSInteger)tabIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = tabIndex;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end























