//
//  CMAnalystDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 MAC. All rights reserved.
//  分析师详情

#import "CMBaseViewController.h"
#import "CMAnalystMode.h"


@interface CMAnalystDetailsViewController : CMBaseViewController

@property (strong, nonatomic) CMAnalystMode *analyst;

@property (nonatomic,assign) NSInteger analystsId; //分析师id

@end
