//
//  XFWeakScriptMessageDelegate.m
//  Tao
//
//  Created by xiaoniu on 2019/8/9.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import "XFWeakScriptMessageDelegate.h"

@interface XFWeakScriptMessageDelegate() 

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation XFWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
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
