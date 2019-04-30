//
//  CMRegisterViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 MAC. All rights reserved.
//

//找回密码获取手机验证码的通知Key
#define kVerifyMobilePhonePassWordKey @"kVerifyMobilePhonePassWordKey"

#define kVerifyStarDatePassWordKey @"kVerifyStarDatePassWordKey"




#import "CMRegisterViewController.h"
#import "CMFilletButton.h"
#import "CFRegisterServiceView.h"

@interface CMRegisterViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet CMTextField *phoneNumberTF;//手机号码

@property (weak, nonatomic) IBOutlet CMTextField *testingNumberTF;//验证码

@property (weak, nonatomic) IBOutlet CMTextField *passwordTextField;//密码

@property (weak, nonatomic) IBOutlet CMTextField *affirmPasswordTF;//确认密码

@property (weak, nonatomic) IBOutlet CMFilletButton *gainNumberBtn; //获取验证码按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registryViewTopLayout;//view的top

@property (strong, nonatomic) NSTimer *verifyPhoneTimer;//开启一个用手机注册获得验证码时间的定时器
@property (weak, nonatomic) IBOutlet CMFilletButton *registerBtn;  //注册
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;
@property (weak, nonatomic) IBOutlet UITextView *agreementTextView;
@property (strong, nonatomic) CFRegisterServiceView *serviceView;
@end

@implementation CMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //得到倒计时时间。当离开当前页面还能获得。
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_agreementTextView.text];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"tiaoKuan://"
                             range:[[attributedString string] rangeOfString:@"<<新经板注册协议>>"]];
  
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clmHex:0x666666] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedString.length)];
    self.agreementTextView.attributedText = attributedString;
    self.agreementTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor cmThemeCheng]};
    
    NSInteger surplus = [self getSurplusPhoneTime];

    //_registerBtn.enabled = NO;
    if (surplus > 0) {
        self.phoneNumberTF.enabled = NO;
        self.gainNumberBtn.userInteractionEnabled = NO;
        //当程序回来时。显示
        _phoneNumberTF.text = GetDataFromNSUserDefaults(kVerifyMobilePhonePassWordKey);
        //开启一个定时器
        [self openPhoneTimer];
        [_verifyPhoneTimer fire];
    }
    _passwordTextField.delegate = self;
    
    
    
   
}
- (CFRegisterServiceView *)serviceView
{
    if (_serviceView == nil) {
        _serviceView = [[NSBundle mainBundle] loadNibNamed:@"CFRegisterServiceView" owner:nil options:nil].firstObject;
        _serviceView.frame = CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
    }
    return _serviceView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.phoneNumberTF.enabled = YES;
        self.gainNumberBtn.userInteractionEnabled = YES;
        [timer invalidate];//注销定时器
        //删除所保存的key的数据
        DeleteDataFromNSUserDefaults(kVerifyMobilePhonePassWordKey);
        DeleteDataFromNSUserDefaults(kVerifyStarDatePassWordKey);
        [_gainNumberBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
         self.gainNumberBtn.userInteractionEnabled = NO;
        NSString *secodsString = [NSString stringWithFormat:@"%ld秒",(long)surplus];
        [_gainNumberBtn setTitle:secodsString forState:UIControlStateNormal];
    }
}
//开启一个定时器
- (void)openPhoneTimer {
    self.verifyPhoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePhoneTimer:) userInfo:nil repeats:YES];
}
- (IBAction)btnclick:(id)sender {
    
}

#pragma mark - but click
//获取验证码
- (IBAction)gainNumberButClick:(UIButton *)sender {
//    [self.view endEditing:YES];
//    _registryViewTopLayout.constant = 0.0f;
    //验证手机格式
    if ([self verifyThePhoneNumberFormat]) {
//        self.phoneNumberTF.enabled = NO;
//        self.gainNumberBtn.enabled = NO;
        //存储数据
        SaveDataToNSUserDefaults(_phoneNumberTF.text, kVerifyMobilePhonePassWordKey);
        SaveDataToNSUserDefaults([NSDate date], kVerifyStarDatePassWordKey);
        //判断定时器
        if (!self.verifyPhoneTimer || !self.verifyPhoneTimer.isValid) {
            [self openPhoneTimer];
        }
        [_verifyPhoneTimer fire];
        //获取短信验证码
        [CMRequestAPI cm_toolFetchShortMessagePhoneNumber:[_phoneNumberTF.text integerValue] success:^(BOOL isSucceed) {
            
        } fail:^(NSError *error) {
            
        }];
        
        
    }
}

