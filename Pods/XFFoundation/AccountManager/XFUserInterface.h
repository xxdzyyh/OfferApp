//
//  XFUserInterface.h
//  XFFoundation
//
//  Created by wangxuefeng on 17/3/20.
//  Copyright © 2017年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XFUserInterface <NSObject>

/**
 登录后服务器分配的token，可以表明用户身份，有时效性
 */
@property (copy  , nonatomic) NSString *accessToken;

@end
