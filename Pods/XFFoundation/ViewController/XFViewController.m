//
//  XFViewController.m
//  XFFoundation
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFViewController.h"

// Third
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MBProgressHUD/MBProgressHUD.h>

// 
#import "XFEmptyView.h"
#import "XFLoadingView.h"

@interface XFViewController () <XFErrorViewDelegate>

@property (weak  , nonatomic) UIView *loadingSuperiew;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) XFLoadingView *loadingView;

@end

@implementation XFViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _shouldShowErrorView = YES;
        _dataType = XFDataTypeRequest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFailedNeedLogin) name:@"kReuqestNeedLogin" object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self closeLoadingView];
}

- (void)dealloc {
    NSLog(@"dealloc %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kReuqestNeedLogin" object:nil];
}

#pragma mark - notification

- (void)requestFailedNeedLogin {
    // 如果请求失败原因是登录失效，则会触发
    [self closeLoadingView];
    [self showInfoWithStatus:@"登录已失效，请重新登录"];
}

#pragma mark - event response

- (void)retryAfterRequestFailed {
    [self closeErrorView];
    [self.mainQueue execute];
}

- (void)recoveryFromError:(XFErrorView *)errorView {
    [self retryAfterRequestFailed];
}

- (void)setErrorMessage:(NSString *)errorMessage {
    self.errorView.info = errorMessage;
}

- (void)setErrorImageName:(NSString *)errorImageName {
    self.errorView.imageName = errorImageName;
}

- (void)showErrorView {
    if (!self.errorView.superview) {
        [self.errorView showAtView:self.view];
    }
}

- (void)closeErrorView {
    if (self.errorView.superview) {
        [self.errorView removeFromSuperview];
    }
}

- (void)showLoadingView {
    if (_isLoading == YES) {
        return;
    } else {
        if (_fisrtLoading) {
            [self.loadingView showAtView:self.view];
        } else {
            self.hud.backgroundColor = [UIColor clearColor];  
            [self.view addSubview:self.hud];
            [self.view bringSubviewToFront:self.hud];
            [self.hud showAnimated:YES];
        }
        _isLoading = YES;
    }
}

- (void)closeLoadingView {
    if (_hud.superview) {
        [_hud hideAnimated:YES];
    }
    
    if (self.loadingView.superview) {
        [self.loadingView dismiss];
    }
    
    _isLoading = NO;
}

- (void)showInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }

    UIWindow *window = [[UIApplication sharedApplication].delegate window];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = status;
    hud.margin = 10.f;
	hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)showCenterInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    hud.label.text = status;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)onCustomBackItemClicked:(id)sender {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - request queue

- (void)sendDefaultRequest {
    
}

- (void)mainRequestWithPath:(NSString *)path completion:(void (^)(id))completion {
    [self requestWithQueue:self.mainQueue path:path parameters:nil completion:completion];
}

- (void)mainRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    [self requestWithQueue:self.mainQueue path:path parameters:parameters completion:completion];
}

- (void)mainRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    [self requestWithQueue:self.mainQueue url:url parameters:parameters completion:completion];
}

- (void)otherRequestWithPath:(NSString *)path completion:(void (^)(id))completion {
    [self requestWithQueue:self.otherQueue path:path parameters:nil completion:completion];
}

- (void)otherRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    [self requestWithQueue:self.otherQueue path:path parameters:parameters completion:completion];
}

- (void)otherRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    [self requestWithQueue:self.otherQueue url:url parameters:parameters completion:completion];
}

- (void)requestWithQueue:(XFRequestQueue *)queue url:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    XFRequest *req = [XFRequest url:url finish:^(XFRequest *request, id result) {
        if (completion) {
            completion(result);
        }
    }];
    [req addParameters:parameters];
    
    if (queue) {
        [queue push:req];
    } else {
        [req start];
    }
}

- (void)requestWithQueue:(XFRequestQueue *)queue path:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(id))completion {
    XFRequest *req = [[XFRequest alloc] initWithPath:path finish:^(XFRequest *request, id result) {
        if (completion) {
            completion(result);
        }
    }];
    [req addParameters:parameters];
    
    if (queue) {
        [queue push:req];
    } else {
        [req start];
    }
}

#pragma mark - Request Queue

-(XFRequestQueue *)mainQueue {
    if (_mainQueue == nil) {
        _mainQueue = [[XFRequestQueue alloc] initWithName:@"mainQueue"];
        
        _mainQueue.target = self;
        _mainQueue.requestStartSelector   = @selector(mainRequestStart);
        _mainQueue.requestSuccessSelector = @selector(mainRequestSuccess);
        _mainQueue.requestFinishSelector  = @selector(mainRequestFinish);
        _mainQueue.requestFailureSelector = @selector(mainRequestFailure:);
    }
    return _mainQueue;
}

- (void)mainRequestStart {
    // 容错处理，一般是什么都没做
    [self closeLoadingView];
    
    [self showLoadingView];
}

- (void)mainRequestFinish {
    [self closeLoadingView];
    _fisrtLoading = NO;
}

- (NSNumber *)mainRequestFailure:(NSNumber *)status {
    _fisrtLoading = NO;
    
    [self closeLoadingView];
    
    if (status.intValue == ResponseStatusUrlNotFound) {
        self.errorView.imageName = @"error_urlnotfound";
        self.errorView.info = @"服务器睡着了，稍后再来吧";
    } else {
        self.errorView.imageName = @"error_urlnotfound";
        self.errorView.info = @"数据加载失败，请检查网络设置";
    }
    
    [self showErrorView];
    
    return @(self.shouldShowErrorView);
}

- (void)mainRequestSuccess {
    
}

#pragma mark - Other Request Queue

- (XFRequestQueue *)otherQueue {
    if (_otherQueue == nil) {
        _otherQueue = [[XFRequestQueue alloc] initWithName:@"otherQueue"];
        
        _otherQueue.target = self;
        _otherQueue.requestStartSelector = @selector(otherRequestQueueStart);
        _otherQueue.requestFinishSelector = @selector(otherRequestQueueFinish);
        _otherQueue.requestFailureSelector = @selector(otherRequestQueueFailure:);
        _otherQueue.requestSuccessSelector = @selector(otherRequestQueueSuccess);
    }
    return _otherQueue;
}

- (void)otherRequestQueueStart {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)otherRequestQueueFinish {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)otherRequestQueueSuccess {
    
}

- (NSNumber *)otherRequestQueueFailure:(NSNumber *)status {
    return @0;
}

#pragma mark - getter & setter

- (XFLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [XFLoadingView loadingView];
    }
    return _loadingView;
}

- (XFErrorView *)errorView {
    if (_errorView == nil) {
        _errorView = [[XFErrorView alloc] initWithInfo:@"出错了" imageName:@"img_mr_nowifi"];
        
        _errorView.imageName = @"img_mr_nowifi";
        _errorView.delegate = self;
    }
    return _errorView;
}

- (MBProgressHUD *)hud {
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        _hud.userInteractionEnabled = NO;
        _hud.margin = 10.f;
        _hud.removeFromSuperViewOnHide = YES;
        _hud.alpha = 0;
        
        [self.view addSubview:_hud];
    }
    return _hud;
}

@end
