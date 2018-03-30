//
//  CMChagePhoto.m
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChagePhoto.h"

@implementation CMChagePhoto

-(id)initCMChangePhotoAlert{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIImageView *contentView=[[UIImageView alloc]init];
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX);
            make.centerY.equalTo(bgView.mas_centerY);
            make.width.mas_equalTo(500/2.0);
            make.height.mas_equalTo(200/2.0);
            
        }];
 
        UIButton *camera=[UIButton buttonWithType:UIButtonTypeCustom];
        camera.titleLabel.font=[UIFont systemFontOfSize:14];
        camera.tag=0;
        [camera setTitle:@"拍照" forState:UIControlStateNormal];
        [camera setTitleColor:[UIColor colorWithHexString:@"#333333" withAlpha:1] forState:UIControlStateNormal];
        [camera addTarget:self action:@selector(changeSource:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:camera];
        [camera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.left.equalTo(contentView);
            make.height.equalTo(@34.5);
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=[UIColor colorWithHexString:@"#e4e4e4" withAlpha:1];
        [contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.width.equalTo(contentView);
            make.height.equalTo(@0.5);
            make.top.equalTo(camera.mas_bottom);
        }];
        UIButton *photo=[UIButton buttonWithType:UIButtonTypeCustom];
        photo.titleLabel.font=[UIFont systemFontOfSize:14];
        photo.tag=1;
        [photo setTitleColor:[UIColor colorWithHexString:@"#333333" withAlpha:1] forState:UIControlStateNormal];
        [photo setTitle:@"从相册选择" forState:UIControlStateNormal];
        [photo addTarget:self action:@selector(changeSource:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:photo];
        [photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(contentView);
            make.top.equalTo(line.mas_bottom);
            make.height.equalTo(@34.5);
        }];
        UILabel *line1=[[UILabel alloc]init];
        line1.backgroundColor=[UIColor colorWithHexString:@"#e4e4e4" withAlpha:1];
        [contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.width.equalTo(contentView);
            make.height.equalTo(@0.5);
            make.top.equalTo(photo.mas_bottom);
        }];

        UIButton *cancle=[UIButton buttonWithType:UIButtonTypeCustom];
        cancle.titleLabel.font=[UIFont systemFontOfSize:14];
     
        [cancle setTitleColor:[UIColor cmThemeCheng] forState:UIControlStateNormal];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancle];
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.bottom.left.equalTo(contentView);
            make.height.equalTo(@30);
        }];
        
        [self ShowAlert];
    }
    return self;
    
}
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dismissView{
    
    [self removeFromSuperview];
    
}
-(void)changeSource:(UIButton*)btn{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(ChangeSourceWithIndex:)]) {
        [_delegate ChangeSourceWithIndex:btn.tag];
    }
    
}

@end
