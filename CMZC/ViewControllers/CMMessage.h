//
//  CMMessage.h
//  CaiMao
//
//  Created by MAC on 16/6/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMessage : NSObject
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)int messageId;
@property(nonatomic,assign)int isread;
@property(nonatomic,copy)NSString *UserID;
@property(nonatomic,copy)NSString *page;
@end
