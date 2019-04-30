//
//  CMScreeningView.m
//  CMZC
//
//  Created by WangWei on 2019/3/1.
//  Copyright © 2019年 MAC. All rights reserved.
//

#import "CMScreeningView.h"

@implementation CMScreeningView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)screeningSender:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ShowScreeingList:)]) {
        [self.delegate ShowScreeingList:_screeingTitle];
    }
    
    
}

@end
