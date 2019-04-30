//
//  CMPurchaseProduct.h
//  CMZC
//
//  Created by 财猫 on 16/4/18.
//  Copyright © 2016年 MAC. All rights reserved.
//  申购列表

#import <Foundation/Foundation.h>

@interface CMPurchaseProduct : NSObject
/*
attendPersionCount = 10;
cansubscribe = 0;
currentamount = "2402\U4efd";
deadline = "5\U4e2a\U6708";
description = "\U5566\U5566\U5566\U5566\U5566\U7eff";
endtime = "2019-03-20 11:59:59";
growthvalue = 0;
id = 70370;
income = "50.00%";
jyCode = 0125;
leadinvestor = "\U9ed1\U5323\U5b50\U79d1\U6280";
littleTime = "";
liveVideoID = 0;
liveVideoUrl = "<null>";
picture = "http://image.xjb51.com/201804/2018040915-5454-66810.png";
position = "\U798f\U5efa";
starttime = "";
status = "\U7533\U8d2d\U7ed3\U675f";
targetamount = "20000\U4efd";
title = "\U9ed1\U5323\U5b50\U9ed1\U79d1\U6280";
tradecode = 000125;
typename = "\U4e92\U8054\U7f51+";
 */
@property (nonatomic,assign) NSInteger productId; //id产品id
@property (nonatomic,copy) NSString *title; //产品名称
@property (nonatomic,copy) NSString *descri; ///产品的描述
@property (nonatomic,copy) NSString *picture; //产品的图片地址
@property (nonatomic,copy) NSString *targetamount; //产品的众投金额
@property (nonatomic,copy) NSString *currentamount; //产品的已申购金额
@property (nonatomic,copy) NSString *leadinvestor; //产品的领投人
@property (nonatomic,copy) NSString *income; //产品的预计收益
@property (nonatomic,copy) NSString *typeName; //产品的类型名称
@property (nonatomic,copy) NSString *position; //产品的发行人的位置
@property (nonatomic,copy) NSString *growthvalue; //产品的发行人的成长值
@property (nonatomic,copy) NSString *deadline; //产品的期限
@property (nonatomic,copy) NSString *starttime; //产品的申购开始时间
@property (nonatomic,copy) NSString *endtime; //产品的申购结束时间
@property (nonatomic,copy) NSString *status; //产品的状态

@property (nonatomic,strong) UIColor *statusColor; //产品的状态
@property (nonatomic,assign) BOOL cansubscribe; //产品是否可以申购

@property (nonatomic,copy) NSString *littleTime; //剩余天数
@property (nonatomic,copy) NSString *jyCode; //产品编码
@property (nonatomic,assign) NSInteger liveVideoID; //路演直播是否显示 大于0显示
@property (nonatomic,copy) NSString *liveVideoUrl; //路演地址
@property (nonatomic,copy) NSString *startMoney; //起购金额
@property (nonatomic,copy) NSString *bjSecurity; //担保状态
@property (nonatomic,copy) NSString *listedString; //担保状态
- (NSMutableAttributedString *)attributed;

- (BOOL)isNextPage;


@end















































