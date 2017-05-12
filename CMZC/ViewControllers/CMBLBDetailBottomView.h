//
//  CMBLBDetailBottomView.h
//  CMZC
//
//  Created by WangWei on 2017/4/25.
//  Copyright © 2017年 MAC. All rights reserved.
//


typedef enum : NSUInteger {
    ConsultBtnClick=1,
    CollectClick,
    TransferClick,
    RedeemClick
} BLBDetailBtnType;


#import <UIKit/UIKit.h>

@interface CMBLBDetailBottomView : UIView
@property(nonatomic,assign)BLBDetailBtnType type;
@property(nonatomic,assign)id delegate;
@property(nonatomic,strong)CMProductDetails *ProductDetails;

@end
@protocol CMBLBDetailBottomViewDelegate <NSObject>

-(void)CMBLBDetailBottomViewBtnEventWith:(BLBDetailBtnType)type;

@end
