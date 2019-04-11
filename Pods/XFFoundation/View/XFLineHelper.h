//
//  XFLineHelper.h
//  CTQProject
//
//  Created by wangxuefeng on 16/5/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFLineHelper : NSObject

/*!  * @brief 添加顶部线条
 * @param left 左边距
 * @param right 右边距
 */
+ (void)addTopLineToView:(UIView *)view offsetLeft:(CGFloat)left offsetRight:(CGFloat)right;

/*!  * @brief 添加顶部线条
 * @param left 左边距
 * @param right 右边距
 */
+ (void)addTopLineToView:(UIView *)view
              offsetLeft:(CGFloat)left
             offsetRight:(CGFloat)right
                   color:(UIColor *)color;

/*!  * @brief 添加底部线条
 * @param left 左边距
 * @param right 右边距
 */
+ (void)addBottomLineToView:(UIView *)view offsetLeft:(CGFloat)left offsetRight:(CGFloat)y;

+ (void)add15LeftBottomLineToView:(UIView *)view;

+ (void)add15BottomLineToView:(UIView *)view;

/*!  * @brief 添加底部线条
 * @param left 左边距
 * @param right 右边距
 */
+ (void)addBottomLineToView:(UIView *)view
                 offsetLeft:(CGFloat)left
                offsetRight:(CGFloat)y
                      color:(UIColor *)color;

/*!  * @brief 添加顶部线条 */
+ (void)addTopLineToView:(UIView *)view;

/*!  * @brief 添加底部线条 */
+ (void)addBottomLineToView:(UIView *)view;

/*!  * @brief 删除顶部线条 */
+ (void)delTopLine:(UIView *)view;

/*!  * @brief 删除底部线条 */
+ (void)delBottomLine:(UIView *)view;

/*!  * @brief 删除顶部和底部线条 */
+ (void)delTopAndBottomLine:(UIView *)view;

+ (void)addLeftLineInView:(UIView *)view;

+ (void)delLeftLine:(UIView *)view;

+ (void)addLeftLineInView:(UIView *)view
               offsetLeft:(CGFloat)x
              offsetRight:(CGFloat)y
                    color:(UIColor *)color;

@end
