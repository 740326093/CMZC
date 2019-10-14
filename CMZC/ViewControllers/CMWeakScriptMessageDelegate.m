//
//  CMWeakScriptMessageDelegate.m
//  CMZC
//
//  Created by 云财富 on 2019/10/14.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CMWeakScriptMessageDelegate.h"

@implementation CMWeakScriptMessageDelegate
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    

    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
