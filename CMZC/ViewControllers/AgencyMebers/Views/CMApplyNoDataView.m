//
//  CMApplyNoDataView.m
//  CMZC
//
//  Created by WangWei on 2018/2/3.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMApplyNoDataView.h"
#import "CMConsultController.h"
@interface CMApplyNoDataView ()

@property (weak, nonatomic) IBOutlet UIImageView *noDataImage;
@property (weak, nonatomic) IBOutlet UILabel *NoProjectLab;
@property (weak, nonatomic) IBOutlet UILabel *enterProjectApplyLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offLeft;

@end
@implementation CMApplyNoDataView
-(void)awakeFromNib{
    [super awakeFromNib];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: _enterProjectApplyLab.text attributes:attribtDic];
    //赋值
    _enterProjectApplyLab.attributedText = attribtStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)updateNoDataImage:(NSString*)imageStr andnoDataTitle:(NSString*)title withApplyString:(NSString*)applyStr{
    _noDataImage.image=[UIImage imageNamed:imageStr];
    _NoProjectLab.text=title;
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: applyStr attributes:attribtDic];
    //赋值
    _enterProjectApplyLab.attributedText = attribtStr;
    if(applyStr.length>4){
        _offLeft.constant=-13;
    }
    
}
- (IBAction)enterProjectApplyEnent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(applyEvent)]) {
        [self.delegate applyEvent];
    }
}

@end
