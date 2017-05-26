//
//  CMMediaNewsCell.h
//  CMZC
//
//  Created by WangWei on 2017/5/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMNewShiModel.h"
@interface CMMediaNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property(nonatomic,strong)CMNewShiModel *ShiModel;

@end
