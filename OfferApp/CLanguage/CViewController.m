
//
//  ViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/15.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int arr[] = {1,2,3,4,5};
    
    int length = 0;
    
    length = sizeof(arr)/sizeof(int);
    
    printf("----------------\n");
 
    // 传递的是指针，数组退化为指针
    printf("%d\n",arrayLength(arr));
    printf("%d\n",badArrayLength(&arr));

    printf("----------------\n");
    
    [self test1];
}

int arrayLength(int a[]) {
    return sizeof(a)/sizeof(int);
}

int badArrayLength(int (*a)[]) {
    return sizeof(a)/sizeof(int);
}

- (void)test1 {
    int a = 10;
    
    // 先 b 
    int b = a++;
    
    // 11
    printf("%d\n",a);
    
    int c = ++a;
    
    // 12
    printf("%d\n",a);
    
    // 10
    printf("%d\n",b);
    
    // 12
    printf("%d\n",c);
}

@end
