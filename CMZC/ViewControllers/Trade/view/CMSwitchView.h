//
//  CMSwitchView.h
//  CMZC
//
//  Created by 云财富 on 2019/5/28.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMSwitchViewDelegate <NSObject>

-(void)selectOffsetWithIndex:(NSInteger)offset;

@end
@interface CMSwitchView : UIView
@property(nonatomic,weak)id <CMSwitchViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
