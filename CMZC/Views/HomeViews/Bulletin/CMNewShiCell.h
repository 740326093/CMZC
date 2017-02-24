//
//  CMNewShiCell.h
//  CMZC
//
//  Created by WangWei on 17/2/24.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMNewShiModel.h"
@interface CMNewShiCell : UITableViewCell
@property(nonatomic,strong)CMNewShiModel *ShiModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@end
