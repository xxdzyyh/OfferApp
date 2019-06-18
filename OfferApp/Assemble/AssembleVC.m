//
//  AssembleVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/16.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "AssembleVC.h"

@interface AssembleVC ()

@end

@implementation AssembleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSources = @[@{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test1"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test2"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test3"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test4"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test5"},
                         @{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test6"}];
    
    //    id cls = [RPerson class];
    //    void *obj = &cls;
    //    [(__bridge id)obj sayHello];
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

#pragma mark ------


- (void)test1 {
    int a = 5;
}

- (void)test2 {
    int a = 5;
    int b = 1;
    int c = 11;
}

- (void)test3 {
    int a = 5;
    int b = 1;
    
    int c = a + b;
    int d = a - b;
    int e = a * b;
    int f = a / b; 
}

- (void)test4 {
    int a = 0;
    int b = 0;
    
    if (a > 0) {
        b = 2;
    } else {
        b = 1;
    }
}

- (void)test5 {
    int a = 7;
    
    NSLog(@"%d",a);
}

- (void)test6 {
    int a = 1;
    int b = 2;

    NSLog(@"%d",a+b);
}
@end
