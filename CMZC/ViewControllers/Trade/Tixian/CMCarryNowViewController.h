//
//  CMCarryNowViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/18.
//  Copyright © 2016年 MAC. All rights reserved.
//  提现

typedef NS_ENUM(NSInteger,CMCarryNowType) {
    CMCarryNowTypeSave,//省
    CMCarryNowTypeCity //城市
};
#import "CMBankBlockList.h"
#import "CMBaseViewController.h"

@interface CMCarryNowViewController : CMBaseViewController

@property (nonatomic,assign) CMCarryNowType type;

@property (nonatomic,copy) NSString *realNameStr;//真实姓名
@property (strong, nonatomic) CMBankBlockList *block;


@end
