//
//  KeywordVC.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "KeywordVC.h"
#import "Son.h"

#define SuperDesc @"super关键字理解"

@interface KeywordVC ()

@end

@implementation KeywordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[
			@{ActionTypeString : @(ActionTypeNone),ActionDescString:SuperDesc,ActionValueString:SuperDesc},
			@{ActionTypeString : @(ActionTypeNone),ActionDescString:@"nil Nil NULL NSNull",ActionValueString:@"nil Nil NULL NSNull"}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    ActionType type = [dict[ActionTypeString] integerValue];
    NSString *value = dict[ActionValueString];
    
    if (type == ActionTypeNone) {
        if ([value isEqualToString:SuperDesc]) {
            [Son new];
		} else {
			[self empty];
		}
	} else {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
}


- (void)dif {
    /**
        
	 struct objc_method {
		 SEL method_name
		 char *method_types
		 IMP method_imp
	 }
     
                            
     struct objc_class;
     struct objc_object;
	 struct objc_class : objc_object;

     typedef struct objc_class *Class;
     typedef struct objc_object *id;
     
     
     typedef struct method_t *Method;
     typedef struct ivar_t *Ivar;
     typedef struct category_t *Category;
     typedef struct property_t *objc_property_t;
     
     struct method_t {
         SEL name;
         const char *types;
         MethodListIMP imp;

         struct SortBySELAddress :
             public std::binary_function<const method_t&,
                                         const method_t&, bool>
         {
             bool operator() (const method_t& lhs,
                              const method_t& rhs)
             { return lhs.name < rhs.name; }
         };
     };
     */
}

- (void)empty {
	/**
	 Nil 用来修饰类对象
	 nil 用来修饰实例对象
	 但是通过下面的判断，nil 和 Nil 没有本质区别,都是用来修饰对象的
	 */
	Class a;
	Class b;
	
	NSObject *c = Nil;
	NSObject *d;
	
	if (a == Nil) {
		NSLog(@"a = Nil");
	}
	
	if (b == nil) {
		NSLog(@"b = nil");
	}
	
	if (c == Nil) {
		NSLog(@"c = Nil");
	}
	
	if (d == Nil) {
		NSLog(@"d = Nil");
	}
		
	/**--------------------------------------*/
	/**
	 Redefinition of 'd' with a different type: 'int *' vs 'NSObject *__strong'
	 int *d = nil;
	 */
	
	/**
	 对于基本数据类型，只能用NULL,使用nil错误如上.
	 相当于nil是OC特有的
	 */
	
	int *e = Nil;
	if (e == Nil) {
		NSLog(@"e = Nil");
	}
	
	if (e == NULL) {
		NSLog(@"e = NULL");
	}
	
	/**Nil 和 nil的区别还是有的
		int *d = nil; // 报错
		int *e = Nil; // 运行正常
	 */
	
	
	NSObject *f = NULL;
	
	if (f == nil) {
		NSLog(@"f = nil");
	}
	
	if (f == NULL) {
		NSLog(@"f = NULL");
	}
	
}

@end
