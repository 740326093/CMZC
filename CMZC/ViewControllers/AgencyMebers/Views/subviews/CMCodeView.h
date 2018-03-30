//
//  CMCodeView.h
//  CMZC
//
//  Created by WangWei on 2018/2/7.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCodeView : UIView
@property(nonatomic,copy)NSString *getCode;
@property(nonatomic,weak)id delegate;
@end
@protocol CMCodeViewDelegate <NSObject>
-(void)changeCode;
@end
