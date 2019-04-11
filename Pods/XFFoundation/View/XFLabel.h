//
//  XFLabel.h
//  XFSocial
//
//  Created by wangxuefeng on 16/9/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface XFLabel : UILabel

/** 通过设置四周的间距来控制文字的位置 */
@property (assign, nonatomic) IBInspectable UIEdgeInsets paddings;

@end
