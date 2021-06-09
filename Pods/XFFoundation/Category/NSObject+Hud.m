//
//  NSObject+Hud.m
//  Tao
//
//  Created by xiaoniu on 2019/6/28.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import "NSObject+Hud.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation NSObject (Hud)

+ (void)showInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = status;
    hud.margin = 10.f;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showCenterInfoWithStatus:(NSString *)status {
    if (status.length ==0) {
        return;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    hud.label.text = status;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}


@end
