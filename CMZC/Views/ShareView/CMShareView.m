//
//  CMShareView.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/10.
//  Copyright © 2017年 郑浩然. All rights reserved.
//
#define kCMShareTitle @"新经板-只赚不赔的“原始股"


#import "CMShareView.h"
#import "CMSortwareShareViewController.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
@interface CMShareView ()

@property (strong, nonatomic) UIView *bgView;//分享主view

@property (strong, nonatomic) UIView *shareView;//分享主view

@property (strong, nonatomic) UIButton *cancelBtn;//取消

@end

@implementation CMShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self addView];
    }
    return self;
}
-(void)addView{
    
    [self addSubview:self.bgView];
    [self addSubview:self.shareView];

    NSArray *imageArr=@[@"CM_qq",@"CM_qzone",@"CM_wechat",@"CM_wechat_timeline",@"CM_sina"];
    NSArray *titleArr=@[@"QQ",@"QQ空间",@"微信",@"朋友圈",@"新浪微博"];
    
    float interval = (CMScreen_width()-5*f_i5real(50))/6.0;
    for (int i=0;i<titleArr.count; i++) {
        UIImage *image=[UIImage imageNamed:imageArr[i]];
        UIButton *platomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        platomBtn.frame=CGRectMake(interval+(i%5)*( f_i5real(50)+ interval),20,  f_i5real(50),  f_i5real(40));
        [platomBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        platomBtn.titleLabel.font= [UIFont systemFontOfSize:12.0];
        platomBtn.titleLabel.textAlignment= NSTextAlignmentCenter;
        [platomBtn setTitleColor:[UIColor clmHex:0x777777]
                        forState:UIControlStateNormal];

      [platomBtn setTitleEdgeInsets:UIEdgeInsetsMake(f_i5real(32),-30,0,0)];
        
        // 按钮图片和标题总高度
        CGFloat totalHeight = (platomBtn.imageView.frame.size.height + platomBtn.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [platomBtn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - platomBtn.imageView.frame.size.height), 0.0, 0.0, -platomBtn.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
       // [platomBtn setTitleEdgeInsets:UIEdgeInsetsMake(f_i5real(30), -platomBtn.imageView.frame.size.width, 0,0.0)];

        
        platomBtn.tag=11+i;
        [platomBtn addTarget:self action:@selector(sharePlatformsClick:) forControlEvents:UIControlEventTouchUpInside];
        [platomBtn setImage:image forState:UIControlStateNormal];
        [self.shareView addSubview:platomBtn];
        
    }
    
    //取消
    [self.shareView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.shareView);
        make.bottom.equalTo(self.shareView.mas_bottom).offset(-15);
        make.height.equalTo(@40);
        
    }];
  
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        _bgView.userInteractionEnabled=YES;
        _bgView.backgroundColor=[UIColor blackColor];
        _bgView.alpha=0.52f;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
    
    
}
//分享的主view
- (UIView *)shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] init];
        _shareView.backgroundColor =[UIColor whiteColor];
         _shareView.frame = CGRectMake(0, CMScreen_height() -150, CMScreen_width(),150);
    }
    return _shareView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitleColor:[UIColor clmHex:0x000000] forState:UIControlStateNormal];

        _cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


-(void)sharePlatformsClick:(UIButton*)sender{
    
    switch (sender.tag) {
        case 11:
            [self qqShareBtnClick];
            break;
        case 12:
            [self qzoneBtnClick];
            break;
        case 13:
            [self wechatBtnClick];
            break;
        case 14:
            [self wechatTimeBtnClick];
            break;
        case 15:
            [self sinaBtnClick];
            break;
            
        default:
            break;
    }
}
//qq
- (void)qqShareBtnClick {
    [UMSocialData defaultData].extConfig.qqData.title = _titleConten;
    [UMSocialData defaultData].extConfig.qqData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQQ] Withimage:self.ShareImageName];
    [self removeFromSuperview];
}
//qq空间
- (void)qzoneBtnClick{
    [UMSocialData defaultData].extConfig.qzoneData.title = _titleConten;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQzone] Withimage:self.ShareImageName];
    [self removeFromSuperview];
}
//微信
- (void)wechatBtnClick {
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _titleConten;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatSession] Withimage:self.ShareImageName];
    [self removeFromSuperview];
}
//朋友圈
- (void)wechatTimeBtnClick {
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _titleConten;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatTimeline] Withimage:self.ShareImageName];
    [self removeFromSuperview];
}
//微博
- (void)sinaBtnClick {
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToSina] Withimage:self.ShareImageName];
    [self removeFromSuperview];
}
//取消
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}
//分享内容
- (void)umsocialDataServicPostSNSWithTypes:(NSArray *)typeArr Withimage:(id)imageName {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:typeArr
                                                        content:self.contentStr
                                                          image:imageName
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:nil
                                                     completion:^(UMSocialResponseEntity *response){
                                                         //                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                         //                                                    NSLog(@"分享成功！");
                                                         //                                                }
                                                     }];
}

- (void)remove {
    [self removeFromSuperview];
}




@end




























