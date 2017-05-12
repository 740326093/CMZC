//
//  CMSubscribeTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 MAC. All rights reserved.
//  申购cell

#import <UIKit/UIKit.h>

@class CMProductList;
@class CMPurchaseProduct;

@protocol CMSubscribeTableViewCellDelegate <NSObject>

- (void)cm_checkRoadshowLiveUrl:(NSString *)liveUrl;
-(void)cm_checkImmediatelySubscribeEventWithPid:(NSInteger)productID;
@end


@interface CMSubscribeTableViewCell : UITableViewCell

//@property (strong, nonatomic) CMProductList *product;

@property (strong, nonatomic) CMPurchaseProduct *product;

@property (weak, nonatomic) id<CMSubscribeTableViewCellDelegate>delegate;

@end
