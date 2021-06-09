//
//  SinglePhotoPicker.m
//  XFFoundation
//
//  Created by xiaoniu on 2018/8/31.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import "XFSinglePhotoPicker.h"

@interface XFSinglePhotoPicker() <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak  , nonatomic) UIView *targetView; 

@end

@implementation XFSinglePhotoPicker

- (void)showActionSheetInView:(UIView *)view {
    
    self.targetView = view;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:self.cancelTitle destructiveButtonTitle:nil otherButtonTitles:self.pickerPhotoTitle,self.takePhotoTitle, nil];
    
    [sheet showInView:view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSUInteger sourceType = 0;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        // 从相册选取
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePickerController.sourceType = sourceType;
        
        [[self findViewController:self.targetView] presentViewController:imagePickerController animated:YES completion:nil];

    } else if (buttonIndex == 1) {
        // 拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.sourceType = sourceType;
        
        [[self findViewController:self.targetView] presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //通过key值获取到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; 
    
    self.finishPickerBlock(image);
}

- (UIViewController *)findViewController:(UIView *)view {
    id target = view;
    
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (NSString *)cancelTitle {
    if (_cancelTitle == nil) {
        _cancelTitle = @"取消";
    }
    return _cancelTitle;
}

- (NSString *)takePhotoTitle {
    if (_takePhotoTitle == nil) {
        _takePhotoTitle = @"用相机拍照";
    }
    return _takePhotoTitle;
}

- (NSString *)pickerPhotoTitle {
    if (_pickerPhotoTitle == nil) {
        _pickerPhotoTitle = @"从相册获取";
    }
    return _pickerPhotoTitle;
}

@end
