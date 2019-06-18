//
//  ViewController.m
//  XFSweetAlert
//
//  Created by xiaoniu on 2018/12/25.
//  Copyright © 2018 com.learn. All rights reserved.
//

#import "ViewController.h"
#import "XFSweetAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)styleNone:(id)sender {
    [XFSweetAlert showAlertWithTitle:@"This is title" subTitle:@"I am subTitle" style:XFAlertStyleNone];
}

- (IBAction)styleSuccess:(id)sender {
    [XFSweetAlert showAlertWithTitle:@"This is title" subTitle:@"I am subTitle" style:XFAlertStyleSuccess];
}

- (IBAction)styleError:(id)sender {
    [XFSweetAlert showAlertWithTitle:@"This is title" subTitle:@"I am subTitle" style:XFAlertStyleError];
}

- (IBAction)styleWarning:(id)sender {
    [XFSweetAlert showAlertWithTitle:@"This is title" subTitle:@"I am subTitle" style:XFAlertStyleWarning];
}

- (IBAction)styleCustomImage:(id)sender {

}

@end
