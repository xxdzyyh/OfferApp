//
//  SinglePhotoPicker.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/8/31.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFSinglePhotoPicker : NSObject

@property (strong, nonatomic) NSString *cancelTitle;
@property (strong, nonatomic) NSString *takePhotoTitle;
@property (strong, nonatomic) NSString *pickerPhotoTitle;

- (void)showActionSheetInView:(UIView *)view;

@property (strong, nonatomic) void(^finishPickerBlock)(UIImage *image);

@end
