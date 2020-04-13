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
@property (nonatomic, copy) void (^someBlock)(int a,BlockTestsVC *vc);

@end

@implementation BlockTestsVC

- (void)viewDidLoad {

}

#pragma mark - __block

- (void)why__block {
	/**
	 block可以自动捕获变量，但默认是以值传递（简单数据类型）或者引用传递（非简单数据类型）。因此修改无法影响到原始变量。
	 使用__block修饰变量时，block在捕获的时候会创建一个结构体，结构体中会有一个成员变量指向的地址为捕获变量的地址，操作这个
	 成员变量就可以达到修改变量的目的，因为地址是一样的，操作的是同一块内存空间。
	 */
	
	__block int a = 100;
	void (^block)(void) = ^{
		NSLog(@"%d",a);
		a++;
	};
	block();
}

#pragma mark - block 分类

- (void)blockCategory {
	// <__NSGlobalBlock__: 0x107724a60>
	NSLog(@"%@",self.myBlock);
	
	//
	int a = 0;
	void (^block)(void) = ^{
		NSLog(@"%d",a);
	};
	
	/**
	 栈 stack (iOS 栈上变量地址一般以0x7开头）
	 堆 heap  (iOS 堆上变量地址一般以0x6开头）
	 数据段
		* .bbs 未初始化静态变量或全局变量
		* .data 已初始化静态变量或全局变量
	 代码区 .text
	 */
	
	// <__NSGlobalBlock__: 0x108320aa0>
	NSLog(@"%@",^{
		NSLog(@"%@",@"全局block");
	});
	
	// <__NSMallocBlock__: 0x600002d13f90>
	NSLog(@"%@",block);
	
	// <__NSStackBlock__: 0x7ffee464def0>
	NSLog(@"%@",^{
		NSLog(@"%d",a);
	});
}

#pragma mark - 循环引用

- (void)memoryTest {
	/**
	 相互强引用
	 
	 self -> self.myBlock
	 self.myBlock -> self
	 */
//	self.myBlock = ^(int a) {
//		NSLog(@"%d---%@",a,self.name);
//	}
	
	// 解决循环应用
	
	/**
	 // 版本1，如果self释放了，在block执行的时候，其中的weakSelf也是nil，可能会导致异常
	 __weak typeof(self) weakSelf = self;
	 self.myBlock = ^(int a) {
		 NSLog(@"%d---%@",a,weakSelf.name);
	 };
	 */
	
	// 版本2
	__weak typeof(self) weakSelf = self;
	self.myBlock = ^(int a) {
		__strong typeof(self) strongSelf = weakSelf;
		NSLog(@"%d---%@",a,strongSelf.name);
		
		// strongSelf 是局部变量，出了作用于就会被自动释放，进而weakSelf也会被释放
		// weakSelf 不会在block执行的过程中变成nil
	};
	
	// 版本3 手动置空
	__block BlockTestsVC *vc = self;
	self.myBlock = ^(int a) {
		NSLog(@"%d---%@",a,vc.name);
		// 手动将vc置空
		vc = nil;
	};

	// 版本4 使用参数
	self.someBlock = ^(int a, BlockTestsVC *vc) {
		NSLog(@"%d---%@",a,vc.name);
	};
	
	// 传入的参数是self，在block里面获取的并不是self本身，而是一个引用。
	self.someBlock(5,self);
}

#pragma mark - block中self.name 和 _name

#pragma mark -- case1
//- (void)viewDidLoad {
//
//    self.myBlock = ^(int a) {
//        NSLog(@"%d",a+self.xxxx);
//    };
//
//    self.myBlock(5);
//}

#pragma mark -- case2

//- (void)viewDidLoad {
//
//    self.myBlock = ^(int a) {
//        NSLog(@"%@",self.name);
//    };
//
//    self.myBlock(5);
//}

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

#pragma mark - __block

// case1
/**
 
 原始代码
 ----------------------------------
	 int a = 100;
	 void (^block)(void) = ^{
		 NSLog(@"%d",a);
	 };
	 block();
 ----------------------------------
 
 struct __main_block_impl_0 {
   struct __block_impl impl;
   struct __main_block_desc_0* Desc;
   int a;
   __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _a, int flags=0) : a(_a) {
	 impl.isa = &_NSConcreteStackBlock;
	 impl.Flags = flags;
	 impl.FuncPtr = fp;
	 Desc = desc;
   }
 };
 static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
   // 这个位置是值引用，如果想修改这个值，会无法作用到原始的变量上，所以不允许修改，在block中无法使用a++。
   int a = __cself->a; // bound by copy

   NSLog((NSString *)&__NSConstantStringImpl__var_folders_d3_hnxvf5yd3tgddhddv48t4hs80000gn_T_main_f1baca_mi_0,a);
  }

 static struct __main_block_desc_0 {
   size_t reserved;
   size_t Block_size;
 } __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
 
 int main(int argc, const char * argv[]) {

  int a = 100;
  void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, a));
  ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
  // block->FuncPtr(block)
 
  return 0;
 }
 */

/**
 case 2
 
 -------------------------------
	 __block int a = 100;
	 void (^block)(void) = ^{
		 NSLog(@"%d",a);
	 };
	 block();
 -------------------------------

 struct __Block_byref_a_0 {
   void *__isa;
 __Block_byref_a_0 *__forwarding;
  int __flags;
  int __size;
  int a;
 };

 struct __main_block_impl_0 {
   struct __block_impl impl;
   struct __main_block_desc_0* Desc;
   __Block_byref_a_0 *a; // by ref
   __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_a_0 *_a, int flags=0) : a(_a->__forwarding) {
	 impl.isa = &_NSConcreteStackBlock;
	 impl.Flags = flags;
	 impl.FuncPtr = fp;
	 Desc = desc;
   }
 };
 static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
   __Block_byref_a_0 *a = __cself->a; // bound by ref

   NSLog((NSString *)&__NSConstantStringImpl__var_folders_d3_hnxvf5yd3tgddhddv48t4hs80000gn_T_main_836232_mi_0,(a->__forwarding->a));
  }
 static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->a, (void*)src->a, 8/BLOCK_FIELD_IS_BYREF/);}

 static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->a, 8/BLOCK_FIELD_IS_BYREF/);}

 static struct __main_block_desc_0 {
   size_t reserved;
   size_t Block_size;
   void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
   void (*dispose)(struct __main_block_impl_0*);
 } __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};
 
 int main(int argc, const char * argv[]) {

  __attribute__((__blocks__(byref))) __Block_byref_a_0 a = {(void*)0,(__Block_byref_a_0 *)&a, 0, sizeof(__Block_byref_a_0), 100};
  void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_a_0 *)&a, 570425344));
  ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);

  return 0;
 }

 
 int main(int argc, const char * argv[]) {

  __Block_byref_a_0 a = {0,&a, 0, sizeof(__Block_byref_a_0), 100};
  void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_a_0 *)&a, 570425344));
  ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);

  return 0;
 }

 */
 
 ///


@end
