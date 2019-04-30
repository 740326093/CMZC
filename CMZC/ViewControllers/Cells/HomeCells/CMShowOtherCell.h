//
//  CMShowOtherCell.h
//  CMZC
//
//  Created by WangWei on 2019/3/6.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMShowOtherCellDelegate <NSObject>

-(void)showOtherProductList;

@end
@interface CMShowOtherCell : UITableViewCell

@property(nonatomic,strong)NSArray *barArray;
@property(nonatomic,weak)id<CMShowOtherCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
