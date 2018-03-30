//
//  CMNoNetworkView.m
//  CMZC
//
//  Created by WangWei on 2018/3/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMNoNetworkView.h"
#import "CMSettingNetWorkView.h"
@implementation CMNoNetworkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)settingNetWorkEvent:(id)sender {
 CMSettingNetWorkView *settingView=  [CMSettingNetWorkView initByNibForClassName];
    
    settingView.frame=CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
}

@end
