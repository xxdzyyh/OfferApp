//
//  XFLoginVC.h
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/19.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFInputVC.h"

typedef NS_ENUM(NSUInteger,XFLoginType) {
    XFLoginTypeDefault,/**账号加密码*/
    XFLoginTypePhoneCode,/**<手机加验证码*/
};

@interface XFLoginVC : XFInputVC

@property (assign, nonatomic) XFLoginType loginType;

@property (copy, nonatomic) NSString *loginPath;
@property (copy, nonatomic) NSString *codePath;

/**
 登录请求路径

 @return 登录请求路径
 */
- (NSString *)loginPath;

/**
 获取验证码路径

 @return  获取验证码路径
 */
- (NSString *)codePath;

/**
 账号密码登录

 @param params 类似于 @{@"account" : @"your account",@"psd":@"your password"}，因为后台字段叫什么无法确定，所以传递过来
 @param completion 登录结果回调
 */
- (void)loginWithAccountPassword:(NSDictionary *)params completion:(void(^)(id res))completion;

/**
 通过手机获取验证码

 @param params  类似于 @{@"phone" : @"your phone"}，因为后台字段叫什么无法确定，所以传递过来
 @param completion 获取验证码结果回调
 */
- (void)getCodeWithParams:(NSDictionary *)params completion:(void (^)(id))completion;

/**
 通过手机号和验证码登录

 @param params 类似于 @{@"phone" : @"your phone",@"code":@"your code"}，因为后台字段叫什么无法确定，所以传递过来
 @param completion 结果回调
 */
- (void)loginWithPhoneCode:(NSDictionary *)params completion:(void(^)(id res))completion;

/**
 保存成功登录的参数

 @param account 账号
 @param password 密码
 */
- (void)saveSuccessLoginAccount:(NSString *)account password:(NSString *)password;

- (void)saveSuccessLoginPhone:(NSString *)phone;

- (NSString *)lastSuccessLoginPassword;
- (NSString *)lastSuccessLoginAccount;
- (NSString *)lastSuccessLoginPhone;

@end


