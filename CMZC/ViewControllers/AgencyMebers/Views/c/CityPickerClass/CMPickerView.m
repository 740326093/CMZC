//
//  CMPickerView.m
//  CMZC
//
//  Created by WangWei on 2018/2/6.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMPickerView.h"

static NSInteger const pickerHeight = 246;
static NSInteger const buttonHeight = 40;
@interface CMPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    

    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录

}
@property (strong, nonatomic)UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic)UIButton *commitButton;
@property (strong, nonatomic)UIButton *cancelButton;


@end

@implementation CMPickerView

-(instancetype)init{
    self=[super init];
    if (self) {
       
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.7f;
        [self addSubview:bgView];
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimissAlert)];
        [bgView addGestureRecognizer:tapGes];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        contentView.frame=CGRectMake(0, CMScreen_height()-pickerHeight, CMScreen_width(),pickerHeight);
        contentView.backgroundColor=[UIColor whiteColor];
        [self addSubview:contentView];
        
        [contentView addSubview:self.cancelButton];
        [contentView addSubview:self.commitButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.top.equalTo(contentView);
            make.left.equalTo(contentView.mas_left).offset(5);
            make.width.equalTo(@50);
        }];
    
        [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.top.equalTo(contentView);
            make.right.equalTo(contentView.mas_right).offset(-5);
            make.width.equalTo(@50);
        }];
        UIView *lineView=[[UIView alloc]init];
        lineView.backgroundColor=[UIColor clmHex:0xefeff4];
        [contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.top.equalTo(self.cancelButton.mas_bottom).offset(5);
            make.left.right.equalTo(contentView);
        }];
        //WithFrame:CGRectMake(0, 31, CMScreen_width(),pickerHeight-buttonHeight-1)
        [self loadData];
        
        
        [contentView addSubview:self.pickerView];
        
        [self.pickerView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom);
            make.left.right.bottom.equalTo(contentView);
        }];
        
        [self ShowAlert];
       // [self getProvinceList];
    }
    return self;
}

#pragma mark - property getter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataSource;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = NO;
    }
    
    return _pickerView;
}
- (UIButton *)commitButton {
    if (!_commitButton) {
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_commitButton setTitle:@"完成" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor clmHex:0xff6400] forState:UIControlStateNormal];
        _commitButton.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    
    return _commitButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor clmHex:0x999999] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _cancelButton;
}
#pragma mark - /** 加载数据源 */
- (void)loadData {
  
   // [self getProvinceList];
    
    NSString *str = [[NSBundle mainBundle]pathForResource:@"city"ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:str];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    if( [array isKindOfClass:[NSArray class]])
        
    {
        
        self.dataSource=[NSMutableArray arrayWithArray:array];
        
    }
    

    [self initData];
    
   
}
-(void)initData
{
    _provinceIndex = _cityIndex = _districtIndex = 0;
}

#pragma mark - UIPickerView 代理和数据源方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
   
   return 3;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.dataSource.count;
    } else if (component == 1) {
        
        return [self.dataSource[_provinceIndex][@"cities"] count];
    } else {
        
        return [self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"] count];
    }
}

