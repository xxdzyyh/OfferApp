//
//  NSString+Size.h
//  Tao
//
//  Created by wangxuefeng on 2019/7/10.
//  Copyright © 2019年 App4life Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font perferWidth:(float)width;
	
@end

NS_ASSUME_NONNULL_END
