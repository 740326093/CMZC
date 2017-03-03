//
//  CMNewActionHeadView.h
//  CMZC
//
//  Created by WangWei on 17/2/23.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMNewActionHeadView : UICollectionReusableView<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *leftOneImage;
@property(nonatomic,strong)UIImageView *leftTwoImage;
@property(nonatomic,strong)UIScrollView *cureScrollView;
@property(nonatomic,strong)UIButton *moreBtn;
@property (strong, nonatomic) NSTimer *curTimer;
@property(nonatomic,weak) id delegate;
@property (nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,strong) NSMutableArray *titleArr;

//@property(nonatomic,strong) NSMutableArray *titleReceiveArr;

@end

@protocol CMNewActionHeadViewDelegate <NSObject>

-(void)MoreButtonClick;
-(void)clickNewActionDetail:(NSInteger)index;
@end
