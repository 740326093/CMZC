//
//  CMAppUpdate.h
//  CMZC
//
//  Created by 云财富 on 2019/7/4.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMVersionModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CMAppUpdateDelegate <NSObject>

-(void)isMustUpdateAPPVersion:(CMVersionModel*)VersionModel;

@end
@interface CMAppUpdate : NSObject

@property(nonatomic,weak)id<CMAppUpdateDelegate>updateDelegate;

@end

NS_ASSUME_NONNULL_END
