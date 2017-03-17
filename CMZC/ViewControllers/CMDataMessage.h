//
//  CMDataMessage.h
//  CaiMao
//
//  Created by MAC on 16/6/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CMDataMessage : NSObject

+(FMDatabase*)shareDatabase;
+(BOOL)openDataBase;
+(BOOL)closeDataBase;
+(NSString *)getFilePath;
@end
