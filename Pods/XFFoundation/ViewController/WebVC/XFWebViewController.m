//
//  XFWebViewController.m
//  TourGuide
//
//  Created by xiaoniu on 2018/9/29.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "XFWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "XFWeakScriptMessageDelegate.h"

@interface XFWebViewController () <WKScriptMessageHandler>

@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@end

@implementation XFWebViewController

- (instancetype)initWithURL:(NSURL *)URL {
    self = [super init];
    if (self) {
        _URL = URL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self setupContraints];    
    [self setupEvent];
    [self bind];
    
    if (self.URL) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:self.URL]];
    }
}

- (void)dealloc {
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)setupSubviews {
    [self.view addSubview:self.webview];
    [self.view addSubview:self.progressView];
}

- (void)setupContraints {
    self.webview.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *layV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webview)];
    
    NSArray *layH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webview)];
    
    [self.view addConstraints:layV];
    [self.view addConstraints:layH];
}

- (void)setupEvent {
    
}

- (void)bind {    
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
         [self.progressView setProgress:[change[NSKeyValueChangeNewKey] floatValue] animated:YES];
    }
}

#pragma mark - Public

- (void)loadPlainTextAtPath:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [self.webview loadData:data MIMEType:@"text/plain" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:[NSBundle mainBundle].resourcePath]];
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //获取标题
    if (!self.titleName || self.titleName.length == 0) {
        [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString * title, NSError * _Nullable error) {
            NSString *realTitle = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            self.title = realTitle && realTitle.length ? realTitle : nil;
        }];
    }
}

#pragma mark - Property

- (WKWebView *)webview {
    if (_webview == nil) {
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        
        XFWeakScriptMessageDelegate *msgHandler = [[XFWeakScriptMessageDelegate alloc] initWithDelegate:self];
        [userController addScriptMessageHandler:msgHandler name:@"closeHtmlPage"];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences.minimumFontSize = 10.0;
        configuration.userContentController = userController;

        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scrollView.scrollEnabled = YES;
        _webview.allowsBackForwardNavigationGestures = YES;
    }
    return _webview;
}

- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), 3.0f)];
    }
    return _progressView;
}

@end
