//
//  CMSubmittedWinView.h
//  CMZC
//
//  Created by MAC on 16/12/27.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CMSubmittedBlock)();

@interface CMSubmittedWinView : UIView

@property (nonatomic,copy) CMSubmittedBlock block;

@end
