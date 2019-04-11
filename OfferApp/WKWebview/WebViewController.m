//
//  WebViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/10.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface WebViewController () <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); 
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    
    if (path) {
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    }    
}

- (WKWebViewConfiguration *)configuration {
    if (_configuration == nil) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        
        _configuration.userContentController = [WKUserContentController new];

        // window.webkit.messageHandlers.<name>.postMessage(<messageBody>)
        [_configuration.userContentController addScriptMessageHandler:self name:@"btnClick"];
        
        // 进行偏好设置
        WKPreferences *preferences = [WKPreferences new];
        
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 40.0;
        
        _configuration.preferences = preferences;
    }
    return _configuration;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
    }
    return _webView;
}

- (void)ocToJS {
    [self.webView evaluateJavaScript:@"" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
        
    }];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.name);
    NSLog(@"%@",message.body);
}

@end
