//
//  CMBLBProductCell.m
//  CMZC
//
//  Created by WangWei on 17/3/2.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMBLBProductCell.h"
#define BackColor [UIColor clmHex:0xff6400]
@interface CMBLBProductCell()


@property(nonatomic,strong)UILabel *prTitleLabel;
@property(nonatomic,strong)UILabel *prDecLabel;
@property(nonatomic,strong)UILabel *prBuyNumLabel;
@property(nonatomic,strong)UILabel *prJingLabel;
//@property(nonatomic,strong)UILabel *prRealJingLabel;
//@property(nonatomic,strong)UILabel *prZengFuLabel;
//@property(nonatomic,strong)UILabel *prCurZengLabel;
@property(nonatomic,strong)UILabel *prShouYiZhengLabel;
@property(nonatomic,strong)UILabel *prShouYiLittleLabel;
@property(nonatomic,strong)UILabel *prTotalLabel;
@property(nonatomic,strong)UILabel *prMonthLabel;
@property(nonatomic,strong)UILabel *prBeginSaleLabel;
@property(nonatomic,strong)UIButton *BuyInButton;


@end
@implementation CMBLBProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.prTitleLabel];
        [self addSubview:self.prDecLabel];
        [self addSubview:self.prBuyNumLabel];
        [self addSubview:self.prJingLabel];
//        [self addSubview:self.prRealJingLabel];
//        [self addSubview:self.prZengFuLabel];
//        [self addSubview:self.prCurZengLabel];
        [self addSubview:self.prShouYiZhengLabel];
        [self addSubview:self.prShouYiLittleLabel];
        [self addSubview:self.prTotalLabel];
        [self addSubview:self.prMonthLabel];
        [self addSubview:self.prBeginSaleLabel];
        [self addSubview:self.BuyInButton];
        
        [self layOutCellSubviews];
    }
    return self;
}
-(void)layOutCellSubviews{
    
    [self.prTitleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(@80);
    }];
    
    [self.prDecLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.left.equalTo(self.prTitleLabel.mas_right);
        make.centerY.equalTo(self.prTitleLabel.mas_centerY);
        make.width.mas_equalTo(@150);
    }];
    
    
   
    [self.BuyInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        
    }];
    
    [self.prMonthLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        
        make.bottom.equalTo(self.BuyInButton.mas_top).offset(-15);
        make.width.mas_equalTo(@150);
        make.centerX.equalTo(self.BuyInButton);
    }];
    [self.prBeginSaleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.height.width.bottom.equalTo(self.prMonthLabel);
       make.left.equalTo(self.BuyInButton);
    }];
    
    [self.prBuyNumLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.bottom.equalTo(self.prMonthLabel);
        make.right.equalTo(self.BuyInButton.mas_right);
    }];
    
    
    
    [self.prShouYiZhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.prBeginSaleLabel.mas_top).offset(-15);
        make.right.equalTo(self.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@55);
    }];
    
 
    [self.prTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.prShouYiZhengLabel.mas_right);
        make.top.equalTo(self.prShouYiZhengLabel.mas_centerY).offset(2);
        make.width.mas_equalTo(150);
    }];
    
    
    [self.prShouYiLittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@19);
        make.left.equalTo(self.prTotalLabel);
        make.bottom.equalTo(self.prShouYiZhengLabel.mas_centerY).offset(-2);
        make.width.equalTo(self.prTotalLabel);
        
    }];
    
   
    
//    [self.prRealJingLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.equalTo(@33);
//        make.width.equalTo(@100);
//        make.left.equalTo(self.prMonthLabel);
//        make.bottom.equalTo(self.prShouYiZhengLabel);
//    }];
    
