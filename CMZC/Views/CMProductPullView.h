//
//  CMProductPullView.h
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CMProductPullViewDelegate <NSObject>

-(void)choseTheCell:(NSInteger)index;

@end
@interface CMProductPullView : UIView

///代理
@property(nonatomic,weak)id<CMProductPullViewDelegate> delegate;

-(instancetype)initShowTheListOnButton:(UILabel *)button Height:(CGFloat)height Titles:(NSArray *)titles;

-(void)hideTheListViewOnButton:(UILabel *)button;
- (void)removeFrom;

@end

NS_ASSUME_NONNULL_END
