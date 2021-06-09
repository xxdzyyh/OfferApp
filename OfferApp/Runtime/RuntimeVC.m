//
//  RuntimeVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/9.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "RuntimeVC.h"
#import "RPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>


/**
 id objc_msgSend(id self,SEL _cmd,...){
	 Class c = objc_getClass(self);//找到类
	 IMP imp = cache_lookup(c,_cmd);//在缓存方法列表中查找imp
	 if(!imp){
		 imp = class_getMethodImplementation(c, _cmd);//在方法列表中查找imp
	 }
	 return imp(self,_cmd,...);返回方法实现
 }
 */

/**
 参考资料
 
 1. https://blog.sunnyxx.com/2014/11/06/runtime-nuts/
 2. http://www.cocoachina.com/ios/20190408/26746.html
 */

@interface NSObject (Sark)

+ (void)foo;

@end

@implementation NSObject (Sark)

// 不实现下面的方法，也可以调用[NSObject foo]
// 1. NSObject MetaClass 找不到foo
// 2. NSObject MetaClass Super Class 去找，NSObject MetaClass Super Class = NSObject Class,所以找到了实例方法 - foo
//+ (void)foo {
//    NSLog(@"IMP: +[NSObject (Sark) foo]");
//}

- (void)foo {
    NSLog(@"IMP: -[NSObject (Sark) foo]");
}

@end

@interface RuntimeVC ()

@end

@implementation RuntimeVC

+ (void)initialize {
	[super initialize];

	NSLog(@"initialize excute");
}

+ (void)load {
	NSLog(@"+load excute");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // MethodExchangeVC
    self.dataSources = @[@{ActionTypeString:@(ActionTypeController),ActionValueString:@"MethodExchangeVC"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test1"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"testNSObject"}];
    
//    id cls = [RPerson class];
//    void *obj = &cls;
//    [(__bridge id)obj sayHello];
}

- (void)test {

    // 没有下面这个会crash
    id oj = [NSObject new];
    
    id cls = [RPerson class];
    void *obj = &cls;
    [(__bridge id)obj sayHello];
    
//    2019-04-15 13:55:49.603090+0800 OfferApp[48202:1882299] 0x7ffee73f3aa8
//    2019-04-15 13:55:49.603254+0800 OfferApp[48202:1882299] 0x7ffee73f3aa0
//    2019-04-15 13:55:49.603350+0800 OfferApp[48202:1882299] 0x7ffee73f3a98

    NSLog(@"%p",&oj);
    NSLog(@"%p",&cls);
    NSLog(@"%p",&obj);

//    2019-04-15 13:55:49.603438+0800 OfferApp[48202:1882299] 0x60000055c2e0
//    2019-04-15 13:55:49.603570+0800 OfferApp[48202:1882299] 0x108a6cc68
//    2019-04-15 13:55:49.603664+0800 OfferApp[48202:1882299] 0x7ffee73f3aa0
    NSLog(@"%p",oj);
    NSLog(@"%p",cls);
    NSLog(@"%p",obj);


    /**
     RPerson *obj = [RPerson new];
     
     [obj sayHello];
     */
}

- (void)test1 {
    id obj = [RPerson new];
    
    [obj sayHello];
}

- (void)testNSObject {
    /**
     类方法和实例方法没有本质的区别，都是通过objc_msgSender去调用，关键看怎么查找。
     
     调用实例方法时，通过实例的isa找到对应的Class，在class保存的方法列表里进行查找
     调用类方法时，通过类的isa找到对应的metaClass,在metaClass保存的方法列表里进行查找
     
     对于NSObject实例而言,class 和 metaClass 不同，但是 meteClass 的 superClass 指向了 NSObject class，也就是在NSObject里面的所有方法，NSObject的元类也都拥有。
     */
    
    NSObject *obj = [NSObject new];
    
    // 0x6000000d4a20
    NSLog(@"%p",obj);
    
    Class cls = object_getClass(obj);
    
    // 0x10ae53ec8
    NSLog(@"%p",cls);
    
    Class metaClass = object_getClass(cls);
    
    // 0x10ae53e78
    NSLog(@"%p",metaClass);
    
    [self printAllMethod:[NSObject new]];
    [self printAllMethod:[NSObject class]];
    
    // 没有实现类方法，实际调用了实例方法
    [NSObject foo];
    [[NSObject new] foo];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * item = self.dataSources[indexPath.row];
    int type = [item[ActionTypeString] intValue];
    NSString *methodName = item[ActionValueString];
    
    if (type == ActionTypeNone) {
        [self performSelector:NSSelectorFromString(methodName)];
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - Helper

- (void)printAllMethod:(id)obj {
    unsigned int count;
    Method *methods = class_copyMethodList([obj class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        NSLog(@"%@",name);
    }
    NSLog(@"------------------------------");
}

@end
