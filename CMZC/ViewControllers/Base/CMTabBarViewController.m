//
//  CMTabBarViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMTabBarViewController.h"
#import "CMLoginViewController.h"

@interface CMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation CMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float tabHeight=self.tabBar.frame.size.height;
    if(kDevice_Is_iPhoneX){
        tabHeight=83;
    }
    
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), tabHeight)];
    [tabBarView setBackgroundColor:[UIColor cmtabBarGreyColor]];
    [self.tabBar insertSubview:tabBarView atIndex:0];
    
    
    self.delegate = self;
   
    
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    //||viewController == [tabBarController.viewControllers objectAtIndex:2]
    
    
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]||viewController == [tabBarController.viewControllers objectAtIndex:2]) //assuming the index of uinavigationcontroller is 2
    {
        
        if (CMIsLogin()) {
            return YES;
        } else {
          //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTabBarIndex) name:@"loginWin" object:nil];
            CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
            loginVC.modalPresentationStyle=UIModalPresentationFullScreen;
            [self presentViewController:loginVC animated:YES completion:nil];
            return  NO;
        }
    }
    else {
        return YES;
    }
}
- (void) presentTabBarIndex {
   // UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
   // CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    
    
    self.selectedIndex = 3;
}
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加标签子控制器

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
