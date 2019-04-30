//
//  CMShowOtherCell.m
//  CMZC
//
//  Created by WangWei on 2019/3/6.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMShowOtherCell.h"
@interface CMShowOtherCell ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)SDCycleScrollView *sdScrollView;
@end
@implementation CMShowOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreen_width(), 10)];
        lineView.backgroundColor=[UIColor clmHex:0xefeff4];
        [self addSubview:lineView];
        [self addSubview:self.sdScrollView];
        
    }
    
    return self;
}

-(SDCycleScrollView*)sdScrollView{
    if (!_sdScrollView) {
        _sdScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, CMScreen_width(),f_i5real(140))
                                                            delegate:self
                                                    placeholderImage:nil];
        _sdScrollView.autoScrollTimeInterval = 5.;// 自动滚动时间间隔
        _sdScrollView.showPageControl=NO;
    }
    
    return _sdScrollView;
    
}
-(void)setBarArray:(NSArray *)barArray{
    if (barArray.count>0) {
        self.sdScrollView.barModelGrop=barArray;
    }
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToUrl:(NSString *)url{
    
    if ([self.delegate respondsToSelector:@selector(showOtherProductList)]) {
        [self.delegate showOtherProductList];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
