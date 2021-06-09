//
//  XFForgotPasswordVC.m
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/22.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFForgotPasswordVC.h"
#import "XFRequest.h"

@interface XFForgotPasswordVC ()

@end

@implementation XFForgotPasswordVC

#pragma mark - Life Cycle

#pragma mark - Public

- (void)updatePassword:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self commitPath] parameters:params completion:completion];
}

@end
