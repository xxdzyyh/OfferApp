//
//  XFGridView.h
//  DevUIView
//
//  Created by wangxuefeng on 16/9/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFGridViewDataSource <NSObject>

- (NSUInteger)numberOfLinesAtX;

- (NSUInteger)numberOfLinesAtY;

@end

@interface XFGridView : UIView

@property (assign, nonatomic) NSUInteger numberOfLinesAtX;
@property (assign, nonatomic) NSUInteger numberOfLinesAtY;

@property (weak, nonatomic) id<XFGridViewDataSource> dataSource;

@property (copy, nonatomic) UIColor *lineColor;

@end
