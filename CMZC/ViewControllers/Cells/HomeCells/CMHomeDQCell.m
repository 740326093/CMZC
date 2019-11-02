//
//  CMHomeDQCell.m
//  CaiMao
//
//  Created by WangWei on 2018/9/6.
//  Copyright © 2018年 58cm. All rights reserved.
//

#import "CMHomeDQCell.h"
@interface CMHomeDQCell ()
@property (weak, nonatomic) IBOutlet UILabel *MaxLab;

@property (weak, nonatomic) IBOutlet UIButton *CanBtn;
@property (weak, nonatomic) IBOutlet UILabel *minLab;

@property (weak, nonatomic) IBOutlet UILabel *QXLab;
@property (weak, nonatomic) IBOutlet UILabel *AmountLab;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *canYuLab;

@property (weak, nonatomic) IBOutlet UILabel *activeLab;
@property (weak, nonatomic) IBOutlet UILabel *incomeIntroLab;
@property (weak, nonatomic) IBOutlet UIImageView *activeImage;

@end
@implementation CMHomeDQCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _CanBtn.layer.cornerRadius=5.0;
}

-(void)setYCFListModel:(CMYCFPrModel *)YCFListModel{
    
    if(YCFListModel){
          _productTitle.text=YCFListModel.productName;
        _activeLab.hidden=YES;
      if(YCFListModel.reward>0){
       // if(![YCFListModel.pic isEqualToString:@""]){
            _activeImage.hidden=NO;
          
           // [_activeImage sd_setImageWithURL:[NSURL URLWithString:YCFListModel.pic]];
            // 设置年收益
                  float shouyi = YCFListModel.reward;
                  int x = (int)shouyi;
            _MaxLab.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
                  if ((shouyi-(float)x)*100 == 0) {
                      _minLab.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
                  } else {
                      _minLab.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
                  }
        }else{
            _activeImage.hidden=YES;
      
            
              float shouyi = YCFListModel.rate;
                   int x = (int)shouyi;
                   _MaxLab.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
                   if ((shouyi-(float)x)*100 == 0) {
                       _minLab.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
                   } else {
                       _minLab.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
                   }
        }
     
         
          // 设置期限
        _QXLab.text = @"灵活存取";
        _incomeIntroLab.text=YCFListModel.rateDescription;
          
          // 设置起投金额
        _AmountLab.text = [NSString stringWithFormat:@"%@元起投",YCFListModel.price];
       NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: _AmountLab.text];
           NSRange PayFromRang1 = [ _AmountLab.text rangeOfString:YCFListModel.price];
           
           [Pay addAttribute:NSForegroundColorAttributeName value:[UIColor cmThemeOrange] range:NSMakeRange(PayFromRang1.location,PayFromRang1.length)];
           _AmountLab.attributedText = Pay;
          
       
          
          
              [_CanBtn setTitle:@"快乐投资" forState:UIControlStateNormal];
              [_CanBtn setBackgroundColor:[UIColor cmThemeOrange]];
              _CanBtn.userInteractionEnabled = YES;
         
          
       
       }
       
       
}
-(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr  WithColor:(UIColor*)color{
    //UIColorFromRGB(0xfa3e19)
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location,1)];
    mainStr.attributedText = Pay;
    
}


- (IBAction)canEvent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(CanBtnEvent)]) {
        [self.delegate CanBtnEvent];
    }
    
}
@end
