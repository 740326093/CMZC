    //
//  CMNewQualityTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 MAC. All rights reserved.
//  新品推荐

#import <UIKit/UIKit.h>


@protocol CMNewQualityCellDelegate <NSObject>

/**
 *  传出产品详情id
 *
 *  @param productid 产品id
 */
- (void)cm_newQualityProductId:(NSInteger)productid;

@end

@interface CMNewQualityTableViewCell : UITableViewCell

@property (nonatomic,assign)id<CMNewQualityCellDelegate>delegate;

@property (strong, nonatomic) NSArray *munyArr; //众投宝内容

@property (nonatomic,copy) NSString *buyNumber;

@end
