//
//  CMConcessionDetailController.h
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//佣金承销项目详情

#import "CMBaseViewController.h"

typedef NS_ENUM(NSInteger,CMAgencesDetailType) {
    CMMyApplyDetail,//承销的项目详情
    CMMyConcessionDetail,//佣金明细
    CMFinancingDetail,//融资详情
};

@interface CMConcessionDetailController : CMBaseViewController
@property(nonatomic,assign)CMAgencesDetailType newType;
@property(nonatomic,copy)NSString *productZid;
@end
