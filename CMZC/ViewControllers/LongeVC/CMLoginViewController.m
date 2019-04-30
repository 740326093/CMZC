//
//  CMLoginViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 MAC. All rights reserved.
// 13713720834

#define kUserName @"15989437117"
#define kPassword @"cui12345678"
//#define kUserName @"17600000034"
//#define kPassword @"w123456"

#import "CMLoginViewController.h"
#import "AppDelegate.h"
#import "CMAccount.h"
#import "CMCodeAlert.h"
//找回密码获取手机验证码的通知Key
#define kVerifyMobilePhonePassWordKey @"kVerifyMobilePhonePassWord"

#define kVerifyStarDatePassWordKey @"VerifyStarDatePassWord"

@interface CMLoginViewController ()<UITextFieldDelegate> {
   
}
@property (weak, nonatomic) IBOutlet CMTextField *accountNumberTF;//账号
@property (weak, nonatomic) IBOutlet CMTextField *passwordTF;//密码
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeViewTopLayout;//view的top

@property (weak, nonatomic) IBOutlet UIButton *sliderPassBtn;
@property (weak, nonatomic) IBOutlet UIButton *sliderCodeBtn;

@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (weak, nonatomic) IBOutlet UIScrollView *sliderScollView;

@property(nonatomic,strong)UIButton *oldBtn;
@property (weak, nonatomic) IBOutlet CMTextField *codePhoneFiled;


@property (weak, nonatomic) IBOutlet UITextField *codeSmsTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (strong, nonatomic) NSTimer *verifyPhoneTimer;//开启一个用手机注册获得验证码时间的定时器

@property (strong, nonatomic) CMCodeAlert *CodeAlert;
@end

@implementation CMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *accountName = GetDataFromNSUserDefaults(@"accountName");
    if (accountName.length > 0) {
        _accountNumberTF.text = accountName;
    }
    
    
_sliderPassBtn.selected=YES;
self.oldBtn=_sliderPassBtn;
    self.sliderScollView.contentSize=CGSizeMake(CMScreen_width()*2,   self.sliderScollView.bounds.size.height);
    
    NSInteger surplus = [self getSurplusPhoneTime];
    

    if (surplus > 0) {
        _codePhoneFiled.userInteractionEnabled = NO;
        _getCodeBtn.userInteractionEnabled = NO;
        //当程序回来时。显示
        _codePhoneFiled.text = GetDataFromNSUserDefaults(kVerifyMobilePhonePassWordKey);
        //开启一个定时器
        [self openPhoneTimer];
        [_verifyPhoneTimer fire];
    }
    
      [VPSDKManager setVaptchaSDKVid:VPSDKAppKey scene:@"01"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)getBackBtnItemClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)logonButClick:(UIButton *)sender {
    //[self.view endEditing:YES];
    //存储当前账号
   // SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
    // [self showMainViewController];
 //   _homeViewTopLayout.constant = 0.0f;
    //线判断数据的有效性
    if ([self checkDataValidity]) {
        [self showDefaultProgressHUD];
        [CMRequestAPI cm_loginTransRegisterClientId:@"CC67712F-4614-40CF-824E-10D784C2A3D7" clientSecret:@"c0aa7577b892ff2ff4ee0109f2932321" userName:_accountNumberTF.text password:_passwordTF.text success:^(CMAccount *account) {
            
            DeleteDataFromNSUserDefaults(@"accountName");
            SaveDataToNSUserDefaults(_accountNumberTF.text, @"accountName");
            //网络请求
            [self hiddenAllProgressHUD];
            //存储当前账号
            //SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
            account.userName = _accountNumberTF.text;
            account.password = _passwordTF.text;
            [[CMAccountTool sharedCMAccountTool] addAccount:account];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginWin" object:self];
            //存储以下当前时间
           SaveDataToNSUserDefaults([NSDate date], kVerifyStareDateKey);
            [self showMainViewController];
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:@"账户名或者密码错误" hiddenDelayTime:2];
        }];
    }
}
- (void)showMainViewController {
    AppDelegate *app = [AppDelegate shareDelegate];
    if ([app.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        app.window.rootViewController = app.viewController;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(CMCodeAlert*)CodeAlert{
    if (!_CodeAlert) {
        _CodeAlert=[[CMCodeAlert alloc]init];
        _CodeAlert.delagete=self;
    }
    
    return _CodeAlert;
}
#pragma mark - UITextFieldDelegate
//将要开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (iPhone5) {
//        if (_homeViewTopLayout.constant == -100) {
//            return;
//        }
//        [UIView animateWithDuration:0.2 animations:^{
//            _homeViewTopLayout.constant += -50;
//        }];
//    }
//    
}

//将要结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}


#pragma mark - touch
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    _homeViewTopLayout.constant = 0.0f;
//    
//    [self.view endEditing:YES];
    
//}

#pragma mark - self set

//请求前，检查数据的有效性
- (BOOL)checkDataValidity {
    if (_accountNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"账号不能为空"];
        return NO;
    }
    else if (!_accountNumberTF.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"手机号格式错误"];
        return NO;
    }
    else if (_passwordTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"密码不能为空"];
        return NO;
    } else {
        return YES;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - sliderEvent

- (IBAction)sliderBtnEvent:(id)sender {
    
    [self.view endEditing:YES];
    UIButton *senderBtn=(UIButton*)sender;
    if (senderBtn==self.oldBtn) {
        return ;
    }
    self.oldBtn.selected=NO;
    senderBtn.selected=YES;
    self.oldBtn=senderBtn;
    
 self.sliderView.center=CGPointMake(senderBtn.center.x, self.sliderView.center.y);
        CGRect rect = CGRectMake((senderBtn.tag-10) *CGRectGetWidth(self.sliderScollView.frame), 0, CGRectGetWidth(self.sliderScollView.frame), CGRectGetHeight(self.sliderScollView.frame));
       [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [self.sliderScollView scrollRectToVisible:rect animated:NO];
        } completion:^(BOOL finished) {
        }];
    
    
}
#pragma mark  验证登录

