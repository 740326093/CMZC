//
//  CMRongZiDetailList.h
//  CMZC
//
//  Created by WangWei on 2018/3/24.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRongZiDetailList : NSObject
@property(nonatomic,copy)NSString *sname;
@property(nonatomic,copy)NSString *jpamount;
@property(nonatomic,copy)NSString *jptime;
@property(nonatomic,assign)NSInteger IsLingTouOrg; //1是领投 0不是
@property(nonatomic,assign)BOOL IsLingTou; 
@end
