//
//  CMGuideController.m
//  CMZC
//
//  Created by WangWei on 17/2/22.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMGuideController.h"
#import "CMGuideView.h"
#import "AppDelegate.h"
@interface CMGuideController ()

@end

@implementation CMGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = @[@"one_guidance.jpg", @"two_guidance.jpg", @"three_guidance.jpg",@"four_guidance.jpg"];
    //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
    CMGuideView *GuideView = [[CMGuideView alloc] init:array];
    GuideView.delegate=self;
    [self.view addSubview:GuideView];
}

-(void)enterAppMainController{
    
  AppDelegate *app = [AppDelegate shareDelegate];
    app.window.rootViewController = app.viewController;
    NSLog(@"点击立即体验");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
