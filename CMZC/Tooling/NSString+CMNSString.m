//
//  NSString+CMNSString.m
//  CMZC
//
//  Created by WangWei on 17/3/13.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "NSString+CMNSString.h"

@implementation NSString (CMNSString)


+(NSString*)currentDateFormatter:(NSString *)formatter{
    
    NSDate *date=[NSDate date];
    NSDateFormatter *matter =[[NSDateFormatter alloc]init];
    [matter setDateFormat:formatter];
    NSString *Datestr = [matter stringFromDate:date];
    
    return Datestr;
}


+(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers    error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

@end
