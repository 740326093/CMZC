//
//  CMScreeningView.h
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CMScreeningViewDelegate <NSObject>

-(void)ShowScreeingList:(UILabel*)titleName;

@end

@interface CMScreeningView : UIView
@property (weak, nonatomic) IBOutlet UILabel *screeingTitle;


@property(nonatomic,weak)id<CMScreeningViewDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
