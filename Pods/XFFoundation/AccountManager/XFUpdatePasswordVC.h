//
//  XFUpdatePasswordVC.h
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/24.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFInputVC.h"

@interface XFUpdatePasswordVC : XFInputVC

@property (copy, nonatomic) NSString *commitPath;

/**
 修改密码请求地址
 
 @return 提交地址
 */
- (NSString *)commitPath;

/**
 修改密码

 @param params 请求参数
 @param completion 请求结果回调
 */
- (void)updatePassword:(NSDictionary *)params completion:(void (^)(id result))completion;

@end

