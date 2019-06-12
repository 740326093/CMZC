//
//  CMCentCommissionDetailView.h
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CMCentCommissionDetailViewDelegate <NSObject>

-(void)refreshData;

@end
@interface CMCentCommissionDetailView : UIView
@property (strong, nonatomic) NSMutableArray *centComissionArray;
@property (weak, nonatomic) id delegate;
@end

NS_ASSUME_NONNULL_END
