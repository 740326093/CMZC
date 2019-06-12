//
//  CMSwitchView.m
//  CMZC
//
//  Created by 云财富 on 2019/5/28.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMSwitchView.h"
@interface CMSwitchView ()


@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)UIButton * SelectBtn;
@property(nonatomic,strong)UIView * moveView;
@end
@implementation CMSwitchView

//- (instancetype)init {
//    if (self = [super init]) {
//        [self initialization];
//    }
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self initialization];
//    }
//    return self;
//}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}
//-(void)awakeFromNib{
//    [super awakeFromNib];
//    [self initialization];
//}

-(void)initialization{
    
    NSLog(@"switchView");
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.moveView];
    
    self.leftBtn.selected=YES;
    self.SelectBtn=self.leftBtn;
    
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftBtn.frame=CGRectMake(0, 0, CMScreen_width()/2.0, self.bounds.size.height-2);
    self.rightBtn.frame=CGRectMake(CMScreen_width()/2.0, 0, CMScreen_width()/2.0,self.bounds.size.height-2);
    self.moveView.frame=CGRectMake(0, self.bounds.size.height-2, CMScreen_width()/2.0, 2);
    
   
}
#pragma mark Lazy
-(UIButton*)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"分佣明细" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithHex:0xff6400] forState:UIControlStateSelected];
        [_leftBtn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
         [_leftBtn addTarget:self action:@selector(inviteFriend:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag=10;
    }
    return _leftBtn;
}

-(UIButton*)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"结算明细" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHex:0xff6400] forState:UIControlStateSelected];
        [_rightBtn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_rightBtn addTarget:self action:@selector(inviteFriend:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.tag=11;
    }
    return _rightBtn;
}
-(UIView*)moveView{
    if (!_moveView) {
        _moveView=[[UIView alloc]init];
        _moveView.backgroundColor=[UIColor clmHex:0xfb3c19];
    }
    return _moveView;
}

-(void)inviteFriend:(UIButton*)sender{
    
    if (self.SelectBtn==sender) {
        return;
        
    }
    self.SelectBtn.selected=NO;
    sender.selected=YES;
    self.SelectBtn=sender;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.moveView.center=CGPointMake(sender.center.x, self.moveView.center.y);
    
    [UIView commitAnimations];
    if ([_delegate respondsToSelector:@selector(selectOffsetWithIndex:)]) {
        [_delegate selectOffsetWithIndex:sender.tag-10];
    }
    
}
@end
