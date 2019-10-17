//
//  ClassVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/6.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "ClassVC.h"
#import <objc/runtime.h>

//struct my_class {
//    Class superClass,
//    
//}


@interface ClassVC ()

@end

@implementation ClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     
     类可以分为两个部分，实例（单独分配空间）和类本身（共享空间）
     
     {
        0. 记录类方法和类成员
        Class isa
        
        1. 存储变量
        objc_ivar_list *ivars
     
        2. 方法列表
        objc_method_list *methodList
     
        3. 协议列表
        objc_protocol_list *protocols
     
        4. 方法调用缓存
        objc_cache *cache,
     
        5. 名字
        const char *name
        
        6. version
        long version
     
        7. info
     
        8. 实例变量大小，用来确认分配多大的空间
        instance_size
     }
     */
    
    // yes
    [[NSObject class] isMemberOfClass:[NSObject class]];
    
    
}

@end
