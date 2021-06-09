//
//  AccountManager.m
//  XFFoundation
//
//  Created by wangxuefeng on 17/3/20.
//  Copyright © 2017年 wangxuefeng. All rights reserved.
//

#import "AccountManager.h"

#define kAccount @"kAccount"
#define kPassword @"kPassword"

@interface AccountManager ()

/*! 现有的观察着 */
@property (strong, nonatomic) NSMutableArray *observers;

@end

@implementation AccountManager

@synthesize accessToken = _accessToken;

SYNTHESIZE_SINGLETON_FOR_CLASS(AccountManager)

- (void)clearLoginUserData {
    _currentUser = nil;
    _accessToken = nil;
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:kAccessToken];
	[self notifyLogoutSuccess];
}

- (BOOL)isLogin {
    return self.accessToken.length > 0;
}

- (void)setCurrentUser:(id<XFUserInterface>)currentUser {
    _currentUser = currentUser;
    
    if (_currentUser.accessToken) {
        _accessToken = _currentUser.accessToken;
		[self notifyLoginSuccess];
        [[NSUserDefaults standardUserDefaults] setObject:_accessToken forKey:kAccessToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [self clearLoginUserData];
    }
}

- (NSString *)accessToken {
    if (_accessToken != nil) {
        return _accessToken;
    }
    
    if (self.currentUser != nil) {
        _accessToken = self.currentUser.accessToken;
    }
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:kAccessToken];
    
    if (token) {
        _accessToken = token;
    }
    
    return _accessToken;
}

- (void)saveAccount:(NSString *)account password:(NSString *)password {
	[[NSUserDefaults standardUserDefaults] setObject:account forKey:kAccount];
	[[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 通知监听者

- (void)addLoginObserver:(id<AccountManagerObserver>)observer {
    if (observer == nil) {
        return;
    }

    if ([self.observers containsObject:observer]) {
        return;
    }
    
    if (self.observers == nil) {
        self.observers = [NSMutableArray array];
    }
    [self.observers addObject:observer];
}

- (void)removeLoginObserver:(id<AccountManagerObserver>)observer {
    if (observer == nil) {
        return;
    }
    
    [self.observers removeObject:observer];
}

- (void)notifyLoginSuccess {
    for (id<AccountManagerObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(loginSuccess)]) {
            [obj loginSuccess];
        }
    }
}

- (void)notifyLogoutSuccess {
    for (id<AccountManagerObserver> obj in self.observers) {
        if ([obj respondsToSelector:@selector(logoutSuccess)]) {
            [obj logoutSuccess];
        }
    }
}

#pragma mark - AccountManagerDelegate

- (void)login:(void (^)(BOOL))completion {
    if (self.delegate && [self.delegate respondsToSelector:@selector(login:)]) {
        [self.delegate login:completion];
    }
}

- (void)logoutWithLoginUI:(BOOL)withUI completion:(void (^)(BOOL))completion {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logoutWithLoginUI:completion:)]) {
        [self.delegate logoutWithLoginUI:withUI completion:completion];
    }
}

- (void)autoLogin:(void (^)(BOOL))completion { 
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoLogin:)]) {
        [self.delegate autoLogin:completion];
    }
}

@end
