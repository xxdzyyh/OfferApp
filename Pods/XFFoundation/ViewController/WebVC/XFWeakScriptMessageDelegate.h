//
//  XFWeakScriptMessageDelegate.h
//  XFFoundation
//
//  Created by wangxuefeng on 2020/3/31.
//  Copyright © 2020 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XFWeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