//请求前，检查数据的有效性
- (BOOL)checkCodePhoneValidity {
    if (_codePhoneFiled.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"账号不能为空"];
        return NO;
    }
    else if (!_codePhoneFiled.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"手机号格式错误"];
        return NO;
    }
     else {
        return YES;
    }
}
- (BOOL)checkCodePhoneAndSMSCodeValidity {
    if (_codePhoneFiled.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"账号不能为空"];
        return NO;
    }
    else if (!_codePhoneFiled.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"手机号格式错误"];
        return NO;
    }
  else  if (_codeSmsTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入验证码"];
        return NO;
    }
   
    else {
        return YES;
    }
}



- (IBAction)getSMSCodeEvent:(id)sender {
    
    if ([self checkCodePhoneValidity]) {
        [self.view endEditing:YES];
       
        //弹出手势框
        
        
        
        [self.view.window addSubview:self.CodeAlert];
        
        
        
        
    }
}

-(void)validSuccessWithToken:(NSString *)token{
    
    MyLog(@"验证成功+++%@",token);
    SaveDataToNSUserDefaults(_codePhoneFiled.text, kVerifyMobilePhonePassWordKey);
    SaveDataToNSUserDefaults([NSDate date], kVerifyStarDatePassWordKey);
    
 
    [CMRequestAPI cm_toolFetchShortMessagePhoneNumber:_codePhoneFiled.text andGestureToken:token success:^(BOOL isSucceed) {
        
        
        if (isSucceed) {
           // 判断定时器
                    if (!self.verifyPhoneTimer || !self.verifyPhoneTimer.isValid) {
                        [self openPhoneTimer];
                    }
                    [_verifyPhoneTimer fire];
            
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)codeLoginEvent:(id)sender {
    
    if ([self checkCodePhoneAndSMSCodeValidity]){
        
        
        [CMRequestAPI cm_toolFetchShortMessageLogin:_codePhoneFiled.text andSMSCode:_codeSmsTF.text success:^(CMAccount *account) {
            
            DeleteDataFromNSUserDefaults(@"accountName");
            SaveDataToNSUserDefaults(_accountNumberTF.text, @"accountName");
            //网络请求
            [self hiddenAllProgressHUD];
            //存储当前账号
            //SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
            account.userName = _accountNumberTF.text;
            account.password = _passwordTF.text;
            [[CMAccountTool sharedCMAccountTool] addAccount:account];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginWin" object:self];
            //存储以下当前时间
            SaveDataToNSUserDefaults([NSDate date], kVerifyStareDateKey);
            [self showMainViewController];
        } fail:^(NSError *error) {
            
            
        }];
        
    }
    
    
}
#pragma mark - 定时器 倒计时 获取验证码
//获得倒计时时间
- (NSInteger)getSurplusPhoneTime {
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDatePassWordKey)timeIntervalSince1970];
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSInteger timeInterval = nowTimeInterval - lastTimeInterval;
    NSInteger surplus = kMaxVerifyTime - timeInterval;
    return surplus;
}
//手机计数器
- (void)updatePhoneTimer:(NSTimer *)timer {
    NSInteger surplus = [self getSurplusPhoneTime];
    if (surplus <= 0) {
        _codePhoneFiled.userInteractionEnabled = YES;
        _getCodeBtn.userInteractionEnabled = YES;
        [timer invalidate];//注销定时器
        //删除所保存的key的数据
        DeleteDataFromNSUserDefaults(kVerifyMobilePhonePassWordKey);
        DeleteDataFromNSUserDefaults(kVerifyStarDatePassWordKey);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        _getCodeBtn.userInteractionEnabled = NO;
        NSString *secodsString = [NSString stringWithFormat:@"%ld秒",(long)surplus];
        [_getCodeBtn setTitle:secodsString forState:UIControlStateNormal];
    }
}
//开启一个定时器
- (void)openPhoneTimer {
    self.verifyPhoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePhoneTimer:) userInfo:nil repeats:YES];
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

























