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
+(NSString*)dictionaryToDealJson:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    return jsonString;
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
+(NSString*)base64WithString:(UIImage*)image{
    
    
    // 压缩一下图片再传
    NSData *imgData = UIImageJPEGRepresentation(image, 0.001);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return [NSString removeSpaceAndNewline:encodedImageStr];
    
}

+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
