//
//  CMConsultController.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMConsultController.h"
#import "CMCustomTextView.h"
@interface CMConsultController ()<CMCustomTextViewDelegate>
@property(nonatomic,strong)UILabel *StatisticsLab;
@property(nonatomic,copy)NSString *textViewString;
@end

@implementation CMConsultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout =UIRectEdgeNone;
        
    }
    switch (_type) {
        case CustomType:
            self.title=@"咨询";
            break;
        case ApplyProject:
            self.title=@"承销项目";
            break;
        case LingTouProject:
            self.title=@"领投项目";
            break;
        default:
            break;
    }
    
    CMCustomTextView *CustomTextView=[CMCustomTextView  initByNibForClassName];
    CustomTextView.layer.masksToBounds=YES;
    CustomTextView.layer.cornerRadius=5.0;
    CustomTextView.delegate=self;
    CustomTextView.type=_type;
    [self.view addSubview:CustomTextView];
    [CustomTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.equalTo(@150);
    }];
    
    [self.view addSubview:self.StatisticsLab];
    [self.StatisticsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(CustomTextView.mas_bottom).offset(10);
    }];
    [self DoubleStringChangeColer:self.StatisticsLab andFromStr:@"入" ToStr:@"字" withColor:[UIColor clmHex:0xff6400]];
}
-(UILabel*)StatisticsLab{
    if (!_StatisticsLab) {
        _StatisticsLab=[[UILabel alloc]init];
        _StatisticsLab.textAlignment=NSTextAlignmentRight;
        _StatisticsLab.font=[UIFont systemFontOfSize:14.0];
        _StatisticsLab.text=@"还可以输入120字(不少于9个字)";
    }
    return _StatisticsLab;
}
- (IBAction)upConsturesEvent:(id)sender {
    
    
//完成
    if (_textViewString.length<=9) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"输入不少于9个字"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    if (_textViewString.length>120) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"输入字数不能多于120个字"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    [self submitMessage];
    
}

-(void)getTextViewContentString:(NSString *)string{
    
    _textViewString=string;
    NSUInteger remainStrLeng=120-_textViewString.length;
    self.StatisticsLab.text=[NSString stringWithFormat:@"还可以输入%ld字(不少于9个字)",remainStrLeng];
    [self DoubleStringChangeColer:self.StatisticsLab andFromStr:@"入" ToStr:@"字" withColor:[UIColor clmHex:0xff6400]];
}
-(void)DoubleStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr ToStr:(NSString *)AToStr withColor:(UIColor*)color {
    
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    NSRange PayFromRang2 = [mainStr.text rangeOfString:AToStr];
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location+1, PayFromRang2.location-PayFromRang1.location-1)];
    mainStr.attributedText = Pay;
    
}

#pragma mark 提交咨询
-(void)submitMessage{
    
    
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"IType":CMStringWithFormat(_type),@"cpid":_pid,@"ThjlId":(NSString*)GetDataFromNSUserDefaults(@"THJLID"),@"NeiRong":[NSString removeSpaceAndNewline:_textViewString]};
    
    [[CMAgencesRequest  sharedAPI]AgencyMebersApplyWithApi:@"SubmitZiXun" andMessage:messageDict success:^(id responseObj) {
        
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:@"您的咨询已经提交给投行经理,请耐心等候！" delegate:self cancelButtonTitle:@"谢谢" otherButtonTitles:nil, nil];
            [alert show];
           // [self showHUDWithMessage:@"" hiddenDelayTime:5];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:[responseObj objectForKey:@"respDesc"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
    [self.navigationController popViewControllerAnimated:YES];
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
