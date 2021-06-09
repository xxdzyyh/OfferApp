//
//  XFViewController.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFRequest.h"
#import "XFErrorView.h"

typedef NS_ENUM(NSUInteger,XFDataType) {
    XFDataTypeRequest,
    XFDataTypeLocal
};

#define XFToast(A) [self showInfoWithStatus:A]

@interface XFViewController : UIViewController

#pragma mark - 导航栏

/**
 自定义返回按钮点击
 
 @param sender
 */
- (void)onCustomBackItemClicked:(id)sender;

#pragma mark - Loading

@property (assign, nonatomic) XFDataType dataType;

@property (assign, nonatomic) BOOL isLoading;

// loadView是否需要遮挡整个界面，有些场合需要遮挡直到请求返回结果，default is NO
@property (assign, nonatomic, getter=isFirstLoading) BOOL fisrtLoading;

- (void)showLoadingView;
- (void)closeLoadingView;

#pragma mark - Toast

- (void)showInfoWithStatus:(NSString *)status;
- (void)showCenterInfoWithStatus:(NSString *)status;

#pragma mark - 请求

/** 一般而言，一个界面就一个请求 */
- (void)sendDefaultRequest;

/**
 发送一个请求，只有公共参数

 @param path 请求路径
 @param completion 请求回调
 */
- (void)mainRequestWithPath:(NSString *)path completion:(void(^)(id result))completion;

/**
 发送一个请求

 @param path 请求路径
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)mainRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id result))completion;

/**
 发送一个请求

 @param url 请求完整地址
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)mainRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completion:(void(^)(id result))completion;

/**
 发送一个请求，只有公共参数
 
 @param path 请求路径
 @param completion 请求回调
 */
- (void)otherRequestWithPath:(NSString *)path completion:(void(^)(id result))completion;

/**
 发送一个请求
 
 @param path 请求路径
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)otherRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void(^)(id result))completion;

/**
 发送一个请求
 
 @param url 请求完整地址
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)otherRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completion:(void(^)(id result))completion;

/**
 发送请求
 
 @param queue 要加入的请求队列,如果传nil,则不加入队列直接start
 @param path 请求路径
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)requestWithQueue:(XFRequestQueue *)queue 
                    path:(NSString *)path
              parameters:(NSDictionary *)parameters 
              completion:(void(^)(id result))completion;


/**
 发送请求

 @param queue 要加入的请求队列,如果传nil,则不加入队列直接start
 @param url 请求完成地址
 @param parameters 请求参数
 @param completion 请求回调
 */
- (void)requestWithQueue:(nullable XFRequestQueue *)queue 
                     url:(NSString *)url
              parameters:(NSDictionary *)parameters 
              completion:(void(^)(id result))completion;

#pragma mark -- MainQueue

/**
 mainQueue请求队列的特点
 
 1. 自动处理loadingView的显示和隐藏
 2. 错误视图显示，如果请求失败了，会自动显示错误视图，可以点击重试
 */
@property (strong, nonatomic) XFRequestQueue *mainQueue;

- (void)mainRequestStart;

- (void)mainRequestFinish;

#pragma mark - 错误视图

/** 是否需要显示错误提示视图 */
@property (assign, nonatomic) BOOL shouldShowErrorView;

/** 显示一个错位的视图 */
- (void)showErrorView;

/** 错误提示视图,懒加载 */
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

/*！调用该方法重新发送失败的请求 */
- (void)retryAfterRequestFailed;

#pragma mark -- OtherQueue

/**
 不影响业务逻辑的请求可以放到这个队列执行，比如统计，这个队列的请求没有失败重试逻辑，也不显示loading，但是会在状态栏显示网络请求指示器
 */
@property (strong, nonatomic) XFRequestQueue *otherQueue;

@end
