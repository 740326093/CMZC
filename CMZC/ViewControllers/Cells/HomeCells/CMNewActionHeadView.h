//
//  CMNewActionHeadView.h
//  CMZC
//
//  Created by WangWei on 17/2/23.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMNewActionHeadView : UICollectionReusableView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *leftOneImage;
@property(nonatomic,strong)UIImageView *leftTwoImage;
@property(nonatomic,strong)UIScrollView *cureScrollView;
@property(nonatomic,strong)UIButton *moreBtn;
@property (strong, nonatomic) NSTimer *curTimer;
@property(nonatomic,weak) id delegate;

@property(nonatomic,strong) NSMutableArray *titleArr;

@property(nonatomic,strong) NSArray *DataArr;

@end

@protocol CMNewActionHeadViewDelegate <NSObject>

-(void)MoreButtonClick;
-(void)clickNewActionDetail:(NSInteger)index;
@end
