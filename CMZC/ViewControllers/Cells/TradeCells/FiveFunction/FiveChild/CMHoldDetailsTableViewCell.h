//
//  CMHoldDetailsTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHoldInquire.h"

@interface CMHoldDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) CMHoldInquire *hold;

+ (instancetype)cell;

@end
