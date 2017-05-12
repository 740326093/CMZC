//
//  CMAnswerTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/19.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMAnalystAnswer.h"


@interface CMAnswerTableViewCell : UITableViewCell

@property (strong, nonatomic) CMAnalystViewpoint *point; //回复内容话题

+ (instancetype)cell;

@end
