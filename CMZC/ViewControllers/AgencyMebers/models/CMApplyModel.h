//
//  CMApplyModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/9.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMApplyModel : NSObject
/***
 **
 产品ID
 **
 ***/
@property(nonatomic,copy)NSString *cpId;
/***
 **
承销金额
 **
 ***/
@property(nonatomic,copy)NSString *Amount_CX;
/***
 **
 实际承销
 **
 ***/
@property(nonatomic,copy)NSString *Amount_SX;
/***
 **
产品状态
 **
 ***/
@property(nonatomic,copy)NSString *cpStatus;
/***
 **
 产品名称
 **
 ***/
@property(nonatomic,copy)NSString *cpName;

/***
 **
 产品编号
 **
 ***/
@property(nonatomic,copy)NSString *zid;

/***
 **
 承销进度
 **
 ***/
@property(nonatomic,assign)float progress;

/***
 **
 产品logo
 **
 ***/
@property(nonatomic,copy)NSString *cpPic;
/***
 **
预期收益
 **
 ***/
@property(nonatomic,copy)NSString *yq_nlv;
/***
 **
领投机构名称
 **
 ***/
@property(nonatomic,copy)NSString *LingTouOrgName;


@end
