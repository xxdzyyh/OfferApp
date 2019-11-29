#import "BlockTestsVC.h"

@interface BlockTestsVC()

@property (nonatomic, assign) int xxxx;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy) void (^myBlock)(int a);

@end

@implementation BlockTestsVC

- (void)viewDidLoad {

    self.myBlock = ^(int a) {
        NSLog(@"%d",a+self.xxxx);
    };
    
    self.myBlock(5);
}

@end





#ifndef _REWRITER_typedef_BlockTestsVC
#define _REWRITER_typedef_BlockTestsVC
typedef struct objc_object BlockTestsVC;
typedef struct {} _objc_exc_BlockTestsVC;
#endif

extern "C" unsigned long OBJC_IVAR_$_BlockTestsVC$_xxxx;
extern "C" unsigned long OBJC_IVAR_$_BlockTestsVC$_name;
extern "C" unsigned long OBJC_IVAR_$_BlockTestsVC$_myBlock;
struct BlockTestsVC_IMPL {
	struct NSObject_IMPL NSObject_IVARS;
	int _xxxx;
	NSString *_name;
	void (*_myBlock)(int);
};



/* @end */

#pragma clang assume_nonnull end

// @interface BlockTestsVC()

// @property (nonatomic, assign) int xxxx;
// @property (nonatomic, strong) NSString *name;

// @property (nonatomic, copy) void (^myBlock)(int a);

/* @end */


// @implementation BlockTestsVC


struct __BlockTestsVC__viewDidLoad_block_impl_0 {
  struct __block_impl impl;
  struct __BlockTestsVC__viewDidLoad_block_desc_0* Desc;
  BlockTestsVC *self;
  __BlockTestsVC__viewDidLoad_block_impl_0(void *fp, struct __BlockTestsVC__viewDidLoad_block_desc_0 *desc, BlockTestsVC *_self, int flags=0) : self(_self) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __BlockTestsVC__viewDidLoad_block_func_0(struct __BlockTestsVC__viewDidLoad_block_impl_0 *__cself, int a) {
  BlockTestsVC *self = __cself->self; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders_z3_bv2j0c4d5l13d5kyx_f8zkwc0000gn_T_BlockTestsVC_b84114_mi_0,a+((int (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("xxxx")));
    }
static void __BlockTestsVC__viewDidLoad_block_copy_0(struct __BlockTestsVC__viewDidLoad_block_impl_0*dst, struct __BlockTestsVC__viewDidLoad_block_impl_0*src) {_Block_object_assign((void*)&dst->self, (void*)src->self, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static void __BlockTestsVC__viewDidLoad_block_dispose_0(struct __BlockTestsVC__viewDidLoad_block_impl_0*src) {_Block_object_dispose((void*)src->self, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static struct __BlockTestsVC__viewDidLoad_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __BlockTestsVC__viewDidLoad_block_impl_0*, struct __BlockTestsVC__viewDidLoad_block_impl_0*);
  void (*dispose)(struct __BlockTestsVC__viewDidLoad_block_impl_0*);
} __BlockTestsVC__viewDidLoad_block_desc_0_DATA = { 0, sizeof(struct __BlockTestsVC__viewDidLoad_block_impl_0), __BlockTestsVC__viewDidLoad_block_copy_0, __BlockTestsVC__viewDidLoad_block_dispose_0};

static void _I_BlockTestsVC_viewDidLoad(BlockTestsVC * self, SEL _cmd) {

    ((void (*)(id, SEL, void (*)(int)))(void *)objc_msgSend)((id)self, sel_registerName("setMyBlock:"), ((void (*)(int))&__BlockTestsVC__viewDidLoad_block_impl_0((void *)__BlockTestsVC__viewDidLoad_block_func_0, &__BlockTestsVC__viewDidLoad_block_desc_0_DATA, self, 570425344)));

    ((void (*(*)(id, SEL))(int))(void *)objc_msgSend)((id)self, sel_registerName("myBlock"))(5);
}


static int _I_BlockTestsVC_xxxx(BlockTestsVC * self, SEL _cmd) { return (*(int *)((char *)self + OBJC_IVAR_$_BlockTestsVC$_xxxx)); }
static void _I_BlockTestsVC_setXxxx_(BlockTestsVC * self, SEL _cmd, int xxxx) { (*(int *)((char *)self + OBJC_IVAR_$_BlockTestsVC$_xxxx)) = xxxx; }

static NSString * _I_BlockTestsVC_name(BlockTestsVC * self, SEL _cmd) { return (*(NSString **)((char *)self + OBJC_IVAR_$_BlockTestsVC$_name)); }
static void _I_BlockTestsVC_setName_(BlockTestsVC * self, SEL _cmd, NSString *name) { (*(NSString **)((char *)self + OBJC_IVAR_$_BlockTestsVC$_name)) = name; }

static void(* _I_BlockTestsVC_myBlock(BlockTestsVC * self, SEL _cmd) )(int){ return (*(void (**)(int))((char *)self + OBJC_IVAR_$_BlockTestsVC$_myBlock)); }
extern "C" __declspec(dllimport) void objc_setProperty (id, SEL, long, id, bool, bool);

static void _I_BlockTestsVC_setMyBlock_(BlockTestsVC * self, SEL _cmd, void (*myBlock)(int)) { objc_setProperty (self, _cmd, __OFFSETOFIVAR__(struct BlockTestsVC, _myBlock), (id)myBlock, 0, 1); }
// @end