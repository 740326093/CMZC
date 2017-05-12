//
//  CMAnalystAnswer.m
//  CMZC
//
//  Created by 财猫 on 16/3/31.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "CMAnalystAnswer.h"

@implementation CMAnalystAnswer

- (CGFloat)cellHeight {
    CGFloat height = [self.content getHeightIncomingWidth:CMScreen_width()- 145 incomingFont:13];
    return height - 16;
}

@end


@implementation CMAnalystViewpoint


@end