// 返回每一行的内容
/*
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return self.dataSource[row][@"province"];
    }
    else if (component == 1){
        return self.dataSource[_provinceIndex][@"citys"][row][@"city"];
    }
    else{
        return self.dataSource[_provinceIndex][@"citys"][_cityIndex][@"districts"][row];
    }
}

*/
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
  
    
   
    
    UIView* topLine   =   [pickerView.subviews objectAtIndex:1];
    UIView* botomLine   =   [pickerView.subviews objectAtIndex:2];
    float lineWidth=(CMScreen_width()/3.0-10);
    float interval = (CMScreen_width()-lineWidth*3)/4.0;//间隔
    
    for (int i=0; i<3; i++) {
        UIView *linView=[[UIView alloc]initWithFrame:CGRectMake(i%3*(lineWidth+interval)+interval, 0,lineWidth , 2)];
        linView.backgroundColor=[UIColor clmHex:0xff6400];
        [topLine addSubview:linView];
    }
    
    for (int i=0; i<3; i++) {
        UIView *linView=[[UIView alloc]initWithFrame:CGRectMake(i%3*(lineWidth+interval)+interval, 0,lineWidth , 2)];
        linView.backgroundColor=[UIColor clmHex:0xff6400];
        [botomLine addSubview:linView];
    }
    

   UILabel *label = [[UILabel alloc]init];
   label.font = [UIFont systemFontOfSize:16];
   label.textAlignment = NSTextAlignmentCenter;
    label.textColor=[UIColor clmHex:0x333333];
 
     if (component == 0) {
        
        NSDictionary *ProviceDict = [self.dataSource objectAtIndex:row];
         
        //NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:pro.name attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor clmHex:0x333333]}];
        label.text =ProviceDict [@"areaName"];
         
    } else if (component == 1) {
        NSArray *cityes=  self.dataSource[_provinceIndex][@"cities"];
       
      if (cityes.count > row) {
            
          //  LZCity *city = [__currentProvience.cities objectAtIndex:row];
        //  NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:city.name attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor clmHex:0x333333]}];
          label.text = cityes[row][@"areaName"];
        }
    } else {
        NSArray *districtsArr=self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"];
      if (districtsArr.count > row) {
            
          //  LZArea *area = [__currentCity.areas objectAtIndex:row];
         // NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:area.name attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor clmHex:0x333333]}];
       label.text = districtsArr[row][@"areaName"];
      }
    }
 


    
    
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    /*
    if (component == 0) {
        
        LZProvince *province = [self.dataSource objectAtIndex:row];
        __currentProvience = province;
        
        LZCity *city = [province.cities firstObject];
        __currentCity = city;
        
        __currentArea = [city.areas firstObject];
      
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if (component == 1) {
        
        if (__currentProvience.cities.count > row) {
            
            LZCity *city = [__currentProvience.cities objectAtIndex:row];
            __currentCity = city;
            
            __currentArea = [city.areas firstObject];
        }
        
       
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if (component == 2) {
        
        if (__currentCity.areas.count > row) {
            __currentArea = [__currentCity.areas objectAtIndex:row];
        }
    }
    
    // 选择结果回调
  
        
    NSString *address = [NSString stringWithFormat:@"%@-%@-%@",__currentArea.province,__currentArea.city,__currentArea.name];
    
    if (address) {
       self.lz_backBlock(address,__currentArea.province,__currentArea.city,__currentArea.name);
    }

     
     */
    
    
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    }
    else if (component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:2];
    }
    else{
        _districtIndex = row;
    }
    
    // 重置当前选中项
    [self resetPickerSelectRow];
    
    NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.dataSource[_provinceIndex][@"areaName"], self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"areaName"], self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"][_districtIndex][@"areaName"]];
    
   // [self getCityListWithCodeWithCode:self.dataSource[_provinceIndex][@"cityID"]];
   
    if (address) {
    
        if ([self.delegate respondsToSelector:@selector(backProviceMessage:andProviceCode:andCityCode:withDistCode:)]) {
        [self.delegate backProviceMessage:address andProviceCode:self.dataSource[_provinceIndex][@"areaId"] andCityCode:self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"areaId"] withDistCode:self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"][_districtIndex][@"areaId"]];
        }
    }
     
    
}


#pragma mark - 按钮点击事件
- (void)commitButtonClick:(UIButton *)button {
    
    // 选择结果回调
    /*
        NSString *address = [NSString stringWithFormat:@"%@-%@-%@",__currentArea.province,__currentArea.city,__currentArea.name];
    if (address) {
    self.lz_backBlock(address,__currentArea.province,__currentArea.city,__currentArea.name);
    }
     */
    
    
   // NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.dataSource[_provinceIndex][@"province"], self.dataSource[_provinceIndex][@"citys"][_cityIndex][@"city"], self.dataSource[_provinceIndex][@"citys"][_cityIndex][@"districts"][_districtIndex]];
    
     NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.dataSource[_provinceIndex][@"areaName"], self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"areaName"], self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"][_districtIndex][@"areaName"]];
    
    if (address) {
      
        if ([self.delegate respondsToSelector:@selector(backProviceMessage:andProviceCode:andCityCode:withDistCode:)]) {
           [self.delegate backProviceMessage:address andProviceCode:self.dataSource[_provinceIndex][@"areaId"] andCityCode:self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"areaId"] withDistCode:self.dataSource[_provinceIndex][@"cities"][_cityIndex][@"counties"][_districtIndex][@"areaId"]];
           
        }
    }
  
    [self dimissAlert];
    
}

-(void)resetPickerSelectRow
{
    [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];
    [self.pickerView selectRow:_districtIndex inComponent:2 animated:YES];
}

- (void)cancelButtonClick:(UIButton *)button {
    
    [self dimissAlert];
}

// //展示alertView
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dimissAlert{
    
    [self removeFromSuperview];
}

/*
-(void)getProvinceList{
    

    [[CMAgencesRequest sharedAPI]requestProvicessuccess:^(id responseObj) {
        if([[responseObj objectForKey:@"respCode"]intValue]==1){
            MyLog(@"省份__%@",[responseObj objectForKey:@"data"]);

        }
        
    } failure:^(NSError *error) {
        
    }];
    
  
    
    
}

-(void)getCityListWithCodeWithCode:(NSString*)code{
    [[CMAgencesRequest sharedAPI]requestCityWithCode:code success:^(id responseObj) {
          MyLog(@"市县。。。。。%@",responseObj);
        if([[responseObj objectForKey:@"respCode"]intValue]==1){
            MyLog(@"市县。。。。。%@",[responseObj objectForKey:@"data"]);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
 
 */
@end
