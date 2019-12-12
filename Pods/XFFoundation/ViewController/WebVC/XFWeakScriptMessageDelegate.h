//
//  XFWeakScriptMessageDelegate.h
//  Tao
//
//  Created by xiaoniu on 2019/8/9.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XFWeakScriptMessageDelegate : NSObject <WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
