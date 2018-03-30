//
//  CMRongZiDetailTopModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/24.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRongZiDetailTopModel : NSObject
//产品标题
@property(nonatomic,copy)NSString *cpTitle;
//融资金额
@property(nonatomic,copy)NSString *Amount;
//申购金额
@property(nonatomic,copy)NSString *Amount_SG;
//机构类型
@property(nonatomic,copy)NSString *ltOrgHyid;
//申购进度
@property(nonatomic,assign)float Percent;
@end
