//
//  CMConcessionDetailCell.h
//  CMZC
//
//  Created by WangWei on 2018/2/5.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMConcessionDetailController.h"
#import "CMCSDetailListModel.h"
#import "CMYongJinDetailListModel.h"
#import "CMRongZiDetailList.h"
@interface CMConcessionDetailCell : UITableViewCell
@property(nonatomic,assign)CMAgencesDetailType newType;
@property(nonatomic,strong)CMCSDetailListModel *listMode;
@property(nonatomic,strong)CMYongJinDetailListModel *YongJinDetailListModel;
@property(nonatomic,strong)CMRongZiDetailList *RongZiDetailList;
@end
