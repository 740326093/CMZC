//
//  NSString+CMNSString.h
//  CMZC
//
//  Created by WangWei on 17/3/13.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CMNSString)
+(NSString*)currentDateFormatter:(NSString *)formatter;
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString*)dictionaryToDealJson:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;


+(NSString*)base64WithString:(UIImage*)image;

+ (NSString *)removeSpaceAndNewline:(NSString *)str;
@end
