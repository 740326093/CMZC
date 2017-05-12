//
//  CMConsultingAlertView.m
//  CMZC
//
//  Created by WangWei on 2017/4/8.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "CMConsultingAlertView.h"

@implementation CMConsultingAlertView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
          if(self){
              
              //模糊视图
              UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
              bgView.userInteractionEnabled=YES;
              bgView.backgroundColor=[UIColor blackColor];
              bgView.alpha=0.52f;
              [self addSubview:bgView];
               UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
              [bgView addGestureRecognizer:tap];
              //弹框背景
              UIView *contentView=[[UIView alloc]init];
              contentView.backgroundColor=[UIColor whiteColor];
              [self addSubview:contentView];
              [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.top.equalTo(bgView.mas_top).offset(100);
                  make.height.mas_equalTo(250);
                  make.left.equalTo(bgView.mas_left).offset(15);
                  make.right.equalTo(bgView.mas_right).offset(-15);
              }];
 
              [contentView addSubview:self.sendMessagebtn];
              [self.sendMessagebtn mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.height.mas_equalTo(40);
                  make.left.right.bottom.equalTo(contentView);
                  
              }];
              
            
              JSQMessagesComposerTextView *inPutTextView=[[JSQMessagesComposerTextView alloc]initWithFrame:CGRectMake(15, 10,bgView.frame.size.width-15-15-15-15, 250-40-10-10 ) textContainer:nil];
              inPutTextView.placeHolder=@"请输入您要咨询的内容";
              inPutTextView.placeHolderTextColor=[UIColor clmHex:0x999999];
              inPutTextView.layer.borderWidth=0.5;
              inPutTextView.layer.borderColor=[UIColor clmHex:0xedeef2].CGColor;

              inPutTextView.font=[UIFont systemFontOfSize:14.0];
              [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewInPutText:) name:UITextViewTextDidChangeNotification object:inPutTextView];
              [contentView addSubview:inPutTextView];

          }
          return self;
}


-(UIButton*)sendMessagebtn{
    if (!_sendMessagebtn) {
        _sendMessagebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendMessagebtn setTitle:@"发布" forState:UIControlStateNormal];
        _sendMessagebtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_sendMessagebtn addTarget:self action:@selector(postMessage:) forControlEvents:UIControlEventTouchUpInside];
        [_sendMessagebtn setBackgroundColor:[UIColor clmHex:0xe4e4e4]];
         _sendMessagebtn.userInteractionEnabled=NO;
    }
    return _sendMessagebtn;
}

-(void)textViewInPutText:(NSNotification*)notice
{
    JSQMessagesComposerTextView *textView=(JSQMessagesComposerTextView*)notice.object;
  
    if (textView.text==nil||textView.text.length<=0) {
        [self.sendMessagebtn setBackgroundColor:[UIColor clmHex:0xe4e4e4]];
        self.sendMessagebtn.userInteractionEnabled=NO;
        
    }else{
        [self.sendMessagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendMessagebtn setBackgroundColor:[UIColor clmHex:0xff6400]];
        self.sendMessagebtn.userInteractionEnabled=YES;
        _sendMessageString=textView.text;
    }
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)postMessage:(id)sender {
    //MyLog(@"++++%@",_sendMessageString);
    if (_sendMessageString!=nil) {
    if ([self.delegate respondsToSelector:@selector(postConsultingInformation:)]) {
        [self.delegate postConsultingInformation:_sendMessageString];
    }
    }
    [self removeFromSuperview];
    

    
}
-(void)removeView{
    [self removeFromSuperview];
}

    
@end
