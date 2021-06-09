//
//  XFCollectionCell.m
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/17.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "XFCollectionCell.h"

@implementation XFCollectionCell

- (void)configCellWithData:(id)item {
    self.data = item;
}

+ (void)registerForCollectionView:(UICollectionView *)collectionView {
    NSBundle *classBundle = [NSBundle bundleForClass:self];
    // 虽然nib名字可以与cell类名不同，但是貌似没有理由不同
    NSString * path = [classBundle pathForResource:NSStringFromClass(self) ofType:@"nib"];
    
    if (path.length > 0) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:classBundle];
        
        //注册以后，dequeueReusableCellWithIdentifier返回必定不为空，只会执行一次
        [collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(self)];
    } else {
        [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass(self)];
    }
}

+ (id)cellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    NSString *className = NSStringFromClass(self);
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    
    return cell;
}

+ (id)cellForCollectionView:(UICollectionView *)collectionView identify:(NSString *)identify indexPath:(NSIndexPath *)indexPath {
    NSString *className = NSStringFromClass(self);
    
    if (identify.length ==0) {
        identify = className;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    return cell;
}

+ (CGFloat)heightForLableWithText:(NSString *)text font:(UIFont *)font perferWidth:(float)width {
    UILabel *lable = [[UILabel alloc] init];
    
    lable.text = text;
    lable.font = font;
    lable.preferredMaxLayoutWidth = width;
    lable.numberOfLines = 0;
    
    return lable.intrinsicContentSize.height;
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

- (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view {
    view.layer.cornerRadius = cornerRadius;
    view.clipsToBounds = YES;
}

@end
