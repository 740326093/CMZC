//
//  CMHomeDQCell.h
//  CaiMao
//
//  Created by WangWei on 2018/9/6.
//  Copyright © 2018年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMYCFPrModel.h"
@interface CMHomeDQCell : UICollectionViewCell
@property(nonatomic,weak)id delegate;
@property(nonatomic,strong)CMYCFPrModel *YCFListModel;

@end
@protocol CMHomeDQCellDelegate <NSObject>


-(void)CanBtnEvent;


@end
