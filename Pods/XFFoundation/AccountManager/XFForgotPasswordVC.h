//
//  XFForgotPasswordVC.h
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/22.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFInputVC.h"

@interface XFForgotPasswordVC : XFInputVC

@property (copy, nonatomic) NSString *commitPath;
@property (copy, nonatomic) NSString *codePath;

/**
 更新密码

 @param params 请求参数
 */
- (void)updatePassword:(NSDictionary *)params completion:(void (^)(id))completion;

@end


