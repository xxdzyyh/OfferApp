//
//  ViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/11.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "ViewController.h"
#import "Son.h"
#import "MyViewController.h"

@interface ViewController () {
    MyViewController *_myVC;    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib
    self.dataSources = @[@{@"type" : @(ActionTypeController),@"value" : @"NotificationVC",@"desc":@"通知"},
                         @{@"type" : @(ActionTypeController),@"value" : @"AssembleVC",@"desc":@"汇编"},
                         @{@"type" : @(ActionTypeController),@"value" : @"CarthageVC",@"desc":@"carthage"},
                         @{@"type" : @(ActionTypeController),@"value" : @"CViewController",@"desc":@"C语言相关"},
                         @{@"type" : @(ActionTypeController),@"value" : @"UrlVC",@"desc":@"url相关"},
                         @{@"type" : @(ActionTypeController),@"value" : @"WebViewController",@"desc":@"WKWebView"},
                         @{@"type" : @(ActionTypeController),@"value" : @"MultiThreadVC",@"desc":@"多线程"},
                         @{@"type" : @(ActionTypeController),@"value" : @"KeywordVC",@"desc":@"关键字"},
                         @{@"type" : @(ActionTypeController),@"value" : @"Sub",@"desc":@"关键字"},
                         @{@"type" : @(ActionTypeNone),@"value":@"showOverLay",@"desc":@"UIDebuggingInformationOverlay"},
                         @{@"type" : @(ActionTypeNone),@"value":@"alloc",@"desc":@"only alloc"},
                         @{@"type" : @(ActionTypeController),@"value":@"GroupViewController",@"desc":@"GCD Group"},
                         @{@"type" : @(ActionTypeController),@"value":@"RunloopVC",@"desc":@"Runloop"},
                         @{@"type" : @(ActionTypeController),@"value":@"SMClsCallViewController",@"desc":@"耗时统计"},
                         @{@"type" : @(ActionTypeController),@"value":@"CrashVC",@"desc":@"常见崩溃"},
                         @{@"type" : @(ActionTypeController),@"value":@"RuntimeVC",@"desc":@"运行时"},
                         @{@"type" : @(ActionTypeController),@"value":@"DoubleDemoVC",@"desc":@"double"},
                         @{@"type" : @(ActionTypeController),@"value":@"SDWebImageTestVC",@"desc":@"渐进式加载原理"}];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"ViewController viewWillAppear");
}

- (void)showOverLay {
    NSLog(@"XXXX");
#if DEBUG
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    NSUInteger type = [dict[@"type"] integerValue];
    
    if (type != ActionTypeNone) {
        
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        
    } else {
        NSString *value = dict[@"value"];
        
        if ([value isEqualToString:@"showOverLay"]) {
            [self showOverLay];
        } else if ([value isEqualToString:@"alloc"]) {
            [self onlyAlloc];
        }
    }
}

- (void)onlyAlloc {
    
    /**
    // 只调用alloc不调用init,并不影响viewController的声明周期
    
    // alloc分配了对象的内存
    // init NSObject默认实现是返回 alloc 创建的对象，没有其他的操作
        
     id _objc_rootInit(id obj) {
         // In practice, it will be hard to rely on this function.
         // Many classes do not properly chain -init calls.
         return obj;
     }
     */
    
    _myVC = [MyViewController alloc];
    
    
    
    [self.navigationController pushViewController:_myVC animated:YES];
}

@end
