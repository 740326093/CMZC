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
@end
