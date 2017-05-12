//
//  CMoptionReleaseTableViewCell.h
//  CMZC
//
//  Created by MAC on 17/1/7.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OptionReleaseBlock)();

@protocol CMoptionReleaseTableViewCellDelegate <NSObject>

/**
 * 刷新一下数据
 */
- (void)cm_optionReleaseRequestData:(NSString *)request;

@end


@interface CMoptionReleaseTableViewCell : UITableViewCell

@property (weak, nonatomic) id<CMoptionReleaseTableViewCellDelegate>delegate;

@property (nonatomic,copy) OptionReleaseBlock block;

@end
