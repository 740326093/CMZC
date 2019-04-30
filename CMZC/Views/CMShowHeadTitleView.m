//
//  CMShowHeadTitleView.m
//  CMZC
//
//  Created by WangWei on 2019/3/6.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMShowHeadTitleView.h"
#import "CMSliderTitleCell.h"
#import "CMProductType.h"
#define offsetWidth 10

@interface CMShowHeadTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *titleCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout  *FlowlayoutView;
@property(nonatomic,strong)UIView  *sliderView;


@end
@implementation CMShowHeadTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleCollectionView];
        [self.titleCollectionView addSubview:self.sliderView];
        
    }
    return self;
    
}

#pragma mark Lazy
-(UICollectionView*)titleCollectionView{
    if (!_titleCollectionView) {
        
        
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.FlowlayoutView];
        _titleCollectionView.backgroundColor = [UIColor clearColor];
       // _titleCollectionView.pagingEnabled = YES;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.showsVerticalScrollIndicator = NO;
        [_titleCollectionView registerClass:[CMSliderTitleCell class] forCellWithReuseIdentifier:@"titleCollectionView"];
        _titleCollectionView.dataSource = self;
        _titleCollectionView.delegate = self;
        
        
    }
    return _titleCollectionView;
    
}
-(UICollectionViewFlowLayout*)FlowlayoutView{
    if (!_FlowlayoutView) {
        
        _FlowlayoutView = [[UICollectionViewFlowLayout alloc] init];
        _FlowlayoutView.minimumLineSpacing = 0;
        _FlowlayoutView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _FlowlayoutView;
}
-(UIView*)sliderView{
    if (!_sliderView) {
        _sliderView=[[UIView alloc]init];
        _sliderView.backgroundColor=[UIColor clmHex:0xfb3c19];
    }
    return _sliderView;
    
}

- (int)pageCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.titleArray.count;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMSliderTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCollectionView" forIndexPath:indexPath];
    long itemIndex = [self pageCurrentCellIndex:indexPath.item];
   
    CMProductType *prType=_titleArray[itemIndex];
    cell.titleLab.text= prType.name;
    
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    long itemIndex = [self pageCurrentCellIndex:indexPath.item];
    CGFloat itemWidth;
    if (_titleArray.count>4) {
        itemWidth=CMScreen_width()/4.0-offsetWidth;
    } else {
        itemWidth=CMScreen_width()/_titleArray.count;
    }
    
    CMProductType *prType=_titleArray[itemIndex];
   self.sliderView.frame=CGRectMake(itemWidth*itemIndex, CGRectGetHeight(self.frame)-1, itemWidth, 1);
    if ([self.delegate respondsToSelector:@selector(selectIndexPage:)]) {
        [self.delegate selectIndexPage:prType.typeId];
    }
    
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray=titleArray;
    CGFloat itemWidth;
    if (titleArray.count>4) {
        itemWidth=CMScreen_width()/4.0-offsetWidth;
    } else {
        itemWidth=CMScreen_width()/titleArray.count;
    }
    self.FlowlayoutView.itemSize=CGSizeMake(itemWidth, self.bounds.size.height);
    
    [self.titleCollectionView reloadData];
    
    self.sliderView.frame=CGRectMake(0, CGRectGetHeight(self.frame)-1, itemWidth, 1);
    
}


@end
