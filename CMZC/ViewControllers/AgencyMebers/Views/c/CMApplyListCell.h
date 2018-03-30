//
//  CMApplyListCell.h
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMApplyModel.h"
#import "CMRongZiModel.h"
#import "CMLingTouModel.h"
@interface CMApplyListCell : UITableViewCell

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)CMApplyModel *applyModel;
@property(nonatomic,strong)CMRongZiModel *RongZiModel;
@property(nonatomic,strong)CMLingTouModel *LingTouModel;

@property(nonatomic,weak)id delegate;
@end
@protocol CMApplyListCellDelegate <NSObject>
-(void)ApplyShareEventWith:(CMApplyModel*)model;
//@optional
//-(void)LiTouZiXunEvent:(CMLingTouModel*)model;
@end
