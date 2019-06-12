//
//  CMProductDetailBottomView.m
//  CMZC
//
//  Created by WangWei on 2017/4/7.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMProductDetailBottomView.h"
#import "CMShareView.h"
@interface CMProductDetailBottomView ()
@property(nonatomic,strong)UIButton *consultingBtn;//咨询
@property(nonatomic,strong)UIButton *shareBtn;//分享

@property(nonatomic,strong)UIButton *subscribeStateBtn;
@end

@implementation CMProductDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        int width=self.frame.size.width;
        int heght=self.frame.size.height;
        float buttonWid=(width/2.0)/3.0;
        [self addSubview:self.consultingBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.collectBtn];
        [self addSubview:self.subscribeStateBtn];
        
        self.consultingBtn.frame=CGRectMake(0, 0, buttonWid, heght);
        [self.consultingBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.consultingBtn.imageView.frame.size.height+5 ,-self.consultingBtn.imageView.frame.size.width-5, 0.0,0.0)];
        [self.consultingBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0,0, -self.consultingBtn.titleLabel.bounds.size.width+5)];
        self.shareBtn.frame=CGRectMake(buttonWid, 0,buttonWid, heght);
        [self.shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.shareBtn.imageView.frame.size.height+5 ,-self.shareBtn.imageView.frame.size.width-5, 0.0,0.0)];
        [self.shareBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0,0,  -self.shareBtn.titleLabel.bounds.size.width+5)];
        self.collectBtn.frame=CGRectMake(buttonWid*2, 0, buttonWid, heght);
        [self.collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(self.collectBtn.imageView.frame.size.height+5 ,-self.collectBtn.imageView.frame.size.width-5, 0.0,0.0)];
        [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-20,0,0, -self.collectBtn .titleLabel.bounds.size.width+5)];
         self.subscribeStateBtn.frame=CGRectMake(width/2.0, 0, width/2.0, heght);
        
        
    }
    
    return self;
}


#pragma mark Lzay

-(UIButton*)consultingBtn{
    if (!_consultingBtn) {
        _consultingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _consultingBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_consultingBtn setTitle:@"咨询" forState:UIControlStateNormal];
        [_consultingBtn setImage:[UIImage imageNamed:@"zixun"] forState:UIControlStateNormal];
        _consultingBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_consultingBtn setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
        _consultingBtn.tag=10;
        [_consultingBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consultingBtn;
}
-(UIButton*)shareBtn{
    if (!_shareBtn) {
        
        _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"fenXiang"] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_shareBtn setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
         _shareBtn.tag=11;
        [_shareBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

-(UIButton*)collectBtn{
    if (!_collectBtn) {
        
        _collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];

        _collectBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_collectBtn setTitleColor:[UIColor clmHex:0x333333] forState:UIControlStateNormal];
        _collectBtn.tag=12;
        [_collectBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

-(UIButton*)subscribeStateBtn{
    if (!_subscribeStateBtn) {
        
        _subscribeStateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _subscribeStateBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
       // [_subscribeStateBtn setTitle:@"申购结束" forState:UIControlStateNormal];
       [_subscribeStateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_subscribeStateBtn setBackgroundColor:[UIColor cmThemeOrange]];
        _subscribeStateBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
       _subscribeStateBtn.tag=13;
       
    }
    return _subscribeStateBtn;
}

-(void)productDetailbtnClickEvent:(UIButton*)sender{
    
    switch (sender.tag) {
        case 10:
            if ([self.delegate respondsToSelector:@selector(CMProductDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMProductDetailBottomViewBtnEventWith:consultingBtnClick];
            }
            break;
        case 11:
            if ([self.delegate respondsToSelector:@selector(CMProductDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMProductDetailBottomViewBtnEventWith:shareBtnClick];
            }
            break;
        case 12:
        {
         if ([self.delegate respondsToSelector:@selector(CMProductDetailBottomViewBtnEventWith:)]) {
               [self.delegate CMProductDetailBottomViewBtnEventWith:collectBtnClick];
           }
            if (CMIsLogin()) {
                
           
            if (self.collectBtn.selected==YES) { //已收藏
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];

              [self.collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
               [self cancleCollectOrCollectWithType:2];

            }else{ //未收藏
                [self.collectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateNormal];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                  [alert show];
              [self cancleCollectOrCollectWithType:1];
                
            }
                 self.collectBtn.selected=!self.collectBtn.selected;
            }else{
                self.collectBtn.selected=NO;
            }
           
        }
   
            break;
        case 13:
            if ([self.delegate respondsToSelector:@selector(CMProductDetailBottomViewBtnEventWith:)]) {
                [self.delegate CMProductDetailBottomViewBtnEventWith:subStateBtnClick];
            }
            break;
            
        default:
            break;
    }
    
    
}
//||[ProductDetails.status isEqualToString:@"预约中"]||[ProductDetails.status isEqualToString:@"预定中"]
-(void)setProductDetails:(CMProductDetails *)ProductDetails{
    _ProductDetails =ProductDetails;
    [self.subscribeStateBtn setTitle:ProductDetails.status forState:UIControlStateNormal];
 [self.subscribeStateBtn setBackgroundColor:ProductDetails.statusColor];
        if ([ProductDetails.status isEqualToString:@"立即申购"]) {
           
            [self.subscribeStateBtn addTarget:self action:@selector(productDetailbtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    
//        else if([ProductDetails.status isEqualToString:@"路演中"])
//        {        [self.subscribeStateBtn setBackgroundColor:[UIColor clmHex:0xff6400]];
//        }else {
//        [self.subscribeStateBtn setBackgroundColor:[UIColor clmHex:0xcccccc]];
//    }
    
    [self cheackIsCollectWithProductID:ProductDetails.productId];
    

}


#pragma mark 判断是否收藏
-(void)cheackIsCollectWithProductID:(NSInteger)prodctID{
    if (CMIsLogin()) {
        [CMRequestAPI cm_applyFetchProductDetailsCollectWithType:0 andProductID:prodctID success:^(id isSuccess) {
            
        
            if ([[isSuccess objectForKey:@"errmsg"]isEqualToString:@"已收藏"]) {
                
                        [self.collectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateNormal];
                        self.collectBtn.selected=YES;
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