//    [self.prJingLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.equalTo(@13);
//        make.width.equalTo(@150);
//        make.left.equalTo(self.prMonthLabel);
//        make.bottom.equalTo(self.prRealJingLabel.mas_top);
//    }];
//      CGRect rectOne=[ self.prCurZengLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
//    [self.prCurZengLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.equalTo(@13);
//        make.width.mas_equalTo(rectOne.size.width);
//        make.left.equalTo(self.prRealJingLabel.mas_right);
//        make.top.equalTo(self.prRealJingLabel.mas_centerY);
//    }];
//    
//    [self.prZengFuLabel  mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.left.width.equalTo(self.prCurZengLabel);
//        make.bottom.equalTo(self.prCurZengLabel.mas_top);
//        
//    }];
//   
    
}

-(void)setNumberous:(CMNumberous *)Numberous{


    self.prTitleLabel.text=Numberous.title;
    self.prDecLabel.text=Numberous.descri;
    self.prBuyNumLabel.text=[NSString stringWithFormat:@"%@人参与",Numberous.attendPersionCount];
    [self DoubleStringChangeColer:self.prBuyNumLabel andFromStr:@"参" ToStr:@"与" withColor:[UIColor clmHex:0x666666] withLength:2];
   
    self.prMonthLabel.text=[NSString stringWithFormat:@"%@个月可赎回",Numberous.redemptionperiod];
    [self DoubleStringChangeColer:self.prMonthLabel andFromStr:@"可" ToStr:@"回" withColor:[UIColor clmHex:0x666666] withLength:3];
    self.prBeginSaleLabel.text=[NSString stringWithFormat:@"昨净值%.2f",[Numberous.price floatValue]];
    [self DoubleStringChangeColer:self.prBeginSaleLabel andFromStr:@"昨" ToStr:@"值" withColor:[UIColor clmHex:0x666666] withLength:3];
   // [self loneStringChangeColer:self.prBeginSaleLabel andFromStr:@"起" WithColor:[UIColor clmHex:0x666666]];
    float shouyi=[Numberous.floatingprofitloss  floatValue];
    NSString *shouYiString=[NSString stringWithFormat:@"%.2f",shouyi];
    NSRange rang=[shouYiString rangeOfString:@"."];
    
   self.prShouYiLittleLabel.text = [[shouYiString substringWithRange:NSMakeRange(rang.location, 3)] stringByAppendingString:@"%"];

    self.prShouYiZhengLabel.text=[NSString stringWithFormat:@"%d",[Numberous.floatingprofitloss intValue]];
    
    
    self.prTotalLabel.text=Numberous.incometype;
   
    CGRect rect=[ self.prTotalLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    
    
    [self.prTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.prShouYiZhengLabel.mas_right);
        make.top.equalTo(self.prShouYiZhengLabel.mas_centerY).offset(5);
        make.width.mas_equalTo(rect.size.width+10);
    }];
}



#pragma mark Lazy


