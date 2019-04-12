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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSources = @[@{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test"},
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
