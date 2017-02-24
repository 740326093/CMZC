//
//  CMGuideView.h
//  CMZC
//
//  Created by WangWei on 17/2/22.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMGuideView : UIView
/***********滑动ScrollView****************/
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIButton *enterButton;

- (instancetype)init:(NSArray *)imageArray;
@property(nonatomic,weak)id  delegate;

@end


@protocol CMGuideViewDelegate <NSObject>

-(void)enterAppMainController;

@end
