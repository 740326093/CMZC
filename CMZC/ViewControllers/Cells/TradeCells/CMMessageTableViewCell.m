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
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.newsBackGround];
        [self.newsBackGround addSubview:self.messageLabel];
        [self.newsBackGround addSubview:self.linView];
        [self.newsBackGround addSubview:self.detailBtn];
        [self.newsBackGround addSubview:self.listImage];
        [self.contentView addSubview:self.headIcon];
        [self.contentView addSubview:self.redRead];
        
        
        self.timeLab.sd_layout
        .topSpaceToView(self.contentView,10)
        .heightIs(14)
        .centerXEqualToView(self.contentView)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView);
        
        self.newsBackGround.sd_layout
        .topSpaceToView(self.timeLab,10)
        .widthIs(f_i5real(self.newsBackGround.image.size.width))
        .centerXEqualToView(self.contentView).offset(20)
        .autoHeightRatio(0);
        
        self.messageLabel.sd_layout
        .topSpaceToView(self.newsBackGround,8)
        .leftSpaceToView(self.newsBackGround,20)
        .rightSpaceToView(self.newsBackGround,20)
        .autoHeightRatio(0);
        
        self.linView.sd_layout
        .topSpaceToView(self.messageLabel,10)
        .leftSpaceToView(self.newsBackGround,15)
        .rightSpaceToView(self.newsBackGround, 15)
        .heightIs(0.5);
        
        
        self.detailBtn.sd_layout
        .topSpaceToView(self.linView, 5)
        .leftSpaceToView(self.newsBackGround, 20)
        .widthIs(80)
        .heightIs(18);
        
        self.listImage.sd_layout
        .centerYEqualToView(self.detailBtn)
        .rightSpaceToView(self.newsBackGround,15)
        .widthIs(7)
        .heightIs(11);
        
        
        self.headIcon.sd_layout
        .bottomEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(f_i5real(self.headIcon.image.size.width))
        .heightIs(f_i5real(self.headIcon.image.size.height));
        
        self.redRead.sd_layout
        .topEqualToView(self.headIcon)
        .leftSpaceToView(self.headIcon, -5)
        .widthIs(8)
        .heightIs(8);
        
    }
    return self;
}


#pragma mark setter/getter
-(UILabel*)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12.0];
        _timeLab.textColor=[UIColor clmHex:0x666666];
        _timeLab.textAlignment=NSTextAlignmentCenter;
    
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
        _messageLabel.textColor=[UIColor colorWithHex:0x333333];
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

    
    _messageLabel.text=messageModel.message;

    if (messageModel.isread==1) {
        self.redRead.hidden=NO;
    }else{
        self.redRead.hidden=YES;
    }
    
  
    NSDictionary *dict=[NSString dictionaryWithJsonString:messageModel.page];
    if ([dict objectForKey:@"ext"]==nil&&[dict objectForKey:@"product"]==nil&&[dict objectForKey:@"page"]==nil) {
        self.detailBtn.hidden=YES;
        self.listImage.hidden=YES;
        self.linView.hidden=YES;
        [self.newsBackGround setupAutoHeightWithBottomViewsArray:@[self.messageLabel] bottomMargin:10];
        
    }else{
        
        self.detailBtn.hidden=NO;
        self.listImage.hidden=NO;
        self.linView.hidden=NO;
        [self.newsBackGround setupAutoHeightWithBottomViewsArray:@[self.detailBtn] bottomMargin:10];
    }
    
    
    [self setupAutoHeightWithBottomViewsArray:@[self.newsBackGround,self.timeLab] bottomMargin:10];
}


@end
