//
//  CMJSProtocol.m
//  CMZC
//
//  Created by WangWei on 17/3/1.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMJSProtocol.h"

@implementation CMJSProtocol



- (void)share:(NSString *)key{
   
     [self.delegate share:key];
    
}

@end
