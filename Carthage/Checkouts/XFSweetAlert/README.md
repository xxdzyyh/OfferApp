# XFSweetAlert
SweetAlert with Obecjtive-C.基于 https://github.com/codestergit/SweetAlert-iOS 的swift代码转换成Objective-C。

### 使用

```
 
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


```
