//
//  UIButton+ImagePostion.m
//  Tao
//
//  Created by xiaoniu on 2019/6/24.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import "UIButton+ImagePostion.h"

@implementation UIButton (ImagePostion)

- (void)setImagePostion:(ImagePostion)postion padding:(CGFloat)padding {
    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGSize titleSize = self.titleLabel.intrinsicContentSize;
    
    switch (postion) {
        case ImagePostionTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height+padding,-imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height-padding, 0, 0, -titleSize.width);
        }
            break;
        case ImagePostionBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageSize.height-padding/2,-imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleSize.height+padding/2, 0, 0, -titleSize.width);
        }
            break;
        case ImagePostionLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, padding, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding, 0, 0);
        }
            break;
        case ImagePostionRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width-padding/2, 0, imageSize.width+padding/2);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+padding, 0, -titleSize.width-padding);
        }
    }
}

@end
