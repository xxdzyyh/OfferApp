//
//  DoubleDemoVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/10.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "DoubleDemoVC.h"

@interface DoubleDemoVC ()

@end

@implementation DoubleDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*！精度问题
     Q: 为什么浮点数会不准？
     A: 计算机使用二进制，有些十进制数是没有办法用二进制表示的，比如0.1
     
     浮点数内存分布
     
     double
       1位          11位              52位
     <---------><----------><---------------------->
     |  符号部分 |  指数部分  |        尾数部分         |
     
     float
        1位         8位              23位
     <-----   ><----------><---------------------->
     |  符号部分 |  指数部分  |        尾数部分         |
     */
    
    double a = 9.04;
    
    NSNumber *money = [NSNumber numberWithDouble:a];
    
    NSLog(@"%@",money);
    
    money = [NSDecimalNumber numberWithDouble:a];
    
    NSLog(@"%@",money);
    
    money = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
        
    NSLog(@"%@",money);
    
    NSNumber *number = @(a);
    NSLog(@"number=%@",number);
    
    money = [NSDecimalNumber decimalNumberWithString:number.stringValue];
    
    NSLog(@"%@",money);
    
    money = [[NSDecimalNumber alloc] initWithDouble:a];
    
    NSLog(@"%@",money);
}

@end
