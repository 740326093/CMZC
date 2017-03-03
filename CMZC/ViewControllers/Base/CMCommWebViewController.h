//
//  CMCommWebViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBaseViewController.h"
#import "CMPurchaseProduct.h"
#import "CMJSProtocol.h"
@interface CMCommWebViewController : CMBaseViewController

@property (nonatomic,copy) NSString *urlStr;
@property(nonatomic,strong)CMPurchaseProduct  *PurchaseProduct;


@end
