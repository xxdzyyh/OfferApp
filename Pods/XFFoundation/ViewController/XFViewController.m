//
//  XFViewController.m
//  XFFoundation
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "XFEmptyView.h"

#import "XFLoadingView.h"
#import "UMMobClick/MobClick.h"
#import "Masonry.h"

@interface XFViewController () <XFErrorViewDelegate>

@property (weak  , nonatomic) UIView        *loadingSuperiew;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) XFLoadingView *loadingView;

@end

@implementation XFViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // default is YES
        _shouldShowErrorView = YES;
        _dataType = XFDataTypeRequest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFailedNeedLogin) name:@"kReuqestNeedLogin" object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *string = self.title;
    
    if (self.title.length == 0) {
        string = self.navigationItem.title;
    }
    
    if (string.length > 0) {
        [MobClick beginLogPageView:string];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self closeLoadingView];
    
    NSString *string = self.title;
    
    if (self.title.length == 0) {
        string = self.navigationItem.title;
    }
    
    if (string.length > 0) {
        [MobClick endLogPageView:string];
    }
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
    if (_isHUDShowing == YES) {
        return;
    } else {
        if (_isFisrtLoading) {
    
            [self.loadingView showAtView:self.view];
            
        } else {
            UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
            
            if (![_hud.superview isEqual:window]) {

                [_hud hideAnimated:YES];
                
                _hud = nil;
            }
            
            self.hud.backgroundColor = [UIColor clearColor];
            
            [self.hud showAnimated:YES];
        }
        _isHUDShowing = YES;
    }
}

- (void)closeLoadingView {
    if (_hud.superview) {
        [_hud hideAnimated:YES];
    }
    
    if (self.loadingView.superview) {
        [self.loadingView dismiss];
    }
    
    _isHUDShowing = NO;
}

- (void)showInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }

    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = status;
    hud.margin = 10.f;
//    float h = [UIScreen mainScreen].bounds.size.height;
//    hud.yOffset = h/2 - 100;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)showCenterInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
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

- (void)mainRequestStart {
    [self closeLoadingView];
    
    switch (self.hudType) {
        case XFHUDTypeDefault: {
            [self showLoadingView];
            break;
        }
        case XFHUDTypeNone: {
            
            break;
        }
        case XFHUDTypeProgress: {
            [self showLoadingView];
            break;
        }
        case XFHUDTypeNetIndictor: {
            
            break;
        }
    }
}

- (void)mainRequestFinish {
    [self closeLoadingView];
    _isFisrtLoading = NO;
}

- (NSNumber *)mainRequestFailure:(NSNumber *)status {
    _isFisrtLoading = NO;
    
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
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        
        _hud = [[MBProgressHUD alloc] initWithView:window];
        
        _hud.userInteractionEnabled = NO;
        _hud.margin = 10.f;
        _hud.removeFromSuperViewOnHide = YES;
        _hud.alpha = 0;
        
        [window addSubview:_hud];
    }

    return _hud;
}

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

#pragma mark - helper

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font {
    CGSize size = [string boundingRectWithSize:CGSizeZero
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil].size;
    return size;
}

@end
