//
//  CMConcessionHeadView.h
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMConcessionDetailController.h"
#import "CMApplyModel.h"
#import "CMYongJinListModel.h"
#import "CMRongZiDetailTopModel.h"
@interface CMConcessionHeadView : UIView
@property(nonatomic,assign)CMAgencesDetailType newType;

@property(nonatomic,strong)CMApplyModel *ApplyModel;
@property(nonatomic,strong)CMYongJinListModel *YongJinListModel;

@property(nonatomic,strong)CMRongZiDetailTopModel *RongZiDetailTopModel;
@end
