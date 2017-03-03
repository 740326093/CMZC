//
//  CMBLBProductCell.m
//  CMZC
//
//  Created by WangWei on 17/3/2.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMBLBProductCell.h"
@interface CMBLBProductCell()


@property(nonatomic,strong)UILabel *prTitleLabel;
@property(nonatomic,strong)UILabel *prDecLabel;
@property(nonatomic,strong)UILabel *prBuyNumLabel;
@property(nonatomic,strong)UILabel *prJingLabel;
@property(nonatomic,strong)UILabel *prRealJingLabel;
@property(nonatomic,strong)UILabel *prZengFuLabel;
@property(nonatomic,strong)UILabel *prCurZengLabel;
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
        [self addSubview:self.prRealJingLabel];
        [self addSubview:self.prZengFuLabel];
        [self addSubview:self.prCurZengLabel];
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
        make.height.equalTo(@15);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(@70);
    }];
    
    [self.prDecLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.left.equalTo(self.prTitleLabel.mas_right);
        make.bottom.equalTo(self.prTitleLabel);
        make.width.mas_equalTo(@150);
    }];
    
    
    [self.prBuyNumLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(@100);
    }];
    
    [self.BuyInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        
    }];
    
    [self.prMonthLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.BuyInButton);
        make.bottom.equalTo(self.BuyInButton.mas_top).offset(-10);
        make.width.mas_equalTo(@150);
    }];
    [self.prBeginSaleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.bottom.equalTo(self.prMonthLabel);
        make.right.equalTo(self.BuyInButton.mas_right);
       
       
    }];
    
    CGRect rect=[ self.prTotalLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    
    [self.prTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.right.equalTo(self.prBeginSaleLabel);
        make.bottom.equalTo(self.prBeginSaleLabel.mas_top).offset(-15);
        make.width.mas_equalTo(rect.size.width);
    }];
    [self.prShouYiLittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(self.prTotalLabel);
        make.bottom.equalTo(self.prTotalLabel.mas_top).offset(-2);
        
    }];
    
    [self.prShouYiZhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.prTotalLabel.mas_top);
        make.right.equalTo(self.prTotalLabel.mas_left);
        make.width.equalTo(@38);
        make.height.equalTo(@33);
    }];
    
    [self.prRealJingLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@33);
        make.width.equalTo(@100);
        make.left.equalTo(self.prMonthLabel);
        make.bottom.equalTo(self.prShouYiZhengLabel);
    }];
    
    [self.prJingLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@13);
        make.width.equalTo(@150);
        make.left.equalTo(self.prMonthLabel);
        make.bottom.equalTo(self.prRealJingLabel.mas_top);
    }];
      CGRect rectOne=[ self.prCurZengLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [self.prCurZengLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@13);
        make.width.mas_equalTo(rectOne.size.width);
        make.left.equalTo(self.prRealJingLabel.mas_right);
        make.top.equalTo(self.prRealJingLabel.mas_centerY);
    }];
    
    [self.prZengFuLabel  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.left.width.equalTo(self.prCurZengLabel);
        make.bottom.equalTo(self.prCurZengLabel.mas_top);
        
    }];
   
    
}

-(void)setNumberous:(CMNumberous *)Numberous{

//    @property (nonatomic,copy) NSString *descri;
//    @property (nonatomic,copy) NSString *floatingprofitloss;
//    @property (nonatomic,copy) NSString *berId;
//    @property (nonatomic,copy) NSString *income;
//    @property (nonatomic,copy) NSString *incometype;
//    @property (nonatomic,copy) NSString *picture;
//    @property (nonatomic,copy) NSString *price;
//    @property (nonatomic,copy) NSString *redemptionperiod;
//    @property (nonatomic,copy) NSString *title;
//    @property (nonatomic,copy) NSString *attendPersionCount; //参与人数
    self.prTitleLabel.text=Numberous.title;
    self.prDecLabel.text=Numberous.descri;
    self.prBuyNumLabel.text=[NSString stringWithFormat:@"已有%@购买",Numberous.attendPersionCount];
    
    self.prMonthLabel.text=[NSString stringWithFormat:@"%@个月可赎回",Numberous.redemptionperiod];
    self.prBeginSaleLabel.text=[NSString stringWithFormat:@"%.2f起",[Numberous.price floatValue]];
    float shouyi=[Numberous.floatingprofitloss  floatValue];
    NSString *shouYiString=[NSString stringWithFormat:@"%.2f",shouyi];
    NSRange rang=[shouYiString rangeOfString:@"."];
    
   self.prShouYiLittleLabel.text = [[shouYiString substringWithRange:NSMakeRange(rang.location, 3)] stringByAppendingString:@"%"];

    self.prShouYiZhengLabel.text=[NSString stringWithFormat:@"%d",[Numberous.floatingprofitloss intValue]];
    
    self.prRealJingLabel.text=[NSString stringWithFormat:@"%.2f",[Numberous.price floatValue]];
    
     CGRect rectOne=[ self.prRealJingLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 33) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil];
     [self.prRealJingLabel  mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(rectOne.size.width+2);
     }];
    self.prZengFuLabel.text=[NSString stringWithFormat:@"%.2f%%",[Numberous.floatingprofitloss floatValue]];
    CGFloat fallFloat = [Numberous.income floatValue];
    if (fallFloat == 0) {
        self.prZengFuLabel.textColor = [UIColor cmFontWiteColor];
    } else if (fallFloat >0 ){//涨
        self.prZengFuLabel.textColor = [UIColor cmUpColor];
        self.prZengFuLabel.text = [NSString stringWithFormat:@"+%.2f%%",[Numberous.income floatValue]];
    } else {
        self.prZengFuLabel.textColor = [UIColor cmFallColor];
    }
}



