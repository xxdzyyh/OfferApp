//
//  XFRegisterVC.m
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/22.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFRegisterVC.h"

@interface XFRegisterVC ()

@end

@implementation XFRegisterVC

#pragma mark - Life Cycle


#pragma mark - Public

- (void)getCode:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self codePath] parameters:params completion:completion];
}

- (void)registerAccount:(NSDictionary *)params completion:(void (^)(id))completion {
    [self mainRequestWithPath:[self commitPath] parameters:params completion:completion];
}

@end
