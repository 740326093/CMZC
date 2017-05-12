//
//  CMBLBDetailBottomView.m
//  CMZC
//
//  Created by WangWei on 2017/4/25.
//  Copyright © 2017年 MAC. All rights reserved.
//
#import "CMBLBDetailBottomView.h"
@interface CMBLBDetailBottomView ()

@property(nonatomic,strong)UIButton *ConsultBtn;
@property(nonatomic,strong)UIButton *CollectBtn;
@property(nonatomic,strong)UIButton *TransferBtn;
@property(nonatomic,strong)UIButton *RedeemBtn;
@property(nonatomic,strong)UIView *LeftBackview;


@end

@implementation CMBLBDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        int width=self.frame.size.width;
        int height=self.frame.size.height;
        
        float buttonWid=width/3.0;
        [self addSubview:self.LeftBackview];
        self.LeftBackview.frame=CGRectMake(0, 0, buttonWid, height);
        [self addSubview:self.TransferBtn];
        self.TransferBtn.frame=CGRectMake(buttonWid, 0, buttonWid, height);
        [self addSubview:self.RedeemBtn];
        self.RedeemBtn.frame=CGRectMake(buttonWid*2.0, 0, buttonWid, height);
        [self.LeftBackview addSubview:self.ConsultBtn];
        [self.LeftBackview addSubview:self.CollectBtn];
        
        self.ConsultBtn.frame=CGRectMake(0, 0, buttonWid/2.0, height);
        self.CollectBtn.frame=CGRectMake(buttonWid/2.0, 0, buttonWid/2.0, height);
        
        [self.ConsultBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.ConsultBtn.imageView.frame.size.height+5 ,-self.ConsultBtn.imageView.frame.size.width-5, 0.0,0.0)];
        [self.ConsultBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0,0, -self.ConsultBtn.titleLabel.bounds.size.width+5)];
        [self.CollectBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.CollectBtn.imageView.frame.size.height+5 ,-self.ConsultBtn.imageView.frame.size.width-5, 0.0,0.0)];
        [self.CollectBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0,0, -self.CollectBtn.titleLabel.bounds.size.width+5)];
        
        
    }
    
    return self;
}
#pragma mark lazy
-(UIButton*)ConsultBtn{
    if (!_ConsultBtn) {
        
        _ConsultBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _ConsultBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_ConsultBtn setTitle:@"咨询" forState:UIControlStateNormal];
        [_ConsultBtn setImage:[UIImage imageNamed:@"zixun"] forState:UIControlStateNormal];
        _ConsultBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_ConsultBtn setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
        _ConsultBtn.tag=10;
        [_ConsultBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ConsultBtn;
}


-(UIButton*)CollectBtn{
    if (!_CollectBtn) {
        
        _CollectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _CollectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_CollectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_CollectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        
        _CollectBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_CollectBtn setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
        _CollectBtn.tag=11;
        [_CollectBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _CollectBtn;
}

-(UIView*)LeftBackview{
    if (_LeftBackview==nil) {
        
        _LeftBackview=[[UIView alloc]init];
        
    }
    
    return _LeftBackview;
    
}


-(UIButton*)TransferBtn{
    if (!_TransferBtn) {
        
        _TransferBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _TransferBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_TransferBtn setTitle:@"转入" forState:UIControlStateNormal];
        [_TransferBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_TransferBtn setBackgroundColor:[UIColor cmThemeOrange]];
        _TransferBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        _TransferBtn.tag=12;
        [_TransferBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TransferBtn;
}

-(UIButton*)RedeemBtn{
    if (!_RedeemBtn) {
        
        _RedeemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _RedeemBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_RedeemBtn setTitle:@"赎回" forState:UIControlStateNormal];
        [_RedeemBtn setTitleColor:[UIColor cmThemeCheng] forState:UIControlStateNormal];
        [_RedeemBtn setBackgroundColor:[UIColor whiteColor]];
        _RedeemBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        _RedeemBtn.tag=13;
        [_RedeemBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RedeemBtn;
}

-(void)productDetailbtnClickEvent:(UIButton*)sender{
    switch (sender.tag) {
       case 10:
        {
            if ([self.delegate respondsToSelector:@selector(CMBLBDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMBLBDetailBottomViewBtnEventWith:ConsultBtnClick];
            }
            
        }
            break;
        case 11:
        {
            if ([self.delegate respondsToSelector:@selector(CMBLBDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMBLBDetailBottomViewBtnEventWith:CollectClick];
            }
            if (CMIsLogin()) {
                
                
                if (self.CollectBtn.selected==YES) { //已收藏
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [self.CollectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                    [self cancleCollectOrCollectWithType:2];
                    
                }else{ //未收藏
                    [self.CollectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateNormal];
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [self cancleCollectOrCollectWithType:1];
                    
                }
                self.CollectBtn.selected=!self.CollectBtn.selected;
            }else{
                self.CollectBtn.selected=NO;
            }
            
        }
            

        break;
        case 12:
            if ([self.delegate respondsToSelector:@selector(CMBLBDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMBLBDetailBottomViewBtnEventWith:TransferClick];
            }
            
            break;
        case 13:
            if ([self.delegate respondsToSelector:@selector(CMBLBDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMBLBDetailBottomViewBtnEventWith:RedeemClick];
            }
            break;
            
        default:
            break;
    }
    
}


-(void)setProductDetails:(CMProductDetails *)ProductDetails{
    _ProductDetails =ProductDetails;
 
    [self cheackIsCollectWithProductID:ProductDetails.productId];
    
    
}


#pragma mark 判断是否收藏
-(void)cheackIsCollectWithProductID:(NSInteger)prodctID{
    if (CMIsLogin()) {
        [CMRequestAPI cm_applyFetchProductDetailsCollectWithType:0 andProductID:prodctID success:^(id isSuccess) {
            
            
            if ([[isSuccess objectForKey:@"errmsg"]isEqualToString:@"已收藏"]) {
                
                [self.CollectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateNormal];
                self.CollectBtn.selected=YES;
            }
            
        } fail:^(NSError *error) {
            
        }];
    }
    
}
-(void)cancleCollectOrCollectWithType:(NSInteger)type{
    
    [CMRequestAPI cm_applyFetchProductDetailsCollectWithType:type andProductID:_ProductDetails.productId success:^(id isSuccess) {
        
        MyLog(@"取消或者收藏+++%@",[isSuccess objectForKey:@"errmsg"]);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cancleCollectOrCollect" object:self];
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
