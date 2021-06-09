//
//  XFCollectionCell.h
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/17.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFCollectionCell : UICollectionViewCell

@property (weak  , nonatomic) id delegate;
@property (strong, nonatomic) id data;

+ (void)registerForCollectionView:(UICollectionView *)collectionView;

+ (id)cellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
+ (id)cellForCollectionView:(UICollectionView *)collectionView identify:(NSString *)identify indexPath:(NSIndexPath *)indexPath;

- (void)configCellWithData:(id)item;

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (CGFloat)heightForLableWithText:(NSString *)text
                             font:(UIFont *)font
                      perferWidth:(float)width;

- (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view;

@end
