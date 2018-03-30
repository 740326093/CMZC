//
//  CMYongJinListModel.h
//  CMZC
//
//  Created by WangWei on 2018/3/22.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMYongJinListModel : NSObject
@property(nonatomic,copy)NSString *zid;
@property(nonatomic,copy)NSString *cpTitle;
@property(nonatomic,copy)NSString *Percent;
@property(nonatomic,copy)NSString *Amount_YongJin;
@property(nonatomic,copy)NSString *JieSuanStatus;
@property(nonatomic,copy)NSString *Amount_SX;

@property(nonatomic,strong)UIColor *statusLabColor;
@end
