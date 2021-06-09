//
//  XFNavigationController.m
//  CTQProject
//
//  Created byhuang on 16/3/15.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFNavigationController.h"

@interface XFNavigationController ()<UINavigationControllerDelegate>

@end

@implementation XFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    UIImage *image = [UIImage new];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:image];
    
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isEqual:self.viewControllers[0]]) {
        // rootViewController就没有必要加返回
        
    } else {
        
        BOOL hasCustomLeftItem = viewController.navigationItem.leftBarButtonItem || viewController.navigationItem.leftBarButtonItems.count > 0;
        
        if (hasCustomLeftItem) {
            // 已经自定义了left item,就不要再添加了
            return;
        }
        
        UIButton *btnLeft = [[UIButton alloc] init];
        
        btnLeft.exclusiveTouch = YES;
        btnLeft.frame = CGRectMake(0, 0, 40, 30);
        btnLeft.tintColor = self.titleColor;
        
        if ([viewController respondsToSelector:@selector(onCustomBackItemClicked:)]) {
            [btnLeft addTarget:viewController
                        action:@selector(onCustomBackItemClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        } else {
            
            [btnLeft addTarget:self
                        action:@selector(onCustomBackItemClicked:)
              forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIImage *image = [[UIImage imageNamed:@"item-back@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [btnLeft setImage:image forState:UIControlStateNormal];
        [btnLeft setImage:image forState:UIControlStateHighlighted];
        
        UIBarButtonItem* picActionBtn =  [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
        
        viewController.navigationItem.leftBarButtonItem =  picActionBtn;
    }
}

- (void)onCustomBackItemClicked:(UIButton *)customItem {
    [self popViewControllerAnimated:YES];
}

+ (UIImage*)createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
