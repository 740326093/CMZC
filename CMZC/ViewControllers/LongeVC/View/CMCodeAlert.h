//
//  CMCodeAlert.h
//  CMZC
//
//  Created by WangWei on 2019/4/20.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMCodeAlert : UIView
@property(nonatomic,weak)id delagete;



-(void)resetCode;

@end
@protocol CMCodeAlertDelagte <NSObject>

-(void)validSuccessWithToken:(NSString*)token;

@end
NS_ASSUME_NONNULL_END
