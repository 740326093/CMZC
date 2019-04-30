//
//  CMMessageTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/6/29.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMMessageTableViewCell.h"

@interface CMMessageTableViewCell ()
//@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *headIcon;
@property(nonatomic,strong)UIImageView *newsBackGround;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UIButton *detailBtn;
@property(nonatomic,strong)UIView *linView;
@property(nonatomic,strong)UIImageView *listImage;
@property(nonatomic,strong)UILabel *redRead;
@end
@implementation CMMessageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor cmBackgroundGrey];
        [self addSubview:self.timeLab];
        [self addSubview:self.newsBackGround];
        [self.newsBackGround addSubview:self.messageLabel];
        [self.newsBackGround addSubview:self.linView];
        [self.newsBackGround addSubview:self.detailBtn];
        [self.newsBackGround addSubview:self.listImage];
        [self addSubview:self.headIcon];
        [self addSubview:self.redRead];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.equalTo(@20);
    }];
    [self.newsBackGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(self.newsBackGround.image.size.height));
        make.width.mas_equalTo(f_i5real(self.newsBackGround.image.size.width));
        make.centerX.equalTo(self.mas_centerX).offset(15);
        make.top.equalTo(self.timeLab.mas_bottom).offset(10);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsBackGround.mas_left).offset(10);
        make.right.equalTo(self.newsBackGround.mas_right).offset(-10);
        make.top.equalTo(self.newsBackGround.mas_top).offset(10);
    }];
    
    [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.right.equalTo(self.newsBackGround.mas_right).offset(-15);
        make.left.equalTo(self.newsBackGround.mas_left).offset(15);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.linView);
        make.top.equalTo(self.linView.mas_bottom);
    }];
    [self.listImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.detailBtn);
        make.right.equalTo(self.linView);
    }];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(self.headIcon.image.size.height));
        make.width.mas_equalTo(f_i5real(self.headIcon.image.size.width));
        make.right.equalTo(self.newsBackGround.mas_left).offset(-5);
        make.bottom.equalTo(self.detailBtn.mas_bottom);
    }];
    [self.redRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@8);
        make.top.equalTo(self.headIcon.mas_top);
        make.left.equalTo(self.headIcon.mas_right).offset(-3);
    }];
}


#pragma mark setter/getter
-(UILabel*)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12.0];
        _timeLab.textColor=[UIColor whiteColor];
        _timeLab.backgroundColor=[UIColor clmHex:0xcecece];
        _timeLab.textAlignment=NSTextAlignmentCenter;
        _timeLab.layer.masksToBounds=YES;
        _timeLab.layer.cornerRadius=4.0;
    }
    return _timeLab;
}

-(UIImageView*)newsBackGround{
    
    if (!_newsBackGround) {//messageBg
        UIImage *Bgimage=[UIImage imageNamed:@"messageBg"];
        _newsBackGround=[[UIImageView alloc]init];
        _newsBackGround.image=[Bgimage stretchableImageWithLeftCapWidth:(Bgimage.size.width/2.0)topCapHeight:(Bgimage.size.height/2.0)];
        _newsBackGround.userInteractionEnabled=YES;
    }
    return _newsBackGround;
}

-(UILabel*)messageLabel{
    if (!_messageLabel) {
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.numberOfLines=0;
        _messageLabel.font=[UIFont systemFontOfSize:14.0];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _messageLabel;
}
-(UIButton*)detailBtn{
    if (!_detailBtn) {
        //详情按钮
        _detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor cmNineColor] forState:UIControlStateNormal];
        _detailBtn.userInteractionEnabled=NO;
        _detailBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    }
    return _detailBtn;
    
}
-(UIImageView*)listImage{
    if (!_listImage) {
        _listImage=[[UIImageView alloc]init];
        _listImage.image=[UIImage imageNamed:@"right_home"];
    }
    return _listImage;
}

-(UIImageView*)headIcon{
    if (!_headIcon) {
        //左边头像
        _headIcon=[[UIImageView alloc]init];
        _headIcon.image=[UIImage imageNamed:@"msgHead"];
    }
    return _headIcon;
}


-(UILabel*)redRead{
    if (!_redRead) {
        _redRead=[[UILabel alloc]init];
        _redRead.backgroundColor=[UIColor clmHex:0xfb3c19];
        _redRead.layer.cornerRadius=4;
        _redRead.layer.masksToBounds=YES;
        _redRead.hidden=YES;
    }
    return _redRead;
}
-(UIView*)linView{
    if (!_linView) {
        _linView=[UIView new];
        _linView.backgroundColor=[UIColor cmBackgroundGrey];
    }
    return _linView;
}

-(void)setMessageModel:(CMMessage *)messageModel{
    
    _timeLab.text=messageModel.time;
    CGRect rect=[_timeLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12.0]} context:nil];
    [self.timeLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+10);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    _messageLabel.text=messageModel.message;
    CGRect Messagerect=[_messageLabel.text boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.0]} context:nil];
    
    [self.newsBackGround mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Messagerect.size.height+50);
    }];
    if (messageModel.isread==1) {
        self.redRead.hidden=NO;
    }else{
        self.redRead.hidden=YES;
    }
    
    [self  layoutIfNeeded];
    
}
//类方法，返回的值用来计算cell的高度
+ (CGFloat)heightWithModel:(CMMessage*)model{
    CMMessageTableViewCell *cell = [[CMMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell setMessageModel:model];
    [cell layoutIfNeeded];
    //CGRect frame=cell.teSubTitle.frame;
    
    return 100;
    
    //return frame.origin.y + frame.size.height + 50;
}
//- (void)setTitleNameStr:(NSString *)titleNameStr {
//    _titleLab.text = titleNameStr;
//}


@end
