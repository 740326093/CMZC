//
//  CMOptionTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  选项

#import <UIKit/UIKit.h>

@protocol CMOptionTableViewCellDelegate <NSObject>
/**
 *  传过去but的tag以便于区分
 *
 *  @param btTag but的tag
 */
- (void)cm_optionTableViewCellButTag:(NSInteger)btTag;

/**
 *
 * 最新公告进入更多
 *
 */
- (void)cm_optionHeadMoreButtonEvent;
/**
 *
 * 最新公告进入详情
 *  @param  index 详情的索引

 */

- (void)cm_optionHeadActinDetail:(NSInteger)index;

@end


@interface CMOptionTableViewCell : UITableViewCell

@property (assign, nonatomic) id<CMOptionTableViewCellDelegate>delegate;

@property(nonatomic,strong)NSMutableArray *gongGaoArr;

@end
