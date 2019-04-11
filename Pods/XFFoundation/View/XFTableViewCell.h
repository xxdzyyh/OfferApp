//
 //  CTQProject
//
//  Created by wangxuefeng on 16/5/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFTableViewCell<NSObject>

@optional

/*! 子类实现 */
+ (float)heightForLabel:(NSString *)title;

@end

@interface XFTableViewCell : UITableViewCell<XFTableViewCell>

@property (weak  , nonatomic) id delegate;
@property (strong, nonatomic) id data;

+ (void)registerForTableView:(UITableView *)tableView;

+ (NSInteger)cellHeight;

+ (id)cellForTableView:(UITableView *)tableView;

+ (id)cellForTableView:(UITableView *)tableView identify:(NSString *)identify;

- (void)configCellWithData:(id)item;

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (void)showInfoWithStatus:(NSString *)status;

+ (float)heightForLableWithText:(NSString *)text
                           font:(UIFont *)font
                    perferWidth:(float)width;

- (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view;
@end
