//
//  CMAgencyCheckController.m
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyCheckController.h"

@interface CMAgencyCheckController ()
@property (weak, nonatomic) IBOutlet UIImageView *checkStateImage;
@property (weak, nonatomic) IBOutlet UILabel *checkStateLab;
@property (weak, nonatomic) IBOutlet UILabel *checkDetaillab;

@property (weak, nonatomic) IBOutlet UIButton *backHomeBtn;
@end

@implementation CMAgencyCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton = YES;
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
    _backHomeBtn.layer.borderColor=[UIColor clmHex:0xff6400].CGColor;
    _backHomeBtn.layer.cornerRadius=5.0;
    _backHomeBtn.layer.borderWidth=1;
    switch (_stateType) {
        case CMUpSuccess:{
            
            _checkStateLab.text=@"恭喜你,提交成功!";
            _checkStateImage.image=[UIImage imageNamed:@"agencyUpSuccess"];
          
        }
            break;
        case CMCheacking:{
            _checkStateLab.text=@"审核中,请您耐心等待!";
            _checkStateImage.image=[UIImage imageNamed:@"agencyCheckingState"];
        }
            
            break;
        case CMCheackFail:
        {
            
            _checkStateLab.text=@"审核未通过";
            _checkStateImage.image=[UIImage imageNamed:@"agencyFailState"];
            _checkDetaillab.text=_StateLab;
            [_backHomeBtn setTitle:@"重新提交" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftBarBtnClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)backHomeClick:(id)sender {
    //返回首页
    if (_stateType==CMCheackFail) {
      //  MyLog(@"++%@",self.navigationController.viewControllers);
        CMAgencyMebersController *collectController = (CMAgencyMebersController *)[CMAgencyMebersController initByStoryboard];
        [self.navigationController  pushViewController:collectController animated:YES];
        
        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        [arr removeObjectsInRange:NSMakeRange(1, 1)];
        self.navigationController.viewControllers=arr;
    }else{
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 0;
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
    self.navigationController.viewControllers=arr;
    }

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
