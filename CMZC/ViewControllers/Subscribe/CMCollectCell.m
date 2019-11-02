//
//  CMCollectCell.m
//  CMZC
//
//  Created by WangWei on 2017/4/14.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMCollectCell.h"

@implementation CMCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   _appleBtn.layer.masksToBounds = YES;
    _appleBtn.layer.cornerRadius = 5.0f;
}
-(void)setProduct:(CMPurchaseProduct *)product {
    
    _product = product;
    _subTitle.text = product.title;
    _SubStarLab.attributedText = product.attributed;
    _subDetail.text = product.descri;

    _subFenEr.text = product.targetamount;
    _subperNum.text = product.currentamount;
    if ([product.currentamount isEqualToString:@"0份"]) {
        _subperNum.text=@"--";
    }
    
    _subLingTou.text = product.leadinvestor;
    
    NSString * incomeString = [product.income substringToIndex:product.income.length-1];
    _subprogress.text = incomeString;
    _subQiXian.text = [NSString stringWithFormat:@"%@",product.deadline];
    
    [_appleBtn setTitle:product.status forState:UIControlStateNormal];
    if (product.isNextPage) {
        //_applyLab.textColor = [UIColor whiteColor];
        if ([product.status isEqualToString:@"立即申购"]) {
            
            [_appleBtn setBackgroundColor:[UIColor clmHex:0xff6400]];
            [_appleBtn addTarget:self action:@selector(subscribeEventClcik) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
            
            [_appleBtn setBackgroundColor:[UIColor clmHex:0xff6400]];
        }
        
    } else {
        
        [_appleBtn setBackgroundColor:[UIColor clmHex:0xcccccc]];
    }

    _subproId.text = [NSString stringWithFormat:@"(%@)",product.jyCode];
}

//立即申购
-(void)subscribeEventClcik{
    
    if (self.index) {
        self.applyBtnClickBlock(self.index);
    }
    
}


@end
