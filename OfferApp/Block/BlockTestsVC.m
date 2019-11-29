//
//  BlockTestsVC.m
//  OfferApp
//
//  Created by jmf66 on 2019/10/31.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "BlockTestsVC.h"

@interface BlockTestsVC()

@property (nonatomic, assign) int xxxx;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy) void (^myBlock)(int a);

@end

@implementation BlockTestsVC

#pragma mark - case1
//- (void)viewDidLoad {
//
//    self.myBlock = ^(int a) {
//        NSLog(@"%d",a+self.xxxx);
//    };
//
//    self.myBlock(5);
//}

#pragma mark - case2

- (void)viewDidLoad {

    self.myBlock = ^(int a) {
        NSLog(@"%@",self.name);
    };
    
    self.myBlock(5);
}


// case 1
//
//static void __BlockTestsVC__viewDidLoad_block_func_0(struct __BlockTestsVC__viewDidLoad_block_impl_0 *__cself, int a) {
//BlockTestsVC *self = __cself->self; // bound by copy
//
//      NSLog((NSString *)&__NSConstantStringImpl__var_folders_z3_bv2j0c4d5l13d5kyx_f8zkwc0000gn_T_BlockTestsVC_b84114_mi_0,a+((int (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("xxxx")));
//  }
//
// case 2
//
//static void __BlockTestsVC__viewDidLoad_block_func_0(struct __BlockTestsVC__viewDidLoad_block_impl_0 *__cself, int a) {
//BlockTestsVC *self = __cself->self; // bound by copy
//
//      NSLog((NSString *)&__NSConstantStringImpl__var_folders_z3_bv2j0c4d5l13d5kyx_f8zkwc0000gn_T_BlockTestsVC_79f12f_mi_0,a+(*(int *)((char *)self + OBJC_IVAR_$_BlockTestsVC$_xxxx)));
 // }

// case 3
//
//static void __BlockTestsVC__viewDidLoad_block_func_0(struct __BlockTestsVC__viewDidLoad_block_impl_0 *__cself, int a) {
//BlockTestsVC *self = __cself->self; // bound by copy
//
//      NSLog((NSString *)&__NSConstantStringImpl__var_folders_z3_bv2j0c4d5l13d5kyx_f8zkwc0000gn_T_BlockTestsVC_92649f_mi_0,((NSString *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("name")));
//  }

@end
