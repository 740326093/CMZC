//
//  CMConsultController.h
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//咨询页面

typedef NS_ENUM(NSInteger,ConsultType){
    CustomType=0,//普通咨询
    ApplyProject,//承销
    LingTouProject,//领投
    
};
#import "CMBaseViewController.h"

@interface CMConsultController : CMBaseViewController
@property(nonatomic,assign)ConsultType type;
@property(nonatomic,copy)NSString *pid;
@end
