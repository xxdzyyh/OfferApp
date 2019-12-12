//
//  XFRegisterVC.h
//  ShangRenQi_iOS
//
//  Created by xiaoniu on 2019/1/22.
//  Copyright © 2019 com.shangrenqi. All rights reserved.
//

#import "XFInputVC.h"

@interface XFRegisterVC : XFInputVC

@property (copy, nonatomic) NSString *commitPath;
@property (copy, nonatomic) NSString *codePath;

- (void)getCode:(NSDictionary *)params completion:(void (^)(id))completion;
- (void)registerAccount:(NSDictionary *)params completion:(void (^)(id))completion;

@end


