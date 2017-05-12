//
//  CMGoldMedalTableViewCell.h
//  CMZC
//
//  Created by MAC on 16/12/24.
//  Copyright © 2016年 MAC. All rights reserved.
//  金牌服务

#import <UIKit/UIKit.h>

@protocol CMGoldMedalTableViewCellDelegate <NSObject>
/**
 跳转到金牌分析师

 @param analystsId 分析师id
 */
- (void)cm_goldMedalAnalystsId:(NSInteger)analystsId;

/**
 跳转到金牌机构

 */
- (void)cm_goldOrganizationEnter;
@end

@interface CMGoldMedalTableViewCell : UITableViewCell

@property (strong, nonatomic) NSArray *glodServiceArr;

@property (weak, nonatomic) id<CMGoldMedalTableViewCellDelegate>delegate;

@end
