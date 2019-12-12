//
//  XFUpdatePassword.m
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/24.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFUpdatePasswordVC.h"

@interface XFUpdatePasswordVC ()

@end

@implementation XFUpdatePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)commitPath {
    return @"";
}

- (void)updatePassword:(NSDictionary *)params completion:(void (^)(id result))completion {
    [self mainRequestWithPath:[self commitPath] parameters:params completion:completion];
}

@end
