//
//  CMServerPromptView.m
//  CMZC
//
//  Created by MAC on 16/12/27.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMServerPromptView.h"

@interface CMServerPromptView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *devImageHeightLayout; //标记图片高度
@property (strong, nonatomic)  UIImageView *derImageView; //标示

@property (strong, nonatomic) UIView *BackView;
@property (strong, nonatomic) UIButton *cancleButton;
@property (strong, nonatomic) UIButton *shengQingButton;
@property (strong, nonatomic) UIButton *CallPhoneButton;
@end



@implementation CMServerPromptView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (iPhone7) {
        _devImageHeightLayout.constant = 473.0f;
    }
    
}

-(id)init{
    self=[super init];
    
    if (self) {
        self.frame=CGRectMake(0 , 0, CMScreen_width(), CMScreen_height());
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:self.BackView];
        [self addSubview:self.derImageView];
        [self addSubview:self.cancleButton];
        [self addSubview:self.shengQingButton];
        [self addSubview:self.CallPhoneButton];
        [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.top.equalTo(self);
        }];
      
       
        [self.cancleButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@50);
            make.top.equalTo(self.derImageView);
            make.right.equalTo(self.derImageView);
        }];
        
        
        [self.CallPhoneButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.bottom.equalTo(self.derImageView);
            make.left.right.equalTo(self.derImageView);
        }];
        
        [self.shengQingButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.bottom.equalTo(self.CallPhoneButton.mas_top).offset(-15);
            make.left.right.equalTo(self.derImageView);
        }];
    }
    
    return self;
}


- (void)setImageNameStr:(NSString *)imageNameStr {
    _derImageView.image = [UIImage imageNamed:imageNameStr];
      MyLog(@"____%@",imageNameStr);
    [_derImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.BackView);
        make.height.mas_equalTo( _derImageView.image.size.height);
        make.width.mas_equalTo(_derImageView.image.size.width);
    }];
}
-(UIView*)BackView{
    if (!_BackView) {
        _BackView=[[UIView alloc]init];
        _BackView.backgroundColor=[UIColor blackColor];
        _BackView.alpha=0.45;
    }
    return _BackView;
}

-(UIImageView *)derImageView{
    if (!_derImageView) {
        _derImageView=[[UIImageView alloc]init];
    }
    return _derImageView;
}
-(UIButton*)cancleButton{
    if (!_cancleButton) {
        _cancleButton=[UIButton buttonWithType:UIButtonTypeCustom];
       
        
        [_cancleButton addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
-(UIButton*)CallPhoneButton{
    if (!_CallPhoneButton) {
        _CallPhoneButton=[UIButton buttonWithType:UIButtonTypeCustom];
       
        
        [_CallPhoneButton addTarget:self action:@selector(makePhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _CallPhoneButton;
}
-(UIButton*)shengQingButton{
    if (!_shengQingButton) {
        _shengQingButton=[UIButton buttonWithType:UIButtonTypeCustom];
       
        
        [_shengQingButton addTarget:self action:@selector(listedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shengQingButton;
}
//退出
- (void)exitBtnClick {
    [self removeView];
}
//挂牌
- (void)listedBtnClick{
    self.typeBlock();
    [self removeView];
}
 //打电话
- (void)makePhoneBtnClick {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"4009959825"];
    UIWebView *telWeb = [[UIWebView alloc] init];
    [telWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:telWeb];
}

- (void)removeView{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
