//
//  CMServerPromptView.h
//  CMZC
//
//  Created by MAC on 16/12/27.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ServerPrompt)();

@interface CMServerPromptView : UIView

@property (nonatomic,copy)ServerPrompt typeBlock;

@property (nonatomic,copy) NSString *imageNameStr;

@end
