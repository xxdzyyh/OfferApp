//
//  XFLoopView.h
//  LoopView
//
//  Created by wangxuefeng on 2017/11/28.
//  Copyright © 2017年 wangxuefeng. All rights reserved.
//
//  XFLoopView
//        UIScrollView
//            currentView
//                dataSource[i]
//            nextView
//                dataSource[i+1/-1]
//        UIPageControl
//
//  使用两个视图实现循环轮播，调用方通过setDataSource提供需要轮播的views即可
//  相较于一般的图片轮播，可以添加任意的UIView，需要点击功能，调用者可以在创建view的时候，自行添加。
//  除了轮播，一点额外的功能都不带
//
//  ImageLoopView
//        UIScrollView
//            currentImageView
//            nextImageView
//


#import <UIKit/UIKit.h>

@interface XFLoopView : UIView

// 数据源
@property (strong, nonatomic) NSMutableArray <__kindof UIView *>*dataSource;

/**自动切换时间间隔*/
@property (assign, nonatomic) CGFloat timeInterval;

- (void)clear;

@end
