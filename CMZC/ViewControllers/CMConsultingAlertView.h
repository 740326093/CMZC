//
//  CMConsultingAlertView.h
//  CMZC
//
//  Created by WangWei on 2017/4/8.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"JSQMessagesComposerTextView.h"
@interface CMConsultingAlertView : UIView

@property (strong, nonatomic)  UIButton *sendMessagebtn;
@property(nonatomic,copy)NSString *sendMessageString;
@property(nonatomic,weak)id delegate;
@end
@protocol CMConsultingAlertViewDelegate <NSObject>
//发送咨询信息
-(void)postConsultingInformation:(NSString*)Information;

@end
