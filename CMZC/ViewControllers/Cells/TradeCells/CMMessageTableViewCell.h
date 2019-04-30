//
//  CMMessageTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/6/29.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMMessage.h"
@interface CMMessageTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *titleNameStr;

@property(nonatomic,strong)CMMessage  *messageModel;

+ (CGFloat)heightWithModel:(CMMessage*)model;
@end
