//
//  XFInputVC.m
//  XFFoundation
//
//  Created by xiaoniu on 2019/1/28.
//  Copyright © 2019 wangxuefeng. All rights reserved.
//

#import "XFInputVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface XFInputVC ()

@end

@implementation XFInputVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (BOOL)validate {
    return YES;
}

@end
