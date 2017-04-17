//
//  CMCollectCell.h
//  CMZC
//
//  Created by WangWei on 2017/4/14.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPurchaseProduct.h"
@interface CMCollectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *SubStarLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *subproId;

@property (weak, nonatomic) IBOutlet UILabel *subDetail;

@property (weak, nonatomic) IBOutlet UILabel *subFenEr;

@property (weak, nonatomic) IBOutlet UILabel *subperNum;
@property (weak, nonatomic) IBOutlet UILabel *subLingTou;
@property (weak, nonatomic) IBOutlet UILabel *subprogress;
@property (weak, nonatomic) IBOutlet UILabel *subQiXian;
@property (weak, nonatomic) IBOutlet UIButton *appleBtn;

@property(nonatomic,strong)CMPurchaseProduct *product;
@property(nonatomic,strong)NSIndexPath *index;
@property(nonatomic,copy)void(^ applyBtnClickBlock)(NSIndexPath *index);
@end

