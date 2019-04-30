//
//  CMKDateView.m
//  CMZC
//
//  Created by WangWei on 2018/8/24.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMKDateView.h"
#import "DayKView.h"
#import "WeekLView.h"
#import "MonthKView.h"
@interface CMKDateView ()
@property(nonatomic,strong)UIScrollView *bgScroll;
@property(nonatomic,assign)float dateWidth;
@property(nonatomic,strong)DayKView *dayView;
@property(nonatomic,strong)WeekLView *weekView;
@property(nonatomic,strong)MonthKView *monthView;
@end

@implementation CMKDateView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _dateWidth=self.frame.size.width;
    _bgScroll=[[UIScrollView alloc]initWithFrame:self.frame];
    _bgScroll.showsVerticalScrollIndicator=NO;
    _bgScroll.showsHorizontalScrollIndicator=NO;
    _bgScroll.scrollEnabled=NO;
    [self addSubview:_bgScroll];
        
        _bgScroll.contentSize=CGSizeMake(self.frame.size.width*3, self.frame.size.height);
        
      _dayView=[[DayKView alloc]initWithFrame:CGRectMake(0, 0, self.bgScroll.bounds.size.width, self.bgScroll.bounds.size.height)];
        [self.bgScroll addSubview:_dayView];
        
       _weekView=[[WeekLView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.bgScroll.bounds.size.width, self.bgScroll.bounds.size.height)];
        [self.bgScroll addSubview:_weekView];
        _monthView=[[MonthKView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.bgScroll.bounds.size.width, self.bgScroll.bounds.size.height)];
        [self.bgScroll addSubview:_monthView];
        
        
        
    }
    return self;
}
-(void)setSelectIndex:(NSInteger)selectIndex{
_bgScroll.contentOffset=CGPointMake(selectIndex*_dateWidth, 0);
    
}
-(void)setProductCode:(NSString *)productCode{
    _productCode=productCode;
    _dayView.code=productCode;
    _weekView.code=productCode;
    _monthView.code=productCode;
    
}
@end
