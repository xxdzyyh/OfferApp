//
//  XFKeyValueView.h
//  Tao
//
//  Created by wangxuefeng on 2019/7/6.
//  Copyright © 2019年 App4life Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 显示名称和值
 */
@interface XFKeyValueView : UIView

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (assign, nonatomic) CGFloat padding;

@end

NS_ASSUME_NONNULL_END
