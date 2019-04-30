//
//  CMShowHeadTitleView.h
//  CMZC
//
//  Created by WangWei on 2019/3/6.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMShowHeadTitleViewDelegate <NSObject>

-(void)selectIndexPage:(NSInteger)index;

@end
@interface CMShowHeadTitleView : UIView
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,weak)id<CMShowHeadTitleViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
