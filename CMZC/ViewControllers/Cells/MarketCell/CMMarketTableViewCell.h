//
//  CMMarketTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMMarketList.h"


@interface CMMarketTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (strong, nonatomic) CMMarketList *market;

@property (strong, nonatomic) NSArray *dataListArr;

@end
