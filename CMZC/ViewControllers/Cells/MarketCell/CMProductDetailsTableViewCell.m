//
//  CMProductDetailsTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMProductDetailsTableViewCell.h"

@interface CMProductDetailsTableViewCell () {
    NSInteger _optionIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *dataLab; //当前价格
@property (weak, nonatomic) IBOutlet UILabel *earlyLab; //开盘lab
@property (weak, nonatomic) IBOutlet UILabel *heighlyLab; //最高
@property (weak, nonatomic) IBOutlet UILabel *droopLab; //最低
@property (weak, nonatomic) IBOutlet UILabel *turnoverLab; //成交量
@property (weak, nonatomic) IBOutlet UILabel *turnoverLimitLab; //成交额
@property (weak, nonatomic) IBOutlet UILabel *upOrFall; //是涨是跌
@property (weak, nonatomic) IBOutlet UILabel *scopeLab; //涨跌额度

@property (weak, nonatomic) IBOutlet UILabel *optionalLab; //自选but
@property (weak, nonatomic) IBOutlet UIButton *optionalBtn; //自选lab

@property (weak, nonatomic) IBOutlet UILabel *makeLab; //成交额
@property (weak, nonatomic) IBOutlet UILabel *hardenLab; //涨停
@property (weak, nonatomic) IBOutlet UILabel *limitDownLab; //跌停
@property (weak, nonatomic) IBOutlet UILabel *pastLab; //昨收
@property (weak, nonatomic) IBOutlet UILabel *tradeLab; //换手率
@property (weak, nonatomic) IBOutlet UILabel *municipLab; //市营率
@property (weak, nonatomic) IBOutlet UILabel *portionLab; //份额
@property (weak, nonatomic) IBOutlet UILabel *marketLab; //市值



@end


@implementation CMProductDetailsTableViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
 

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductArr:(NSArray *)productArr {
    //MyLog(@"%@",productArr);
    if (productArr.count==0) {
        return;
    }
    
    NSArray *dataProductArr = productArr.firstObject;
    
    _earlyLab.text = [NSString stringWithFormat:@"%.2f",[dataProductArr[2] floatValue]]; //开盘
    NSString *heighly = [NSString stringWithFormat:@"%.2f", [dataProductArr[4] floatValue]];
    
    if ([heighly isEqualToString:@"0.00"]) {
        _heighlyLab.text = @"--"; //开盘
    } else {
        _heighlyLab.text = heighly; //最高价
    }
    NSString *droopStr = [NSString stringWithFormat:@"%.2f", [dataProductArr[5] floatValue]];
    if ([droopStr isEqualToString:@"0.00"]) {
        _droopLab.text = @"--"; //最低
    } else {
        _droopLab.text = droopStr;
    }
    
    CGFloat earlyFloat = [dataProductArr[2] floatValue];//开盘价
    CGFloat droopFloat = [dataProductArr[5] floatValue];//最低价
    CGFloat heiglyFloat = [dataProductArr[4] floatValue];//最高价
    
    _turnoverLab.text = [NSString stringWithFormat:@"%.f", [dataProductArr[7] floatValue]];//成交量
    
    CGFloat turnoverFloat = [dataProductArr[8] floatValue];
    
    _makeLab.text = [self roundFloatDisplay:turnoverFloat]; //成交额
    CGFloat upFloat = [dataProductArr[3] floatValue];
    if (upFloat>earlyFloat) { //大于开盘价
        _dataLab.textColor = [UIColor cmUpColor];
    } else if (upFloat<earlyFloat) { //小于开盘价
        _dataLab.textColor = [UIColor cmFallColor];
    } else { //等于开盘价
        _dataLab.textColor = [UIColor cmDividerColor];
    }
    
    
    _dataLab.text = [NSString stringWithFormat:@"%.2f", [dataProductArr[3] floatValue]]; //当前价格
    
    
    CGFloat upOrFall = [dataProductArr[6] floatValue];
    if (upOrFall == 0) { //不涨不跌
        [self detailsLabTextColor:[UIColor cmFontWiteColor]];
        _scopeLab.text = [NSString stringWithFormat:@"%.2f%%",upOrFall];//涨跌幅
    } else if (upOrFall >0) { //涨
        [self detailsLabTextColor:[UIColor cmUpColor]];
        _scopeLab.text = CMStringWithPickFormat(@"+ ", [NSString stringWithFormat:@"%.2f%%",upOrFall]);//涨跌幅
    } else { //跌
       // _scopeLab.text = CMStringWithPickFormat(@"- ", [NSString stringWithFormat:@"%.2f%%",upOrFall]);
         _scopeLab.text = CMStringWithPickFormat(@"", [NSString stringWithFormat:@"%.2f%%",upOrFall]);
        [self detailsLabTextColor:[UIColor cmFallColor]];
    }
    
    
    _optionIndex = [dataProductArr[10] integerValue];
    if (_optionIndex == 0) {
        [_optionalBtn setBackgroundImage:[UIImage imageNamed:@"add_option_home"] forState:UIControlStateNormal];
        _optionalLab.text = @"添加自选";
    } else {
        [_optionalBtn setBackgroundImage:[UIImage imageNamed:@"delete_option_trade"] forState:UIControlStateNormal];
        _optionalLab.text = @"删除自选";
    }
    
    
    if (droopFloat < earlyFloat) { //低于开盘价
        if (droopFloat == 0) {
            _droopLab.textColor = [UIColor whiteColor];
        } else {
            _droopLab.textColor = [UIColor cmFallColor];
        }
    } else if (droopFloat == earlyFloat) {
        _droopLab.textColor = [UIColor whiteColor];
    } else { //开盘价
        _droopLab.textColor = [UIColor cmUpColor];
    }
    
    if (heiglyFloat < earlyFloat) {
        if (heiglyFloat == 0) {
            _heighlyLab.textColor = [UIColor whiteColor];
        } else {
            _heighlyLab.textColor = [UIColor cmFallColor];
        }
    } else if (heiglyFloat == earlyFloat) {
        _heighlyLab.textColor = [UIColor whiteColor];
    } else {
        _heighlyLab.textColor = [UIColor cmUpColor];
    }
    
    
    CGFloat hardenLoat = [dataProductArr[11] floatValue];
    if (hardenLoat > 0) {
        _hardenLab.text = CMFloatStringWithFormat(hardenLoat);//涨停
        _hardenLab.textColor = [UIColor cmUpColor];
    }
    
    CGFloat limitFloat = [dataProductArr[12] floatValue];
    if (limitFloat > 0) {
        _limitDownLab.text = CMFloatStringWithFormat(limitFloat); //跌停
        _limitDownLab.textColor = [UIColor cmFallColor];
    }
    CGFloat pastFloat = [dataProductArr[1] floatValue];
    if (pastFloat > 0) {
        _pastLab.text = CMFloatStringWithFormat(pastFloat); //昨收
    }
    CGFloat tradeFloat = [dataProductArr[13] floatValue];
    if (tradeFloat > 0) {
        _tradeLab.text = [NSString stringWithFormat:@"%.2f%%",tradeFloat]; //换手率
    }
    CGFloat municipFloat = [dataProductArr[14] floatValue];
    if (municipFloat >0) {
        _municipLab.text = [NSString stringWithFormat:@"%.2f%%",municipFloat]; //市营率
    }
    CGFloat portionFloat = [dataProductArr[15] floatValue];
    if (portionFloat > 0) {
        _portionLab.text =[NSString stringWithFormat:@"%.f",portionFloat]; //总份额
    }
    CGFloat maketFloat = [dataProductArr[16] floatValue];
    NSString *maketStr =[self roundFloatDisplay:maketFloat];
    if (maketFloat > 0) {
        _marketLab.text = maketStr;   //市值
    }
    
    BOOL isOK =[[NSUserDefaults standardUserDefaults]boolForKey:@"isOK"];
    
    
    
    if (isOK==NO) {
         _sharkImageView.image=[UIImage imageNamed:@"btn_Image_up"];
        
        
    } else {
     
        _sharkImageView.image=[UIImage imageNamed:@"btn_Image_line"];
    }
    
}

- (void)setProductCode:(NSString *)productCode {
    _productCode = productCode;
}

- (void)detailsLabTextColor:(UIColor *)color {
    _scopeLab.textColor = color;
}

- (IBAction)optionalBtnClick:(UIButton *)sender {
    if (!CMIsLogin()) {
        if ([self.delegate respondsToSelector:@selector(cm_productDetailsViewCell:)]) {
            [self.delegate cm_productDetailsViewCell:self];
        }
        return;
    } else {
        if (_optionIndex == 0) {
            if ([self.delegate respondsToSelector:@selector(cm_productOptionType:)]) {
                [self.delegate cm_productOptionType:CMProductOptionTypeAddOption ];//添加自选
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(cm_productOptionType:)]) {
                [self.delegate cm_productOptionType:CMProductOptionTypeDeleteOption];//删除自选
            }
        }
    }
}

