//
//  CMJSProtocol.m
//  CMZC
//
//  Created by WangWei on 17/3/1.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMJSProtocol.h"

@implementation CMJSProtocol

-(void)showShareView{
    
    [self.delegate showShareView];
}
- (void)share:(NSString *)title describeContent:(NSString *)content interlnkageSite:(NSString *)siteUrl pictureStie:(NSString *)pictureUrl {
    [self.delegate share:title describeContent:content interlnkageSite:siteUrl pictureStie:pictureUrl];
}


@end
