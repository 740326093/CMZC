//
//  CMCustomTextView.m
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CMCustomTextView.h"
@interface CMCustomTextView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *cureTextView;
@property (weak, nonatomic) IBOutlet UIImageView *placeerImage;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLab;

@end
@implementation CMCustomTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];

    _cureTextView.delegate=self;
}



- (void)textViewDidChange:(UITextView *)textView{
    _placeerImage.hidden=YES;
    _placeHolderLab.hidden=YES;
     MyLog(@"++%@",textView.text);
    
    if ([self.delegate respondsToSelector:@selector(getTextViewContentString:)]) {
        [self.delegate getTextViewContentString:textView.text];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<=0) {
      _placeerImage.hidden=NO;
    _placeHolderLab.hidden=NO;
    }
    
}
-(void)setType:(ConsultType)type{
    switch (type) {
        case CustomType:
            _placeHolderLab.text=@"请输入您想咨询的内容";
            break;
        case LingTouProject:
            _placeHolderLab.text=@"请输入您想领投的项目";
            break;
            
        case ApplyProject:
            _placeHolderLab.text=@"请输入您想承销的项目";
            break;
            
            
        default:
            break;
    }
    
}

@end
