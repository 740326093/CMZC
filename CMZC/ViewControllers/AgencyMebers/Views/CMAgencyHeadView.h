//
//  CMAgencyHeadView.h
//  CMZC
//
//  Created by WangWei on 2018/1/31.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMAgencyHeadViewDelegate <NSObject>

- (void)selectItemIndex:(NSInteger)index;

@end
@interface CMAgencyHeadView : UIView
@property(nonatomic,weak)id  delegate;
@end