-(UILabel*)prTitleLabel{
    if (!_prTitleLabel) {
        _prTitleLabel=[[UILabel alloc]init];
        _prTitleLabel.textColor=[UIColor clmHex:0x4d4d4d];
        _prTitleLabel.font=[UIFont systemFontOfSize:17.0];
        
    }
    return _prTitleLabel;
}
-(UILabel*)prDecLabel{
    if (!_prDecLabel) {
        _prDecLabel=[[UILabel alloc]init];
        _prDecLabel.textColor=[UIColor clmHex:0x666666];
        _prDecLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _prDecLabel;
}
-(UILabel*)prBuyNumLabel{
    if (!_prBuyNumLabel) {
        _prBuyNumLabel=[[UILabel alloc]init];
        _prBuyNumLabel.textColor=BackColor;
        _prBuyNumLabel.font=[UIFont systemFontOfSize:14.0];
        _prBuyNumLabel.textAlignment=NSTextAlignmentRight;
    }
    return _prBuyNumLabel;
}
-(UILabel*)prJingLabel{
    if (!_prJingLabel) {
        _prJingLabel=[[UILabel alloc]init];
        _prJingLabel.textColor=[UIColor clmHex:0xbbbbbb];
        _prJingLabel.font=[UIFont systemFontOfSize:12.0];
        _prJingLabel.text=@"当日净值(元)";
    }
    return _prJingLabel;
}
//-(UILabel*)prRealJingLabel{
//    if (!_prRealJingLabel) {
//        _prRealJingLabel=[[UILabel alloc]init];
//        _prRealJingLabel.textColor=[UIColor cmThemeCheng];
//        _prRealJingLabel.font=[UIFont systemFontOfSize:30.0];
//        
//    }
//    return _prRealJingLabel;
//}

//-(UILabel*)prZengFuLabel{
//    if (!_prZengFuLabel) {
//        _prZengFuLabel=[[UILabel alloc]init];
//        _prZengFuLabel.textColor=[UIColor redColor];
//        _prZengFuLabel.font=[UIFont systemFontOfSize:12.0];
//        
//    }
//    return _prZengFuLabel;
//}
//-(UILabel*)prCurZengLabel{
//    if (!_prCurZengLabel) {
//        _prCurZengLabel=[[UILabel alloc]init];
//        _prCurZengLabel.textColor=[UIColor cmThemeCheng];
//        _prCurZengLabel.font=[UIFont systemFontOfSize:12.0];
//        _prCurZengLabel.text=@"当前增幅";
//    }
//    return _prCurZengLabel;
//}

-(UILabel*)prShouYiZhengLabel{
    if (!_prShouYiZhengLabel) {
        _prShouYiZhengLabel=[[UILabel alloc]init];
        _prShouYiZhengLabel.textColor=BackColor;
        _prShouYiZhengLabel.font=[UIFont systemFontOfSize:50.0];
        
    }
    return _prShouYiZhengLabel;
}

-(UILabel*)prShouYiLittleLabel{
    if (!_prShouYiLittleLabel) {
        _prShouYiLittleLabel=[[UILabel alloc]init];
        _prShouYiLittleLabel.textColor=BackColor;
        _prShouYiLittleLabel.font=[UIFont systemFontOfSize:18.0];
        
    }
    return _prShouYiLittleLabel;
}


-(UILabel*)prTotalLabel{
    if (!_prTotalLabel) {
        _prTotalLabel=[[UILabel alloc]init];
        _prTotalLabel.textColor=[UIColor clmHex:0x999999];
        _prTotalLabel.font=[UIFont systemFontOfSize:14.0];
        _prTotalLabel.text=@"累计收益";
        
    }
    return _prTotalLabel;
}
-(UILabel*)prMonthLabel{
    if (!_prMonthLabel) {
        _prMonthLabel=[[UILabel alloc]init];
        _prMonthLabel.textColor=BackColor;
        _prMonthLabel.font=[UIFont systemFontOfSize:14.0];
        _prMonthLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _prMonthLabel;
}
-(UILabel*)prBeginSaleLabel{
    if (!_prBeginSaleLabel) {
        _prBeginSaleLabel=[[UILabel alloc]init];
        _prBeginSaleLabel.textColor=BackColor;
        _prBeginSaleLabel.font=[UIFont systemFontOfSize:14.0];
       
    }
    return _prBeginSaleLabel;
}

-(UIButton*)BuyInButton{
    if (!_BuyInButton) {
        _BuyInButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_BuyInButton setTitle:@"买入" forState:UIControlStateNormal];
        [_BuyInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_BuyInButton setBackgroundColor:BackColor];
        _BuyInButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_BuyInButton addTarget:self action:@selector(BuyInButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        _BuyInButton.layer.cornerRadius=4.0;
        _BuyInButton.clipsToBounds=YES;
    }
    
    return _BuyInButton;
}

-(void)BuyInButtonEvent:(UIButton*)sender{
    if (self.buyInBlock) {
    self.buyInBlock(self.Index);
        
    }
   
    
}

-(void)DoubleStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr ToStr:(NSString *)AToStr withColor:(UIColor*)color withLength:(NSUInteger)length{
    
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location, length)];
    mainStr.attributedText = Pay;
    
}


-(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr  WithColor:(UIColor*)color{
    //UIColorFromRGB(0xfa3e19)
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location,1)];
    mainStr.attributedText = Pay;
    
}
@end
