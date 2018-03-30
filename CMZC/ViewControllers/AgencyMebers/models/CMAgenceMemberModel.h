//
//  CMAgenceMemberModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/13.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAgenceMemberModel : NSObject
@property(nonatomic,copy)NSString *THJLID;
@property(nonatomic,copy)NSString *THJLName;
@property(nonatomic,assign)NSInteger OrgType;//机构类型（1：发行人 2：保荐人 3：领投人/管理人 4：承销机构）
@property(nonatomic,copy)NSString *Amount_Lj;
@property(nonatomic,copy)NSString *Tzr_Count;
@property(nonatomic,copy)NSString *YongJin;
@property(nonatomic,copy)NSString *THJLPhotoPic;
@property(nonatomic,copy)NSString *ProjectCount;
@property(nonatomic,copy)NSString *YouZhiProjectCount;
@property(nonatomic,copy)NSString *YongJin_Today;
@property(nonatomic,copy)NSString *OrgJianCheng;
@end
