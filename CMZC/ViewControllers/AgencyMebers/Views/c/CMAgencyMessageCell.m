//
//  CMAgencyMessageCell.m
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMAgencyMessageCell.h"
#import "CMPickerView.h"
#import "CMAgencyCheckController.h"
@interface CMAgencyMessageCell()<UITextFieldDelegate,UIImagePickerControllerDelegate,CMPickerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *commondTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UITextField *AddressField;

@property (weak, nonatomic) IBOutlet UITextField *contactNameField;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneField;
@property (weak, nonatomic) IBOutlet UILabel *phoneErrorLab;
@property (weak, nonatomic) IBOutlet UITextField *contactEmailField;
@property (weak, nonatomic) IBOutlet UIButton *upIconButton;
@property (weak, nonatomic) IBOutlet UIButton *selectOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *accordBtn;
@property (weak, nonatomic) IBOutlet UILabel *iconLab;
@property(nonatomic,copy)NSString *proviceCode;
@property(nonatomic,copy)NSString *cityCode;
@property(nonatomic,copy)NSString *districeCode;
@property(nonatomic,copy)NSString *base64ImageStr;
@end

@implementation CMAgencyMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  //  _upIconButton.layer.borderWidth=1;
  //  _upIconButton.layer.borderColor=[UIColor clmHex:0xe4e4e4].CGColor;
    
    
    CAShapeLayer *border = [CAShapeLayer layer]; //虚线的颜色
    border.strokeColor = [UIColor clmHex:0xe4e4e4].CGColor; //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:
    _upIconButton.bounds cornerRadius:5]; //设置路径
    border.path = path.CGPath;
    border.frame = _upIconButton.bounds; //虚线的宽度
    border.lineWidth = 1.f; //设置线条的样式 //
    border.lineCap = @"square"; //虚线的间隔
    border.lineDashPattern = @[@5.5, @4.5];
    _upIconButton.layer.cornerRadius = 5.f;
    [_upIconButton.layer addSublayer:border];
    

    _contactPhoneField.delegate=self;
    _phoneErrorLab.text=@"";
    _base64ImageStr=@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)upLoadMessaaheEvent:(id)sender {
    if (!_selectOrderBtn.isSelected) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"为了保障您的合法权益,需要您同意合作协议"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
       
        [alert show];
        return;
    }
    
    if([self checkDataValidity]){
        
        [self UpMessage];
        
//        if([self.delegate respondsToSelector:@selector(UploadMessage)]){
//            [self.delegate UploadMessage];
//        }
    }

    
    
    
    
}
- (IBAction)selectAddressEvent:(id)sender {
    
//    if([self.delegate respondsToSelector:@selector(selectAddressEvent)]){
//        [self.delegate selectAddressEvent];
//    }
    [_AgencyMebersController.view endEditing:YES];
    CMPickerView  *picker=[[CMPickerView alloc]init];
    picker.delegate=self;
//    picker.lz_backBlock = ^(NSString *address) {
//        _AddressField.text=address;
//
//        //MyLog(@"+++%@",NewAddress);
//    };
    
}
#pragma mark pickerDelegate
-(void)backProviceMessage:(NSString *)message andProviceCode:(NSString *)proviceCode andCityCode:(NSString *)cityCode withDistCode:(NSString *)distCode{
    
    _AddressField.text=message;
    _proviceCode=proviceCode;
    _cityCode=cityCode;
    _districeCode=distCode;
}
- (IBAction)selectorderFiles:(id)sender {
    UIButton *send=(UIButton*)sender;
    send.selected =!send.selected;
    [send setImage:[UIImage imageNamed:@"option_unselectImage"] forState:UIControlStateNormal];
      [send setImage:[UIImage imageNamed:@"option_selectImage"] forState:UIControlStateSelected];
}
- (IBAction)upIconEventClick:(id)sender {
    //上传头像
//   if ([self.delegate respondsToSelector:@selector(upIconPhoto)]) {
//       [self.delegate upIconPhoto];
//  }
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"从相册选择", nil ,nil];
    // 显示
    [actionsheet showInView:_AgencyMebersController.view];
}

-(void)setSelectAddress:(NSString *)selectAddress{
    
    _AddressField.text=selectAddress;
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    MyLog(@"+++%ld",selectIndex);
    _selectIndex=selectIndex;
    
    switch (selectIndex) {
        case 0:{
            _commondTextField.placeholder=@"*请输入发行人名称";
            _nickTextField.placeholder=@"*请输入发行人简称";
            _iconLab.text=@"上传发行人logo:";
            [_accordBtn setTitle:@"<<新经板发行人会员合作协议>>" forState:UIControlStateNormal];
        }
            
            break;
        case 1:{
            _commondTextField.placeholder=@"*请输入管理人名称";
            _nickTextField.placeholder=@"*请输入管理人简称";
            _iconLab.text=@"上传管理人logo:";
            [_accordBtn setTitle:@"<<新经板领投人会员合作协议>>" forState:UIControlStateNormal];
        }
            
            break;
        case 2:{
            
            _commondTextField.placeholder=@"*请输入保荐人名称";
            _nickTextField.placeholder=@"*请输入保荐人简称";
            _iconLab.text=@"上传保荐人logo:";
            [_accordBtn setTitle:@"<<新经板保荐人会员合作协议>>" forState:UIControlStateNormal];
        }
            
            break;
        default:
            break;
    }
    
    
}
- (IBAction)teamWorkEvent:(id)sender {
    
//    if ([self.delegate respondsToSelector:@selector(ProtocolEventsWithIndex:)]) {
//        [self.delegate  ProtocolEventsWithIndex:_selectIndex];
//    }
//
    NSString *urlStr;
    if (_selectIndex==0) {//发行人
        urlStr=[NSString stringWithFormat:@"%@/agreement/fxr.aspx",kCMMZWeb_url];
    } else if (_selectIndex==1){//管理人
        urlStr=[NSString stringWithFormat:@"%@/agreeMent/ltr.aspx",kCMMZWeb_url];
    }else{//保荐人
        urlStr=[NSString stringWithFormat:@"%@/agreeMent/bjr.aspx",kCMMZWeb_url];
        
    }
    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    commWebVC.urlStr = urlStr;
    [_AgencyMebersController.navigationController pushViewController:commWebVC animated:YES];
    
    
}

