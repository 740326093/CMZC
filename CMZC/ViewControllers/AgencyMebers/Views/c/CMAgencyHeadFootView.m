//
//  CMAgencyHeadView.m
//  CMZC
//
//  Created by WangWei on 2018/3/17.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyHeadFootView.h"
#define kVerifyMobilePhonePassKey @"kVerifyMobilePhonePassWordKey"

#define kVerifyStarDatePassKey @"kVerifyStarDatePassWordKey"
@interface CMAgencyHeadFootView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *BcodeTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *registeLab;
@property (weak, nonatomic) IBOutlet UIButton *loginRegistBtn;

@property (weak, nonatomic) IBOutlet UILabel *errorMessage;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smsBtnConstrain;
@property (strong, nonatomic) NSTimer *verifyPhoneTimer;//开启一个用手机注册获得验证码时间的定时器
@end
@implementation CMAgencyHeadFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _registBtn.layer.cornerRadius=5.0;
    _registBtn.layer.masksToBounds=YES;
    
    //    [_phoneTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    //       [_BcodeTextFiled addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEvents];
    
    //得到倒计时时间。当离开当前页面还能获得。
    NSInteger surplus = [self getSurplusPhoneTime];
    
    if (surplus > 0) {
        
        _sendMessageBtn.userInteractionEnabled = NO;
        //当程序回来时。显示
        _phoneTextField.text = GetDataFromNSUserDefaults(kVerifyMobilePhonePassKey);
        //开启一个定时器
        [self openPhoneTimer];
        [_verifyPhoneTimer fire];
    }
}


- (IBAction)loginBtnClick:(id)sender {
    UIButton *btn=(UIButton*)sender;
    _loginRegistBtn=sender;
    if (!btn.selected) {
        _registeLab.text=@"(没有账户,请        ）";
        [_loginRegistBtn setTitle:@"注册" forState:UIControlStateNormal];
        _sendMessageBtn.hidden=YES;
        _BcodeTextFiled.placeholder=@"请输入您的密码";
        _BcodeTextFiled.secureTextEntry=YES;
        _sendMessageBtn.userInteractionEnabled=NO;
        [_registBtn setTitle:@"登录" forState:UIControlStateNormal];
        _smsBtnConstrain.constant=0.001;
    }else{
        _registeLab.text=@"(已是会员,请        ）";
        [_loginRegistBtn setTitle:@"登录" forState:UIControlStateNormal];
        _BcodeTextFiled.placeholder=@"请输入验证码";
        _BcodeTextFiled.secureTextEntry=NO;
        _sendMessageBtn.hidden=NO;
        _sendMessageBtn.userInteractionEnabled=YES;
        [_registBtn setTitle:@"提交" forState:UIControlStateNormal];
        _smsBtnConstrain.constant=100;
    }
    btn.selected =!btn.selected;
    
    
    
    
}
- (IBAction)sendSmsClickEvEvent:(id)sender {
    
    
    if ([self verifyThePhoneNumberFormat]) {
        
        SaveDataToNSUserDefaults(_phoneTextField.text, kVerifyMobilePhonePassKey);
        SaveDataToNSUserDefaults([NSDate date], kVerifyStarDatePassKey);
        //判断定时器
        if (!self.verifyPhoneTimer || !self.verifyPhoneTimer.isValid) {
            [self openPhoneTimer];
        }
        [_verifyPhoneTimer fire];
        //发送验证码
        [CMRequestAPI cm_toolFetchShortMessagePhoneNumber:[_phoneTextField.text integerValue] success:^(BOOL isSucceed) {
            
        } fail:^(NSError *error) {
            
        }];
        
        
    }
    
}
- (IBAction)registClickEvent:(id)sender {
    MyLog(@"_____%d",_loginRegistBtn.selected);
    if([self checkDataValidity]){
        
        if(_loginRegistBtn.selected){
            //登录
            [CMRequestAPI cm_loginTransRegisterClientId:@"CC67712F-4614-40CF-824E-10D784C2A3D7" clientSecret:@"c0aa7577b892ff2ff4ee0109f2932321" userName:_phoneTextField.text password:_BcodeTextFiled.text success:^(CMAccount *account) {
                DeleteDataFromNSUserDefaults(@"accountName");
                SaveDataToNSUserDefaults(_phoneTextField.text, @"accountName");

                //存储当前账号
                //SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
                account.userName = _phoneTextField.text;
                account.password = _BcodeTextFiled.text;
                [[CMAccountTool sharedCMAccountTool] addAccount:account];
                
              
                //存储以下当前时间
                SaveDataToNSUserDefaults([NSDate date], kVerifyStarDateKey);
                
                //判断token
                [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
                    [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
                     
                    SaveDataToNSUserDefaults(account.userid, @"userid");
                    } fail:^(NSError *error) {
                      
                    }];
                } fail:^(NSError *error) {
                 
                    //[self showHUDWithMessage:@"请登录账户" hiddenDelayTime:2];
                }];
                
                
                
                
                
                if ([self.delegate respondsToSelector:@selector(loginBtnEvent)]) {
                    [self.delegate loginBtnEvent];
                }
                
            } fail:^(NSError *error) {
                
                [self showHubView:self messageStr:@"账户名或者密码错误" time:2];
            }];
            
            
        }else{
            //注册
            NSString *psw=[_phoneTextField.text substringFromIndex:_phoneTextField.text.length-6];
            
            [CMRequestAPI cm_loginTransferDataPhoneNumber:[_phoneTextField.text integerValue] phoneVercode:[_BcodeTextFiled.text integerValue] password:psw  confimPassword:psw success:^(BOOL isSucceed) {
                [_verifyPhoneTimer invalidate];//注销定时器
                //删除所保存的key的数据
                DeleteDataFromNSUserDefaults(kVerifyMobilePhonePassKey);
                DeleteDataFromNSUserDefaults(kVerifyStarDatePassKey);
                if(isSucceed){
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:@"注册成功,您的登录密码为手机号后六位,请及时更换密码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } fail:^(NSError *error) {
                
                
                [self showHubView:self messageStr:error.message time:2];
            }];
            
        }
        
        
    }
}

