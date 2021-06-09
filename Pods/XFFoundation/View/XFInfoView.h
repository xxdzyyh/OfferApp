//
//  XFInfoView.h
//  CTQProject
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFInfoView : UIView

@property (copy  , nonatomic) NSString *info;
@property (copy  , nonatomic) NSString *imageName;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic, readonly) UIView *customView;

@property (assign, nonatomic) float padding;

- (instancetype)initWithInfo:(NSString *)info imageName:(NSString *)imageName;

- (instancetype)initWithInfo:(NSString *)info customView:(UIView *)customView;

- (void)showAtView:(UIView *)superview;

- (void)dismiss;

@end
