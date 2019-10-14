//
//  CMGuideView.m
//  CMZC
//
//  Created by WangWei on 17/2/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMGuideView.h"

@implementation CMGuideView

- (instancetype)init:(NSArray *)imageArray {
    self = [super init];
    if(self) [self initThisView:imageArray];
    return self;
}

- (void)initThisView:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.frame = CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
    self.scrollView.contentSize=CGSizeMake(CMScreen_width() * _imageArray.count, CMScreen_height());

    for (int i = 0; i < imageArray.count; i++) {
        UIImage *image=[UIImage imageNamed:imageArray[i]];
        CGRect frame = CGRectMake(i * CMScreen_width(), 0, CMScreen_width(),  CMScreen_height());
        UIImageView *img=[[UIImageView alloc] initWithFrame:frame];
        img.userInteractionEnabled=YES;
        img.image=image;
        [self.scrollView addSubview:img];
        
        if (i==imageArray.count-1) {
            [img addSubview:self.enterButton];
            [self.enterButton  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img.mas_left).offset(45);
                make.right.equalTo(img.mas_right).offset(-45);
                make.height.equalTo(@60);
                kDevice_Is_iPhoneX ?make.bottom.equalTo(img.mas_bottom).offset(-120):
                make.bottom.equalTo(img.mas_bottom).offset(-80);
            }];
        }
        
        
    }
    
 
    [self addSubview:self.scrollView];
  
    
}


-(void)dismissGuideView {
    if ([self.delegate respondsToSelector:@selector(enterAppMainController)]) {
        [self.delegate  enterAppMainController];
    }
    
    
}


#pragma mark Lazy
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        
        _scrollView=[[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.tag=7000;
        //_scrollView.delegate = self;
    }
    
    return _scrollView;
}

-(UIButton*)enterButton{
    if (!_enterButton) {
        
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // passbtn.frame= CGRectMake(CMScreenW/2.0-80, CMScreenH-80, 80, 40);
        [_enterButton addTarget:self action:@selector(dismissGuideView) forControlEvents:(UIControlEventTouchUpInside)];
//        _enterButton.layer.borderColor=[UIColor cmThemeCheng].CGColor;
//        _enterButton.layer.borderWidth=0.5;
//        _enterButton.layer.cornerRadius=3.0;
//        _enterButton.layer.masksToBounds=YES;
        
        [_enterButton setBackgroundColor:[UIColor clearColor]];
//        [_enterButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
//        [_enterButton setTitleColor:[UIColor cmThemeCheng] forState:UIControlStateNormal];
//        
//        [_enterButton setTitle:@"立即体验" forState:(UIControlStateNormal)];
        
        
    }
    
    return _enterButton;
}




@end