//点击展开
- (IBAction)shrinkageBtnClick:(UIButton *)sender {
    
     BOOL isOK =[[NSUserDefaults standardUserDefaults]boolForKey:@"isOK"];
 
   
    
    if (isOK==NO) {
       
         _sharkImageView.image=[UIImage imageNamed:@"btn_Image_up"];
         [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isOK"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } else {
        
       
        _sharkImageView.image=[UIImage imageNamed:@"btn_Image_line"];
         [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isOK"];
         [[NSUserDefaults standardUserDefaults]synchronize];
    }
   

    if ([self.delegate respondsToSelector:@selector(cm_productOptionType:)]) {
        [self.delegate cm_productOptionType:CMProductOptionTypeShow];//删除自选
    }
}

/**
 *  格式化float，显示单位，保留2位小数
 *
 *  @return 格式化后的字符串
 */
- (NSString *)roundFloatDisplay:(CGFloat)value{
    
    NSString *unit = @"";
    if (value >= 10000) {
        value /= 10000.0;
        unit = @"万";
    } else if (value >= 1000000) {
        value /= 1000000.0;
        unit = @"百万";
    }
    
    //if ([unit isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%.2f",value];
    //}
   // return [NSString stringWithFormat:@"%.2f%@",value,unit];
}




@end










































