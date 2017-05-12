//
//  CMSettingsView.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMSettingsView.h"

@implementation CMSettingsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self=[super init];
    if (self) {
        self.frame=CGRectMake(0, 0, kCMScreen_width, 60);
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.exitButton];
        [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.centerX.equalTo(self);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@40);
            
        }];
        
    }
    
    return self;
}

-(CMFilletButton*)exitButton{
    if (!_exitButton) {
        _exitButton=[CMFilletButton buttonWithType:UIButtonTypeCustom];
        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor cmThemeOrange]];
        
        [_exitButton addTarget:self action:@selector(settingsBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _exitButton;
}
#pragma mark button方法

- (void)settingsBtnClick:(CMFilletButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_settingsViewDelegate:)]) {
        [self.delegate cm_settingsViewDelegate:self];
    }
    
}

@end
