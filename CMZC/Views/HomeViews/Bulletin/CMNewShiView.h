//
//  CMNewShiView.h
//  CMZC
//
//  Created by WangWei on 17/2/23.
//  Copyright © 2017年 郑浩然. All rights reserved.
//新视点

#import <UIKit/UIKit.h>
@class CMNewShiModel;
@protocol CMNewShiViewDelegate <NSObject>
/**
 *  传给vc一个webURL
 *
 *  @param webURL weburl
 */
- (void)cm_NewShiSendModel:(CMNewShiModel *)notice;

@end

@interface CMNewShiView : UIView


@property (nonatomic,assign)id<CMNewShiViewDelegate>delegate;

@end
