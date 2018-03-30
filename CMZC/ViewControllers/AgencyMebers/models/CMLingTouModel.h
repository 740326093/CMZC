//
//  CMLingTouModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/22.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMLingTouModel : NSObject

@property(nonatomic,copy)NSString *pid;
@property(nonatomic,copy)NSString *cpTitle;
@property(nonatomic,copy)NSString *Amount;
@property(nonatomic,copy)NSString *LingTouAmount;
@property(nonatomic,assign)float LingTouPercent;
@property(nonatomic,copy)NSString *ProdeuctStatus;
@property(nonatomic,strong)UIColor *btnColor;
//@property(nonatomic,assign)BOOL isConsult;
@end
