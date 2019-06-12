//
//  CMBillingDetailsView.h
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMBillingDetailsViewDelegate <NSObject>

-(void)refreshData;

@end
@interface CMBillingDetailsView : UIView
@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) NSMutableArray *billingArray;
@end

NS_ASSUME_NONNULL_END