//注册
- (IBAction)registerBtnClick:(id)sender {
//    [self.view endEditing:YES];
//    _registryViewTopLayout.constant = 0.0f;
    if ([self checkDataValidity]) {
        if(_agreementBtn.isSelected==NO){
             [self showAutoHiddenHUDWithMessage:@"请先同意和接受<<新经板注册协议>>"];
            return;
        }
        [CMRequestAPI cm_loginTransferDataPhoneNumber:[_phoneNumberTF.text integerValue] phoneVercode:[_testingNumberTF.text integerValue] password:_passwordTextField.text  confimPassword:_affirmPasswordTF.text success:^(BOOL isSucceed) {
            [_verifyPhoneTimer invalidate];//注销定时器
            //删除所保存的key的数据
            //[self showDefaultProgressHUD]; DeleteDataFromNSUserDefaults(kVerifyMobilePhonePassWordKey);
            DeleteDataFromNSUserDefaults(kVerifyStarDatePassWordKey);

       

    //[self showHUDWithMessage:@"注册成功" hiddenDelayTime:5];
                    
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"注册成功";
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            } completionBlock:^{
                [hud removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            
         
           
           
        } fail:^(NSError *error) {
        
            //[self hiddenProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    }
}
//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {
    if (_phoneNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入手机号"];
        return NO;
    } else if (_testingNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入验证码"];
        return NO;
    } else if (_passwordTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入密码"];
        return NO;
    }  else if (_affirmPasswordTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入确认密码"];
        return NO;
    } else if (![_affirmPasswordTF.text isEqualToString:_passwordTextField.text]) {
        [self showAutoHiddenHUDWithMessage:@"两次密码必须一致"];
        return NO;
    } else {
        return YES;
    }
}

//获取验证码前，验证手机号码格式
- (BOOL)verifyThePhoneNumberFormat {
    if (_phoneNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入手机号"];
        return NO;
    }else if (!_phoneNumberTF.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"请输入正确的手机号"];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - UITextFieldDelegate
//将要开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (iPhone5) {
//        if (_registryViewTopLayout.constant == -150) {
//            return;
//        }
//        [UIView animateWithDuration:1 animations:^{
//            _registryViewTopLayout.constant += -50.0f;
//        }];
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
     NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.phoneNumberTF) {
        if (str.length >= 11) {
            _gainNumberBtn.enabled = YES;
        }else {
            _gainNumberBtn.enabled = NO;
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _passwordTextField) {
        if (![textField.text judgePassWordLegal:textField.text]) {
            textField.text = @"";
            [self showHUDWithMessage:@"必须字母开头，6-18位字母和数字组成" hiddenDelayTime:2];
            return;
        }
    }
}

#pragma mark -注册协议

- (IBAction)agreementBtnEvent:(id)sender {
    
    UIButton *sendBtn=(UIButton*)sender;
    sendBtn.selected =!sendBtn.selected;
    
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"tiaoKuan"]) {
    [self.view.window addSubview:self.serviceView];
        return NO;
    }
    return YES;
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//    _registryViewTopLayout.constant = 0.0f;
//    if (_affirmPasswordTF.text.length >0) {
//        //_registerBtn.alpha = 1.0f;
//       // _registerBtn.enabled = YES;
//    } else {
//       // _registerBtn.enabled = NO;
//        //_registerBtn.alpha = 0.5f;
//    }
//    
//    
//}

- (void)dealloc {
    if (_verifyPhoneTimer && _verifyPhoneTimer.isValid) {
        [_verifyPhoneTimer invalidate];
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






























