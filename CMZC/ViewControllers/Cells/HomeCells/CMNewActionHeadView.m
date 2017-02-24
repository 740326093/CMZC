//
//  CMNewActionHeadView.m
//  CMZC
//
//  Created by WangWei on 17/2/23.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMNewActionHeadView.h"
#import "CMNewShiModel.h"
@implementation CMNewActionHeadView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clmR:228 G:228 B:228];
        [self addSubview:self.leftOneImage];
        [self addSubview:self.leftTwoImage];
        [self addSubview:self.moreBtn];
        [self addSubview:self.cureScrollView];

        [self layoutSubviews];
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [self.leftOneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.leftOneImage.image.size.height);
        make.width.mas_equalTo(self.leftOneImage.image.size.width);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    [self.leftTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.leftTwoImage.image.size.height);
        make.width.mas_equalTo(self.leftTwoImage.image.size.width);
        make.left.equalTo(self.leftOneImage.mas_right);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@50);
        make.height.equalTo(self);
    }];
    self.cureScrollView.frame=CGRectMake(80, 0,CMScreen_width()-130, 30);
   
}
#pragma mark Lazy
-(UIImageView*)leftOneImage{
    if (!_leftOneImage) {
        _leftOneImage=[[UIImageView alloc]init];
        _leftOneImage.image=[UIImage imageNamed:@"new_gonggao"];
    }
    return _leftOneImage;
}
-(UIImageView*)leftTwoImage{
    if (!_leftTwoImage) {
        _leftTwoImage=[[UIImageView alloc]init];
        _leftTwoImage.image=[UIImage imageNamed:@"newbell"];
    }
    return _leftTwoImage;
}
-(UIButton*)moreBtn{
    if (!_moreBtn) {
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor clmHex:0x999999] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_moreBtn addTarget:self action:@selector(moreBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    }
    return _moreBtn;
}
-(UIScrollView*)cureScrollView{
    if (!_cureScrollView) {
        _cureScrollView=[[UIScrollView alloc]init];
        _cureScrollView.showsVerticalScrollIndicator=NO;
        _cureScrollView.showsHorizontalScrollIndicator=NO;
        _cureScrollView.delegate=self;
        _cureScrollView.pagingEnabled=YES;
        _cureScrollView.bounces=NO;
        
    }
    return _cureScrollView;
}


-(void)moreBtnEvent{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(MoreButtonClick)]) {
        [self.delegate MoreButtonClick];
    }
    
}
-(void)setTitleArr:(NSMutableArray *)titleArr{
    _pageIndex = 0;

    if (titleArr.count>0) {
        NSArray *arr=nil;
        if (titleArr.count<=3) {
            arr=titleArr;
           
        }else{
            
            arr=[titleArr subarrayWithRange:NSMakeRange(0, 3)];
            
        }
        [_cureScrollView setContentSize:CGSizeMake(200, 30*arr.count)];
        NSMutableArray *newArr=[NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i <arr.count; i++) {
          
            CMNewShiModel *NoticeModel=arr[i];
            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [titleButton setTitle:NoticeModel.title forState:UIControlStateNormal];
            [titleButton setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
            titleButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            titleButton.frame = CGRectMake(0, 30*i, CGRectGetWidth( self.cureScrollView.frame)-10,30 );
            titleButton.tag=i;
            [titleButton addTarget:self action:@selector(tapDetailEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.cureScrollView addSubview:titleButton];
            [newArr addObject:NoticeModel];
            
    }
       
            
            
            
           [CMCommonTool executeRunloop:^{
                 if (titleArr.count>1) {
                self.curTimer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(captchaChange:) userInfo:newArr repeats:YES];
                       [self.curTimer fire];
                      }
               
             
           } afterDelay:2];
            
       
     }
    
    
    
}
-(void)captchaChange:(NSTimer*)userInf{
       NSArray *userArr=(NSArray*)[userInf userInfo];
    if (userArr && userArr.count > 1) {
        _pageIndex++;

//        if (_pageIndex==userArr.count-1) {
//            _pageIndex=0;
//        }else{
//        _pageIndex ++;
//        }
        if (0<=_pageIndex && _pageIndex<userArr.count) {
            
        }else{
            _pageIndex=0;
            
        }
        
    }

    [self.cureScrollView setContentOffset:CGPointMake(0, 30 *_pageIndex) animated:YES];
}
-(void)tapDetailEvent:(UIButton*)sender{
   
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickNewActionDetail:)]) {
        [self.delegate clickNewActionDetail:sender.tag];
    }
    
}


@end
