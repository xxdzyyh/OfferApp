//
//  XFGuideVC.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/9.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFGuideVC : UIViewController

@property (assign, nonatomic) BOOL hasSkipButton;
@property (strong, nonatomic) NSString *skipButtonTitle;

// default
@property (strong, nonatomic) NSString *startButtonTitle;

/** 开始 */
@property (strong, nonatomic) UIButton *startButton;

@end
