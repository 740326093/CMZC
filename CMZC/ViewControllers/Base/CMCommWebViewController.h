//
//  CMCommWebViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMBaseViewController.h"
#import "CMPurchaseProduct.h"
#import "CMProductDetailBottomView.h"
#import "CMConsultingAlertView.h"
#import "CMBLBDetailBottomView.h"


@interface CMCommWebViewController : CMBaseViewController<CMProductDetailBottomViewDelegate>

@property (nonatomic,copy) NSString *urlStr;
@property(nonatomic,assign)NSInteger  ProductId;
@property (nonatomic,assign) BOOL isJPush;
@property (nonatomic,assign) BOOL showRefresh;
@end
