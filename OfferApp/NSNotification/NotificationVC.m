//
//  NotificationVC.m
//  OfferApp
//
//  Created by jmf66 on 2019/11/27.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "NotificationVC.h"
#import "UIView+Yoga.h"

#define NotificationName @"wwwwwwwwww"

@interface NotificationVC ()

@property (nonatomic, strong) NSObject *firstObj;
@property (nonatomic, strong) NSObject *secondObj;

@property (nonatomic, strong) UIButton *sendNotificationButton;
@property (nonatomic, strong) UIButton *sendFirstNotificationButton;
@property (nonatomic, strong) UIButton *sendSecondNotificationButton;


@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firstObj = [NSObject new];
    self.secondObj = [NSObject new];
    
    [self setupSubviews];
    [self setupConstraints];
    
    // 接收指定名称的通知，而不在乎 notification.object 是谁
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotify) name:NotificationName object:nil];
    // 接收指定名称的通知，而 notification.object 必须是 self.firstObj，需要注意self.firstObj如果为nil，就变成接收指定名称的通知，而不在乎 notification.object 是谁
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotifyWithFirstObj) name:NotificationName object:self.firstObj];
    // 接收指定名称的通知，而 notification.object 必须是 self.secondObj，需要注意self.secondObj如果为nil，就变成接收指定名称的通知，而不在乎 notification.object 是谁
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotifyWithSecondObj) name:NotificationName object:self.secondObj];
    
    // 很多时候，设置了object对消息进行过滤没有生效，就是因为设置的object为nil
}

- (void)sendNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:nil];
}

- (void)sendFirstNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:self.firstObj];
}

- (void)sendSecondNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:self.secondObj];
}

- (void)recieveNotify {
    NSLog(@"recieveNotify");
}

- (void)recieveNotifyWithFirstObj {
    NSLog(@"recieveNotifyWithFirstObj");
}

- (void)recieveNotifyWithSecondObj {
    NSLog(@"recieveNotifyWithSecondObj");
}

#pragma mark - Private Methods

- (void)setupSubviews {
    [self.view addSubview:self.sendNotificationButton];
    [self.view addSubview:self.sendFirstNotificationButton];
    [self.view addSubview:self.sendSecondNotificationButton];
}

- (void)setupConstraints {
    self.sendNotificationButton.yoga.isEnabled = YES;
    self.sendFirstNotificationButton.yoga.isEnabled = YES;
    self.sendSecondNotificationButton.yoga.isEnabled = YES;
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(100);
        layout.flexWrap = YGFlexDirectionColumn;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignFlexStart;
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

#pragma mark - Property

- (UIButton*)sendNotificationButton {
    if (!_sendNotificationButton) {
        _sendNotificationButton= [[UIButton alloc] init];
        
        [_sendNotificationButton setTitle:@"Notification" forState:UIControlStateNormal];
        [_sendNotificationButton addTarget:self action:@selector(sendNotification) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendNotificationButton;
}

- (UIButton*)sendFirstNotificationButton {
    if (!_sendFirstNotificationButton) {
        _sendFirstNotificationButton= [[UIButton alloc] init];
        
        [_sendFirstNotificationButton setTitle:@"FirstNotification" forState:UIControlStateNormal];
        [_sendFirstNotificationButton addTarget:self action:@selector(sendFirstNotification) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendFirstNotificationButton;
}

- (UIButton*)sendSecondNotificationButton {
    if (!_sendSecondNotificationButton) {
        _sendSecondNotificationButton= [[UIButton alloc] init];
        
        [_sendSecondNotificationButton setTitle:@"SecondNotification" forState:UIControlStateNormal];
        [_sendSecondNotificationButton addTarget:self action:@selector(sendSecondNotification) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendSecondNotificationButton;
}

@end
