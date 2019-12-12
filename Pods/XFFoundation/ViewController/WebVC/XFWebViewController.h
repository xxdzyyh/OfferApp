//
//  XFWebViewController.h
//  TourGuide
//
//  Created by xiaoniu on 2018/9/29.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface XFWebViewController : UIViewController <WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webview;

/**
 加载文本文件

 @param path 文件文件地址，UTF-8编码
 */
- (void)loadPlainTextAtPath:(NSString *)path;

- (instancetype)initWithURL:(NSURL *)URL;

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, copy) NSString *titleName;

@end
