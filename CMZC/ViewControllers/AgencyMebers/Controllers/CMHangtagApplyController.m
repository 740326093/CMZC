//
//  CMHangtagApplyController.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMHangtagApplyController.h"
#import "CMCodeView.h"
#import "CMAgencyCheckController.h"
@interface CMHangtagApplyController ()<CMCodeViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *applyProjectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *applyRealName;
@property (weak, nonatomic) IBOutlet UITextField *applyWorkName;

@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *financialSizetextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorlab;

@property (weak, nonatomic) IBOutlet CMCodeView *codeView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation CMHangtagApplyController
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        
        [self getCodeNum];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        self.edgesForExtendedLayout =UIRectEdgeNone;
//    }
    _errorlab.text=@"";
    _codeView.delegate=self;
    
    NSString *typeStr=GetDataFromNSUserDefaults(@"OrgType");
    if ([typeStr isEqualToString:@"1"]) {
        self.title=@"挂牌项目申请";
    }else{
       self.title=@"挂牌项目推荐";
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self getCodeNum];
}
- (IBAction)submitEventClick:(id)sender {
    if ([self checkDataValidity]) {
        [self submitMessage];
    }
    
    
}

//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {
    if (_applyProjectNameTextField.text.isBlankString) {
  
            _errorlab.text=@"请输入项目名称";
   
        return NO;
    } else if (_applyRealName.text.isBlankString) {
        
        _errorlab.text=@"请输入联系人姓名";
    
        return NO;
    } else if (_applyWorkName.text.isBlankString) {
        
        _errorlab.text=@"请输入您的职称";
        
        return NO;
    }  else if (_contactPhoneNum.text.isBlankString) {
        _errorlab.text=@"请输入联系人手机号";
        return NO;
    } else if (![_contactPhoneNum.text checkPhoneNumInput]) {
        _errorlab.text=@"请输入正确的手机号";
        return NO;
    }  else if (_financialSizetextField.text.isBlankString) {
        _errorlab.text=@"请输入计划融资规模";
        return NO;
    }
    else if ([_financialSizetextField.text floatValue]<=0.00) {
        _errorlab.text=@"请输入大于0的融资规模";
        return NO;
    }
    else if (_codeTextField.text.isBlankString) {
       _errorlab.text=@"请输入验证码";
        return NO;
    }
    else {
         _errorlab.text=@"";
        return YES;
    }
}
-(void)submitMessage{
    
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"MingCheng":[NSString removeSpaceAndNewline:_applyProjectNameTextField.text],@"Lxr":[NSString removeSpaceAndNewline:_applyRealName.text],@"tel":_contactPhoneNum.text,@"Lxr_ZhiWu":[NSString removeSpaceAndNewline:_applyWorkName.text],@"Amount":[NSString removeSpaceAndNewline:_financialSizetextField.text],@"VerficationCode":[NSString removeSpaceAndNewline:_codeTextField.text]};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GuaPai_Req" andMessage:messageDict success:^(id responseObj) {
        
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
            CMAgencyCheckController *installVC = (CMAgencyCheckController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMAgencyCheckController"];
            installVC.stateType=CMUpSuccess;
            [self.navigationController pushViewController:installVC animated:YES];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:[responseObj objectForKey:@"respDesc"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CMCodeViewDelegate
-(void)changeCode{
    [self getCodeNum];
}
-(void)getCodeNum{
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid")};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"GetVerificationCode" andMessage:messageDict success:^(id responseObj) {
        MyLog(@"+++%@",responseObj);
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
            
            //  NSDictionary *code=responseObj[@"data"];
            
            
            NSDictionary *code= [NSString dictionaryWithJsonString:responseObj[@"data"]];
         //   MyLog(@"code+++%@",code[@"VerificationCode"]);
           _codeView.getCode=code[@"VerificationCode"];
          
            
           
        }else if([[responseObj objectForKey:@"respCode"]integerValue]==0){
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:@"您的操作过于频繁，请稍后再试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
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
