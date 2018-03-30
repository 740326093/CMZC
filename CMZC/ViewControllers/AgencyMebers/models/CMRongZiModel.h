//
//  CMRongZiModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/13.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRongZiModel : NSObject
@property(nonatomic,copy)NSString *cpid;
@property(nonatomic,copy)NSString *cpName;
@property(nonatomic,copy)NSString *Amount;
@property(nonatomic,assign)float rongziJinDu;
@property(nonatomic,assign)NSInteger cpStatus;
@property(nonatomic,assign)NSInteger cpIsEnable;
@property(nonatomic,copy)NSString *shengouAmount;
@property(nonatomic,copy)NSString *cpStatusText;
@property(nonatomic,strong)UIColor *Btncolor;
@property(nonatomic,assign)BOOL enterDetail;
@end
