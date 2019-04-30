//
//  CMPeiNumCell.h
//  CMZC
//
//  Created by WangWei on 2019/3/21.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMWinning.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMPeiNumCell : UITableViewCell
@property (nonatomic,strong) CMWinning *Prwin;
@property (nonatomic,strong) NSMutableArray *beginEndArray;
@property (nonatomic,strong) NSMutableArray *customArray;

+ (CGFloat)heightWithModel:(NSMutableArray*)model;
@end

NS_ASSUME_NONNULL_END