- (BOOL)verifyThePhoneNumberFormat {
    if (_phoneTextField.text.isBlankString) {
        _errorMessage.text=@"请输入手机号";
        
        return NO;
    } else if (!_phoneTextField.text.checkPhoneNumInput) {
        _errorMessage.text=@"请输入正确的手机号";
        return NO;
    } else {
        _errorMessage.text=@"";
        return YES;
    }
}
//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {
    if (_phoneTextField.text.isBlankString) {
        _errorMessage.text=@"请输入您的手机号";
        return NO;
    }else if (!_phoneTextField.text.checkPhoneNumInput) {
        _errorMessage.text=@"请输入正确的手机号";
        return NO;
    }else if (_BcodeTextFiled.text.isBlankString) {
        if(_loginRegistBtn.selected){
            _errorMessage.text=@"请输入您的密码";
        }else{
            _errorMessage.text=@"请输入验证码";
        }
        return NO;
    } else {
        _errorMessage.text=@"";
        return YES;
    }
}

//获得倒计时时间
- (NSInteger)getSurplusPhoneTime {
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDatePassKey)timeIntervalSince1970];
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSInteger timeInterval = nowTimeInterval - lastTimeInterval;
    NSInteger surplus = kMaxVerifyTime - timeInterval;
    return surplus;
}

//开启一个定时器
- (void)openPhoneTimer {
    self.verifyPhoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePhoneTimer:) userInfo:nil repeats:YES];
}

//手机计数器
- (void)updatePhoneTimer:(NSTimer *)timer {
    NSInteger surplus = [self getSurplusPhoneTime];
    if (surplus <= 0) {
        _sendMessageBtn.userInteractionEnabled = YES;
        [timer invalidate];//注销定时器
        //删除所保存的key的数据
        DeleteDataFromNSUserDefaults(kVerifyMobilePhonePassKey);
        DeleteDataFromNSUserDefaults(kVerifyStarDatePassKey);
        [_sendMessageBtn setTitle:@"发送" forState:UIControlStateNormal];
    } else {
        NSString *secodsString = [NSString stringWithFormat:@"%ld秒",(long)surplus];
        _sendMessageBtn.userInteractionEnabled = NO;
        [_sendMessageBtn setTitle:secodsString forState:UIControlStateNormal];
    }
}

@end
