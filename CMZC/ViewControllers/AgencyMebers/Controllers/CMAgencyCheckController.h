//
//  CMAgencyCheckController.h
//  CMZC
//
//  Created by WangWei on 2018/2/1.
//  Copyright © 2018年 MAC. All rights reserved.
//
typedef NS_ENUM(NSInteger,CMCheackStateType) {
   CMUpSuccess, //提交成功
   CMCheacking, //审核中
   CMCheackFail, //审核失败
    
};


#import "CMBaseViewController.h"

@interface CMAgencyCheckController : CMBaseViewController
@property(nonatomic,copy)NSString *StateLab;
@property(nonatomic,assign)CMCheackStateType stateType;

@end
