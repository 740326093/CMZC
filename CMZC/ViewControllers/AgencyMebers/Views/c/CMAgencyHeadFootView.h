//
//  CMAgencyHeadView.h
//  CMZC
//
//  Created by WangWei on 2018/3/17.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMAgencyHeadFootViewDelegate <NSObject>

- (void)loginBtnEvent;

@end


@interface CMAgencyHeadFootView : UITableViewHeaderFooterView
@property(nonatomic,weak)id <CMAgencyHeadFootViewDelegate>delegate;
@end
