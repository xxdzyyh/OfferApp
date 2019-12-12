//
//  XFConfig.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/11/5.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJRefresh/MJRefresh.h>
#import "SynthesizeSingleton.h"
/**
 全局配置的入口，定义默认的行为
 */
@interface XFConfig : NSObject

@property (strong, nonatomic) MJRefreshHeader *refreshHeader;
@property (strong, nonatomic) MJRefreshFooter *refreshFooter;

DECLARE_SINGLETON_FOR_CLASS(XFConfig);

@end
