//
//  CMMessageDao.m
//  CaiMao
//
//  Created by MAC on 16/6/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMessageDao.h"
#import "CMDataMessage.h"
#import "CMMessage.h"
@implementation CMMessageDao
+(BOOL)createTable
{
    //获取数据库对象,并且打开了数据库
    FMDatabase *db=[CMDataMessage shareDatabase];
    BOOL isok= [db executeUpdate:@"create table if not exists people(PeopleID integer primary key autoincrement,Message text not null,url text,Time text not null,isRead integer,UserID integer)"];
    
    if(![db columnExists:@"UserID" inTableWithName:@"people"]){
        [db executeUpdate:@"ALTER TABLE people ADD COLUMN UserID integer"];
        
    }
    if(![db columnExists:@"page" inTableWithName:@"people"]){
        [db executeUpdate:@"ALTER TABLE people ADD COLUMN page Text"];
        
    }
      [CMDataMessage closeDataBase];
    
    if (isok==YES) {
        return YES;
    }else{
        
        return NO;
    }
    
}
+(BOOL)insertWithMessage:(NSString *)aMessage andMessageUrl:(NSString *)aMessageUrl andTime:(NSString*)aTime andIsread:(NSString*)aIsRead andPage:(NSString*)aPage{
    FMDatabase *db=[CMDataMessage shareDatabase];
   NSString *str=@"0";
    //if ([CMRequestManager islogin]) {
       // str=[CMUserDefaults objectForKey:@"userID"];
    //}else{
       // str=@"0";
   // }
    BOOL isOK= [db executeUpdate:@"insert into people(Message,url,Time,isRead,UserID,page)values(?,?,?,?,?,?)",aMessage,aMessageUrl,aTime,aIsRead,str,aPage];
    [CMDataMessage  closeDataBase];
    
    if (!isOK) {
        return NO;
    }
    return YES;
}
+(NSMutableArray*)selectAllMessage{
    FMDatabase *db=[CMDataMessage shareDatabase];
    FMResultSet *set=[db executeQuery:@"select * from people where UserID=? order by PeopleID desc ",@"0"];
    NSMutableArray *arr=[NSMutableArray array];
    while ([set next]) {
        int peopleID= [set intForColumn:@"peopleID"];
        NSString *name1=[set stringForColumnIndex:1];
        NSString *url1=[set stringForColumnIndex:2];
        NSString *time=[set stringForColumnIndex:3];
         NSString *is=[set stringForColumnIndex:4];
        NSString *UserID=[set stringForColumnIndex:5];
        NSString *page=[set stringForColumnIndex:6];
        CMMessage *p=[[CMMessage alloc]init];
        p.messageId=peopleID;
        p.message=name1;
        p.url=url1;
        p.time=time;
        p.isread=[is intValue];
        p.UserID=UserID;
        p.page=page;
        [arr addObject:p];
        
        
    }
    [set close];
    [CMDataMessage closeDataBase];
    
    return arr;
}
+(BOOL)deleteRowAtMessageID:(int)aMessageID
{
    FMDatabase *db=[CMDataMessage shareDatabase];
    
    BOOL isok= [db executeUpdate:@"delete from people where peopleID=?",@(aMessageID)];
    [CMDataMessage closeDataBase];
    if (!isok) {
        return NO;
    }
    return YES;
}

+(BOOL)deleteAllMessage{
    FMDatabase *db=[CMDataMessage shareDatabase];
    
    BOOL isok= [db executeUpdate:@"delete from people where UserID=?",@"0"];
    [CMDataMessage closeDataBase];
    if (!isok) {
        return NO;
    }
    return YES;
    
}
+(NSMutableArray*)selectCount{
    FMDatabase *db=[CMDataMessage shareDatabase];
    FMResultSet *set=[db executeQuery:@"SELECT * FROM people where isRead==1 And UserID=?",@"0"];
    
    NSMutableArray *arr=[NSMutableArray array];
    while ([set next]) {
        NSString * tableCount= [NSString stringWithFormat:@"%d",[set intForColumnIndex:0]];
    
        [arr addObject:tableCount];
      }
    [set close];
    [CMDataMessage closeDataBase];
    return arr;
}

+(void)setNoReadBecomeIsRead:(NSString*)aIsRead andBtnTag:(int)aBtnTag{
    FMDatabase *db=[CMDataMessage shareDatabase];
    
    BOOL isok=  [db executeUpdate:@"UPDATE people set isRead= ? where PeopleID= ? AND UserID=?",aIsRead,@(aBtnTag),@"0"];
    [CMDataMessage closeDataBase];
    if(isok){
        MyLog(@"isread==%@",[CMMessageDao selectAllMessage]);

    }
}
@end
