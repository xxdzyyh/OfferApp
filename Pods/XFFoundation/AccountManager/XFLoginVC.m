//
//  XFLoginVC.m
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/19.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFLoginVC.h"
#import "XFDevice.h"

#import <SAMKeychain/SAMKeychain.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface XFLoginVC ()

@end

@implementation XFLoginVC

- (NSString *)codePath {
    NSLog(@"%@",@"please return your code path");
    return @"";
}

- (NSString *)loginPath {
    NSLog(@"%@",@"please return your code path");
    return @"";
}

- (void)getCodeWithParams:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self codePath] parameters:params completion:completion];
}

- (void)loginWithAccountPassword:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self loginPath] parameters:params completion:completion];
}

- (void)loginWithPhoneCode:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self loginPath] parameters:params completion:completion];
}

#pragma mark - Private

- (void)saveSuccessLoginAccount:(NSString *)account password:(NSString *)password {
    if (account.length == 0 || password.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"lastSuccessLoginAccount"];
    [SAMKeychain setPassword:password forService:[XFDevice shareDevice].bundleID account:account];
}

- (void)saveSuccessLoginPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"lastSuccessLoginPhone"];
}

- (NSString *)lastSuccessLoginAccount {
   return  [[NSUserDefaults standardUserDefaults] stringForKey:@"lastSuccessLoginAccount"];
}

- (NSString *)lastSuccessLoginPhone {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"lastSuccessLoginPhone"];
}

- (NSString *)lastSuccessLoginPassword {
    return [SAMKeychain passwordForService:[XFDevice shareDevice].bundleID account:[self lastSuccessLoginAccount]]; 
}

@end