#pragma mark Lazy


-(UILabel*)prTitleLabel{
    if (!_prTitleLabel) {
        _prTitleLabel=[[UILabel alloc]init];
        _prTitleLabel.textColor=[UIColor clmHex:0x333333];
        _prTitleLabel.font=[UIFont systemFontOfSize:14.0];
        
    }
    return _prTitleLabel;
}
-(UILabel*)prDecLabel{
    if (!_prDecLabel) {
        _prDecLabel=[[UILabel alloc]init];
        _prDecLabel.textColor=[UIColor clmHex:0xbbbbbb];
        _prDecLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _prDecLabel;
}
-(UILabel*)prBuyNumLabel{
    if (!_prBuyNumLabel) {
        _prBuyNumLabel=[[UILabel alloc]init];
        _prBuyNumLabel.textColor=[UIColor clmHex:0xbbbbbb];
        _prBuyNumLabel.font=[UIFont systemFontOfSize:12.0];
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
-(UILabel*)prRealJingLabel{
    if (!_prRealJingLabel) {
        _prRealJingLabel=[[UILabel alloc]init];
        _prRealJingLabel.textColor=[UIColor cmThemeCheng];
        _prRealJingLabel.font=[UIFont systemFontOfSize:30.0];
        
    }
    return _prRealJingLabel;
}

-(UILabel*)prZengFuLabel{
    if (!_prZengFuLabel) {
        _prZengFuLabel=[[UILabel alloc]init];
        _prZengFuLabel.textColor=[UIColor redColor];
        _prZengFuLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _prZengFuLabel;
}
-(UILabel*)prCurZengLabel{
    if (!_prCurZengLabel) {
        _prCurZengLabel=[[UILabel alloc]init];
        _prCurZengLabel.textColor=[UIColor cmThemeCheng];
        _prCurZengLabel.font=[UIFont systemFontOfSize:12.0];
        _prCurZengLabel.text=@"当前增幅";
    }
    return _prCurZengLabel;
}

-(UILabel*)prShouYiZhengLabel{
    if (!_prShouYiZhengLabel) {
        _prShouYiZhengLabel=[[UILabel alloc]init];
        _prShouYiZhengLabel.textColor=[UIColor cmThemeCheng];
        _prShouYiZhengLabel.font=[UIFont systemFontOfSize:30.0];
        
    }
    return _prShouYiZhengLabel;
}

-(UILabel*)prShouYiLittleLabel{
    if (!_prShouYiLittleLabel) {
        _prShouYiLittleLabel=[[UILabel alloc]init];
        _prShouYiLittleLabel.textColor=[UIColor cmThemeCheng];
        _prShouYiLittleLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _prShouYiLittleLabel;
}


-(UILabel*)prTotalLabel{
    if (!_prTotalLabel) {
        _prTotalLabel=[[UILabel alloc]init];
        _prTotalLabel.textColor=[UIColor cmThemeCheng];
        _prTotalLabel.font=[UIFont systemFontOfSize:12.0];
        _prTotalLabel.text=@"累计收益";
        _prTotalLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _prTotalLabel;
}
-(UILabel*)prMonthLabel{
    if (!_prMonthLabel) {
        _prMonthLabel=[[UILabel alloc]init];
        _prMonthLabel.textColor=[UIColor cmThemeCheng];
        _prMonthLabel.font=[UIFont systemFontOfSize:12.0];
        
    }
    return _prMonthLabel;
}
-(UILabel*)prBeginSaleLabel{
    if (!_prBeginSaleLabel) {
        _prBeginSaleLabel=[[UILabel alloc]init];
        _prBeginSaleLabel.textColor=[UIColor cmThemeCheng];
        _prBeginSaleLabel.font=[UIFont systemFontOfSize:12.0];
        _prBeginSaleLabel.textAlignment=NSTextAlignmentRight;
    }
    return _prBeginSaleLabel;
}

-(UIButton*)BuyInButton{
    if (!_BuyInButton) {
        _BuyInButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_BuyInButton setTitle:@"买入" forState:UIControlStateNormal];
        [_BuyInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_BuyInButton setBackgroundColor:[UIColor cmThemeCheng]];
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
@end
