//
//  CMCentIntroductView.m
//  CMZC
//
//  Created by 云财富 on 2019/5/29.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMCentIntroductView.h"
@interface CMCentIntroductView ()
@property (weak, nonatomic) IBOutlet UIView *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end
@implementation CMCentIntroductView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
        
    _alertView.layer.cornerRadius=5.0;
    _sureBtn.layer.cornerRadius=5.0;
        
    }

- (IBAction)sureBtnDiMiss:(id)sender {
    
    [self removeFromSuperview];
}

@end
