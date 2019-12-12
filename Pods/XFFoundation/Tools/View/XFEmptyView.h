//
//  XFEmptyView.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/11.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFEmptyView : UIControl

@property (copy  , nonatomic) NSString *title;
@property (copy  , nonatomic) NSString *imageName;

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)imageName;

@end
