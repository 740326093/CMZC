//
//  CMTradeViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 MAC. All rights reserved.
//  交易


#import "CMBaseViewController.h"

@protocol CMTradeViewControllerDelegate <NSObject>



@end

@interface CMTradeViewController : CMBaseViewController

@property(nonatomic,assign)BOOL isHidebottom;

@end
