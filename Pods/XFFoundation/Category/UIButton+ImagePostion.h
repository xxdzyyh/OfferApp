//
//  UIButton+ImagePostion.h
//  Tao
//
//  Created by xiaoniu on 2019/6/24.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ImagePostion) {
    ImagePostionTop,/*< 图片在上面 */
    ImagePostionLeft,/*< 图片在左边 */
    ImagePostionRight,/*< 图片在右边 */
    ImagePostionBottom/*< 图片在下面 */
};

@interface UIButton (ImagePostion)

- (void)setImagePostion:(ImagePostion)postion padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
