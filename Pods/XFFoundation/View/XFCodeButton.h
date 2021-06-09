//
//  XFCodeButton.h
//  TourGuide
//
//  Created by xiaoniu on 2018/9/3.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFCodeButton : UIButton

/**总的时间，默认60s*/
@property (assign, nonatomic) NSUInteger totolCount;

/**当前计数*/
@property (assign, nonatomic) NSUInteger count;

/**默认 重新获取(%d)s*/
@property (strong, nonatomic) NSString *countFormat;

@property (strong, nonatomic) void(^onClickBlock)(void);

@end
