//
//  XFSweetAlert.h
//  XFSweetAlert
//
//  Created by xiaoniu on 2018/12/25.
//  Copyright © 2018 com.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,XFAlertStyle) {
    XFAlertStyleNone,
    XFAlertStyleSuccess,
    XFAlertStyleError,
    XFAlertStyleWarning,
    XFAlertStyleCustomImage
};

@interface XFSweetAlert : UIViewController
 
+ (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style;

+ (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
          otherButtonTitle:(NSString *)otherButtonTitle
                    action:(void(^)(BOOL isOtherButton))action;

+ (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
               buttonColor:(UIColor *)buttonColor
          otherButtonTitle:(NSString *)otherButtonTitle
          otherButtonColor:(UIColor *)otherButtonColor
                    action:(void(^)(BOOL isOtherButton))action;

@end

