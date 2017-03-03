//
//  CMBLBProductCell.h
//  CMZC
//
//  Created by WangWei on 17/3/2.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBLBProductCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *Index;
@property(nonatomic,strong)CMNumberous *Numberous;
@property(nonatomic,copy)void(^buyInBlock)(NSIndexPath *index);
@end

