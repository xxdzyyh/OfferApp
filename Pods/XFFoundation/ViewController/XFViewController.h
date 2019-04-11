//
//  XFViewController.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFRequestQueue.h"

#import "XFErrorView.h"

typedef NS_ENUM(NSUInteger,XFHUDType) {
    XFHUDTypeDefault,/*<默认是XFHUDTypeProgress*/
    XFHUDTypeNone,/*<不显示*/
    XFHUDTypeProgress,/*<显示菊花*/
    XFHUDTypeNetIndictor/**<状态栏显示小菊花*/
};

typedef NS_ENUM(NSUInteger,XFDataType) {
    XFDataTypeRequest,
    XFDataTypeLocal
};

@interface XFViewController : UIViewController

/**
 是否可以显示错误提示视图
 */
@property (assign, nonatomic) BOOL shouldShowErrorView;


/**
 错误提示视图,懒加载，
 */
@property (strong, nonatomic) XFErrorView  *errorView;


/**
 设置错误提示语

 @param errorMessage 错误提示语
 */
- (void)setErrorMessage:(NSString *)errorMessage;

/**
 设置错误提示的图片名称

 @param errorImageName 错误提示的图片名称
 */
- (void)setErrorImageName:(NSString *)errorImageName;

/**
 请求队列，会处理loadingView的显示和隐藏、错误视图显示和重试
 */
@property (strong, nonatomic) XFRequestQueue *mainQueue;

@property (assign, nonatomic) XFDataType dataType;

@property (assign, nonatomic) XFHUDType hudType;

@property (assign, nonatomic) BOOL isHUDShowing;

// 是否显示XFLoadingView，default is NO
@property (assign, nonatomic) BOOL isFisrtLoading;


/** 显示一个错位的视图 */
- (void)showErrorView;

/*！调用该方法重新发送失败的请求 */
- (void)retryAfterRequestFailed;

- (void)showLoadingView;

- (void)closeLoadingView;

- (void)showInfoWithStatus:(NSString *)status;

- (void)showCenterInfoWithStatus:(NSString *)status;

+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 自定义返回按钮点击

 @param sender
 */
- (void)onCustomBackItemClicked:(id)sender;

/**
 一般而言，一个界面就一个请求
 */
- (void)sendDefaultRequest;

#pragma mark - helper

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

@end
