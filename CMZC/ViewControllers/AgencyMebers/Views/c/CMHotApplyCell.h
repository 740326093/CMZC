//
//  CMHotApplyCell.h
//  CMZC
//
//  Created by WangWei on 2018/3/12.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHotApplyModel.h"
@interface CMHotApplyCell : UITableViewCell

@property(nonatomic,strong)CMHotApplyModel *HotApplyModel;
@property(nonatomic,weak)id delegate;
@end

@protocol CMHotApplyCellDelegate <NSObject>
-(void)applyChengXiaoEventWith:(NSString*)pid;
@end
