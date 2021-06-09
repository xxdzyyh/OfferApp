//
//  NSObject+Hud.h
//  Tao
//
//  Created by xiaoniu on 2019/6/28.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Hud)

+ (void)showInfoWithStatus:(NSString *)status;
+ (void)showCenterInfoWithStatus:(NSString *)status;

@end

NS_ASSUME_NONNULL_END
