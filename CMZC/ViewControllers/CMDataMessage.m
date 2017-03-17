//
//  CMDataMessage.m
//  CaiMao
//
//  Created by MAC on 16/6/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDataMessage.h"
static FMDatabase *_db=nil;
@implementation CMDataMessage

//通过加号方法创建  获取FMDatabase对象并且打开数据库
+(FMDatabase*)shareDatabase
{

    static dispatch_once_t once_token;
     dispatch_once(&once_token, ^{
         _db=[[FMDatabase alloc]initWithPath:[self getFilePath]];
     });
//    if (_db==nil) {
//        //_db=[[FMDatabase alloc]initWithPath:[self getFilePath]];
//        
//         _db=[[FMDatabase alloc]initWithPath:[CMCache  getFilePath:[NSString stringWithFormat:@"Message%@.sqlite",[CMUserDefaults  objectForKey:@"userID"]]]];
//    }
    [self openDataBase];
    return _db;
}
//打开数据库
+(BOOL)openDataBase
{
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"程序打开失败,程序无法进行");
        return NO;
    }
    return YES;
    
}
//关闭数据库
+(BOOL)closeDataBase
{
    if (![_db close]) { //关闭失败
        
        NSAssert(NO, @"数据库关闭失败");
        return NO;
    }
    
    return YES;
    
}
//保存路径
+(NSString *)getFilePath
{
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Message.sqlite"];
    
}


@end
