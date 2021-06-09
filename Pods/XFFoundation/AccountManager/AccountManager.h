//
//  AccountManager.h
//  XFFoundation
//
//  Created by wangxuefeng on 17/3/20.
//  Copyright © 2017年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFUserInterface.h"
#import "SynthesizeSingleton.h"

#define kAccessToken @"kAccessToken"
#define IsLogin [AccountManager sharedAccountManager].isLogin

@protocol AccountManagerDelegate <NSObject>

/**
 显示登录界面
 */
- (void)login:(void(^)(BOOL success))completion;

/**
 自动登录，不用显示登录界面
 */
- (void)autoLogin:(void(^)(BOOL success))completion;

/**
 退出登录

 @param withUI 是否要显示登录界面
 */
- (void)logoutWithLoginUI:(BOOL)withUI completion:(void(^)(BOOL success))completion;

@end

@protocol AccountManagerObserver <NSObject>

@optional

- (void)loginSuccess;
- (void)logoutSuccess;

@end

@interface AccountManager : NSObject <AccountManagerDelegate>

DECLARE_SINGLETON_FOR_CLASS(AccountManager)

@property (weak, nonatomic) id<AccountManagerDelegate>delegate;

/** 当前登录的用户
 * 如果设置 currentUser != nil 意味着登录成功，会通知观察者登录成功
 * 如果设置 currentUser  = nil 意味着登出成功，会通知观察者登出成功
 */
@property (strong, nonatomic) id<XFUserInterface>currentUser;

@property (strong, nonatomic) NSString *accessToken;

- (void)saveAccount:(NSString *)account password:(NSString *)password;

/** 是否已经登录*/
- (BOOL)isLogin;

/** 最后登录的用户 */
@property (strong, nonatomic) id<XFUserInterface>lastUser;

/*! 添加登录观察者 */
- (void)addLoginObserver:(id<AccountManagerObserver>)observer;

/*! 移除登录观察者 */
- (void)removeLoginObserver:(id<AccountManagerObserver>)observer;

@end
