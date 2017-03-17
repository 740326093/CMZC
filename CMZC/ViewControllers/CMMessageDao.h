//
//  CMMessageDao.h
//  CaiMao
//
//  Created by MAC on 16/6/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMessageDao : NSObject
//创建表
+(BOOL)createTable;
//插入数据
+(BOOL)insertWithMessage:(NSString *)aMessage andMessageUrl:(NSString *)aMessageUrl andTime:(NSString*)aTime andIsread:(NSString*)aIsRead andPage:(NSString*)aPage;

//获得所有信息
+(NSMutableArray*)selectAllMessage;
//删除信息
+(BOOL)deleteRowAtMessageID:(int)aMessageID;
//未读信息个数
+(NSMutableArray*)selectCount;
//修改
+(void)setNoReadBecomeIsRead:(NSString*)aIsRead andBtnTag:(int)aBtnTag;

//删除所有信息
+(BOOL)deleteAllMessage;

@end