//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {
    if (_commondTextField.text.isBlankString) {
        if (_selectIndex==0) {
            [self alertErrorWithmessage:@"请输入发行人名称"];
        
        }else if (_selectIndex==1){
              [self alertErrorWithmessage:@"请输入管理人名称"];
            
        }else{
              [self alertErrorWithmessage:@"请输入保荐人名称"];
            
        }
       
        return NO;
    } else if (_nickTextField.text.isBlankString) {
        if (_selectIndex==0) {
            [self alertErrorWithmessage:@"请输入发行人简称"];
        }else if (_selectIndex==1){
            [self alertErrorWithmessage:@"请输入管理人简称"];
        }else{
            [self alertErrorWithmessage:@"请输入保荐人简称"];
        }
        return NO;
    } else if (_AddressField.text.isBlankString) {
       
        [self alertErrorWithmessage:@"请选择当前所在地区"];
        
        return NO;
    }  else if (_contactNameField.text.isBlankString) {
        [self alertErrorWithmessage:@"请输入联系人姓名"];
        return NO;
    } else if (_contactPhoneField.text.isBlankString) {
        [self alertErrorWithmessage:@"请输入联系人手机号"];
        return NO;
    }  else if (_contactEmailField.text.isBlankString) {
        [self alertErrorWithmessage:@"请输入联系邮箱"];
        return NO;
    }
    else if (![NSString checkUserEmail:_contactEmailField.text]) {

        [self alertErrorWithmessage:@"请输入正确邮箱号"];


        return NO;
    }
    else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==_contactPhoneField) {
        if (![_contactPhoneField.text checkPhoneNumInput]) {
            _phoneErrorLab.text=@"*请输入正确的手机号！";
        }else{
            
            _phoneErrorLab.text=@"";
        }
    }
    
    
}
-(void)alertErrorWithmessage:(NSString*)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"新经板提示" message:message  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
}

-(void)setAgencyMebersController:(CMAgencyMebersController *)AgencyMebersController{
    _AgencyMebersController=AgencyMebersController;
}
-(void)UpMessage{
    
    NSInteger selectNum;
    if(_selectIndex==0){
      selectNum=1;
    }else if (_selectIndex==1){
        selectNum=3;
    }else{
        selectNum=2;
    }
    NSDictionary *messageDict=@{@"HyId":(NSString*)GetDataFromNSUserDefaults(@"userid"),@"IType":[NSString stringWithFormat:@"%ld",(long)selectNum],@"MingCheng":[NSString removeSpaceAndNewline:_commondTextField.text],@"JianCheng":[NSString removeSpaceAndNewline:_nickTextField.text],@"szd_sheng":_proviceCode,@"szd_shi":_cityCode,@"szd_qu":_districeCode,@"lxr_Name":[NSString removeSpaceAndNewline:_contactNameField.text],@"lxr_DianHua":_contactPhoneField.text,@"lxr_YouXiang":_contactEmailField.text};
   // @"Logo":_base64ImageStr
    
    [[CMAgencesRequest  sharedAPI]becomeAgencyMebersWithApi:@"Organization_Req" andMessage:messageDict andLogo:_base64ImageStr success:^(id responseObj) {
   
        MyLog(@"+++%@",responseObj);
        if([[responseObj objectForKey:@"respCode"]integerValue]==1){
            CMAgencyCheckController *installVC = (CMAgencyCheckController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMAgencyCheckController"];
            installVC.stateType=CMUpSuccess;
            [_AgencyMebersController.navigationController pushViewController:installVC animated:YES];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"新经板提示" message:[responseObj objectForKey:@"respDesc"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)successUpLoadMessage{
    
    CMAgencyCheckController *installVC = (CMAgencyCheckController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMAgencyCheckController"];
    installVC.stateType=CMUpSuccess;
    [_AgencyMebersController.navigationController pushViewController:installVC animated:YES];
    
}

#pragma mark actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    MyLog(@"buttonIndex=%ld", buttonIndex);
    
    
    //判断是否可以打开照相机
    if (buttonIndex==0) {
        
        MyLog(@"相机为来源");
        [self photoWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        MyLog(@"相册为来源");
        [self photoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }else{
        MyLog(@"取消");
        
    }
    
    
    
    
}
- (void)photoWithSourceType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = type;
    imagePicker.allowsEditing = YES;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.navigationBar.barTintColor =[UIColor cmThemeCheng];
    if ([UIImagePickerController isSourceTypeAvailable:type]){
        //图片库
        imagePicker.sourceType=type;
        
    }
    [_AgencyMebersController presentViewController:imagePicker animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    _base64ImageStr=[NSString base64WithString:resultImage];

    [_upIconButton setImage:resultImage forState:UIControlStateNormal];
    
    [_AgencyMebersController dismissViewControllerAnimated:YES completion:nil];
}


//点击cancle按钮是调用的协议方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_AgencyMebersController  dismissViewControllerAnimated:YES completion:nil];
    
}
@end
