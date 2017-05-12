//
//  CMMoneyViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMMoneyViewController.h"

@interface CMMoneyViewController ()<UIScrollViewDelegate>


@property (strong, nonatomic)  UIImageView *titleImageView;
@property (strong, nonatomic)  UIScrollView *curScrollView;

@property (strong, nonatomic)  UIButton *beignzhongChou;

@end

@implementation CMMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
       self.navigationItem.title = self.titName;
    self.titleImageView.image = [UIImage imageNamed:_imageStr];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.curScrollView];
    [self.curScrollView addSubview:self.titleImageView];
    self.curScrollView.contentSize=CGSizeMake(CMScreen_width(), f_i5real(self.titleImageView.image.size.height)+100);
    [self.titleImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(self.titleImageView.image.size.height));
        make.width.top.left.equalTo(self.curScrollView);
       
        
    }];
    [self.titleImageView addSubview:self.beignzhongChou];
    [self.beignzhongChou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_left).offset(10);
        make.bottom.equalTo(self.titleImageView);
        make.right.equalTo(self.titleImageView.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    if ([self.imageStr isEqualToString:@"new_shou_yindao"]) {
           [self.beignzhongChou addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.hideTabBar==YES) {
        
        self.tabBarController.tabBar.hidden=YES;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.hideTabBar==YES) {
        
        self.tabBarController.tabBar.hidden=NO;
    }
}

-(UIScrollView*)curScrollView{
    if (!_curScrollView) {
        
        _curScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, CMScreen_width(), CMScreen_height())];
        _curScrollView.showsVerticalScrollIndicator=NO;
        

    }
    return _curScrollView;
}
-(UIImageView*)titleImageView{
    if (!_titleImageView) {
        
        _titleImageView=[[UIImageView alloc]init];
        _titleImageView.userInteractionEnabled=YES;
    }
    return _titleImageView;
}

-(UIButton*)beignzhongChou{
    if (!_beignzhongChou) {
       
        _beignzhongChou=[UIButton buttonWithType:UIButtonTypeCustom];
     
    }
    return _beignzhongChou;
}






//开启众筹
- (void)openClick {   MyLog(@"dianji");
    [self.navigationController popToRootViewControllerAnimated:NO];
    
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
