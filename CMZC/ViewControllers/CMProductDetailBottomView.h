//
//  CMProductDetailBottomView.h
//  CMZC
//
//  Created by WangWei on 2017/4/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

typedef enum : NSInteger {
    consultingBtnClick=1,
    shareBtnClick,
    collectBtnClick,
    subStateBtnClick
} ProductDetailbtnType;

#import <UIKit/UIKit.h>
#import "CMProductDetails.h"
@interface CMProductDetailBottomView : UIView
@property(nonatomic,assign)ProductDetailbtnType type;
@property(nonatomic,assign)id delegate;

@property(nonatomic,strong)CMProductDetails *ProductDetails;
@property(nonatomic,strong)UIButton *collectBtn;//收藏

@end
@protocol CMProductDetailBottomViewDelegate <NSObject>

-(void)CMProductDetailBottomViewBtnEventWith:(ProductDetailbtnType)type;

@end
