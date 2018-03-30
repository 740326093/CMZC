//
//  CMCustomTextView.h
//  CMZC
//
//  Created by WangWei on 2018/2/2.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMConsultController.h"
@interface CMCustomTextView : UIView
@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)ConsultType type;
@end
@protocol CMCustomTextViewDelegate <NSObject>

-(void)getTextViewContentString:(NSString*)string;
@end
