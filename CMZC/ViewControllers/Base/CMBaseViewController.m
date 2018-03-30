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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  

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























