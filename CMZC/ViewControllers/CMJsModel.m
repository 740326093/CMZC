//
//  CMJsModel.m
//  CMZC
//
//  Created by WangWei on 2017/12/8.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMJsModel.h"

@implementation CMJsModel
-(void)callCameraOrPhotosLibrary:(int)type{
    [self.delegate callCameraOrPhotosLibrary:type];
}
- (void)share:(NSString *)title describeContent:(NSString *)content interlnkageSite:(NSString *)siteUrl pictureStie:(NSString *)pictureUrl {
    [self.delegate share:title describeContent:content interlnkageSite:siteUrl pictureStie:pictureUrl];
}

-(void)appLogin{
    
    [self.delegate appLogin];
}

-(void)appLog{
    
    [self.delegate appLog];
}
@end
