//
//  CMCodeAlert.m
//  CMZC
//
//  Created by WangWei on 2019/4/20.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMCodeAlert.h"

@interface CMCodeAlert ()<VPEmbedManagerDelegate>

@property (nonatomic, strong) VPEmbedManager *embedManager;
@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UIView  *BackContentView;

@end
@implementation CMCodeAlert

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.frame=CGRectMake(0, 0, CMScreen_width(), CMScreen_height());
        
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        
        UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        
        [self.bottomView addGestureRecognizer:tap];
        //弹框背景
        

        CGSize defaultSize = [self viewDefaultSize];
        [self addSubview:self.embedManager.embedView];
        CGFloat width = defaultSize.width;
        CGFloat percentage = [VPEmbedManager embedViewWidthHeightPercentage];
        [self.embedManager.embedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(self.embedManager.embedView.mas_width).multipliedBy(1/percentage);
        }];
        
        
    }
    return self;
}



#pragma mark Lazy
-(UIView*)bottomView{
    
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=[UIColor blackColor];
        _bottomView.alpha=0.52f;
    }
    return _bottomView;
    
}

-(UIView*)BackContentView{
    
    if (!_BackContentView) {
        _BackContentView=[[UIView alloc]init];
        _BackContentView.backgroundColor=[UIColor whiteColor];
        _BackContentView.layer.cornerRadius=5.0;
        _BackContentView.clipsToBounds=YES;
    }
    return _BackContentView;
    
}
- (VPEmbedManager *)embedManager {
    if (!_embedManager) {
        _embedManager = [VPEmbedManager new];
        _embedManager.delegate = self;
    }
    return _embedManager;
}
- (CGSize)viewDefaultSize {
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGFloat min = MIN(screenFrame.size.width, screenFrame.size.height);
    min = MIN(min, 414.0);
    return CGSizeMake(min-15*2, 40.0);
}


-(void)dismissView{
    [self removeFromSuperview];
}


-(void)resetCode{
    [self.embedManager reset];
}
#pragma mark Delagate
- (void)embedManagerVerifyPassedWithToken:(NSString *)token{
    
    
    if (token.length>0) {
        [self dismissView];
        [self.embedManager reset];
        if ([self.delagete respondsToSelector:@selector(validSuccessWithToken:)]) {
            [self.delagete validSuccessWithToken:token];
        }
    }
    
}

@end
