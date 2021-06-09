//
//  XFTableViewCell.m
//  CTQProject
//
//  Created by wangxuefeng on 16/5/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFTableViewCell.h"
#import "MBProgressHUD.h"

@implementation XFTableViewCell

- (instancetype)initWithCellIdentifier:(NSString *)cellId {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

+ (void)registerForTableView:(UITableView *)tableView {
    NSBundle *classBundle = [NSBundle bundleForClass:self];
    // 虽然nib名字可以与cell类名不同，但是貌似没有理由不同
    NSString * path = [classBundle pathForResource:NSStringFromClass(self) ofType:@"nib"];

    if (path.length > 0) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:classBundle];
        
        //注册以后，dequeueReusableCellWithIdentifier返回必定不为空，只会执行一次
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass(self)];
    } else {
       
        NSLog(@"注册cell失败");
    }
}

+ (CGFloat)cellHeight {
    return 44;
}

- (void)configCellWithData:(id)item {
    self.data = item;
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *className = NSStringFromClass(self);
    
    return [self cellForTableView:tableView identify:className];
}

+ (id)cellForTableView:(UITableView *)tableView identify:(NSString *)identify {
    NSString *className = NSStringFromClass(self);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
        NSBundle *classBundle = [NSBundle bundleForClass:self];
        NSString * path = [classBundle pathForResource:className ofType:@"nib"];        
        if (path.length > 0) {
            UINib *nib = [UINib nibWithNibName:className bundle:classBundle];
            
            //注册以后，dequeueReusableCellWithIdentifier返回必定不为空，只会执行一次
            [tableView registerNib:nib forCellReuseIdentifier:identify];
            
            NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
            
            NSAssert2(([nibObjects count] > 0) &&
                      [[nibObjects firstObject] isKindOfClass:self], @"Nib '%@' does not appert a valid %@", NSStringFromClass(self), NSStringFromClass(self));
            
            cell = [nibObjects firstObject];
            cell = [tableView dequeueReusableCellWithIdentifier:identify];
        } else {
            cell = [[self alloc] initWithCellIdentifier:identify];
        }
    }
    
    return cell;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)showInfoWithStatus:(NSString *)status {
    float h = [UIScreen mainScreen].bounds.size.height;
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = status;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, h/2 - 100);
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (CGFloat)heightForLableWithText:(NSString *)text font:(UIFont *)font perferWidth:(float)width {
    UILabel *lable = [[UILabel alloc] init];
    
    lable.text = text;
    lable.font = font;
    lable.preferredMaxLayoutWidth = width;
    lable.numberOfLines = 0;
    
    return lable.intrinsicContentSize.height;
}

- (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view {
    view.layer.cornerRadius = cornerRadius;
    view.clipsToBounds = YES;
}

@end
