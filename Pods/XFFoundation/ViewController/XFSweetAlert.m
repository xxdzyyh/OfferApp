//
//  XFSweetAlert.m
//  XFSweetAlert
//
//  Created by xiaoniu on 2018/12/25.
//  Copyright © 2018 com.learn. All rights reserved.
//

#import "XFSweetAlert.h"

@interface UIColor (RGB)

+ (UIColor *)colorFromRGB:(uint)rgbValue;

@end

@implementation UIColor (RGB)

+ (UIColor *)colorFromRGB:(uint)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 
                           green:((rgbValue & 0x00FF00) >> 8)/255.0 
                            blue:(rgbValue & 0x0000FF)/255.0 
                           alpha:1.0];
}

@end

@interface AnimatabelView : UIView

- (void)animate;

@end

@implementation AnimatabelView

- (void)animate {
    NSLog(@"Should overide by subclasss");
}

@end

@interface InfoAnimatedView : AnimatabelView

@property (strong, nonatomic) CAShapeLayer *circleLayer;
@property (strong, nonatomic) CAShapeLayer *crossPathLayer;

@end

@implementation InfoAnimatedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayers];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupLayers];
}

- (UIBezierPath *)outlineCircle {
    UIBezierPath *path = [UIBezierPath new];
    
    CGFloat startAngle = 0/180.0*M_PI;
    CGFloat endAngle = 360/180.0*M_PI;
    CGFloat width = self.frame.size.width;
    CGFloat factor = width/1.5;
    
    [path addArcWithCenter:CGPointMake(width/2.0, width/2.0) 
                    radius:width/2.0 
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:false];
    
    [path moveToPoint:CGPointMake(width/2.0, 15.0)];
    [path addLineToPoint:CGPointMake(width/2.0, factor)];
    [path moveToPoint:CGPointMake(width/2.0, factor+10.0)];
    [path addArcWithCenter:CGPointMake(width/2.0, factor+10.0)
                    radius:1.0
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:true];
    
    return path;
}

- (void)setupLayers {
    if (_circleLayer == nil) {
        _circleLayer = [CAShapeLayer layer];
    }
    
    _circleLayer.path = [self outlineCircle].CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor colorFromRGB:0xF8D486].CGColor;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineWidth = 4;
    _circleLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _circleLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    
    [self.layer addSublayer:_circleLayer];
}

- (void)animate {
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
   
    colorAnimation.duration = 1.0;
    colorAnimation.repeatCount = HUGE;
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    colorAnimation.autoreverses = true;
    colorAnimation.fromValue = [UIColor colorFromRGB:0xF7D58B];
    colorAnimation.toValue =  [UIColor colorFromRGB:0xF2A665];
    
    [self.circleLayer addAnimation:colorAnimation forKey:@"strokeColor"];
}

- (UIBezierPath *)path {
    UIBezierPath *path = [UIBezierPath new];
    
    CGFloat startAngle = 60/180.0*M_PI;
    CGFloat endAngle = 200/180.0*M_PI;
    CGFloat width = self.frame.size.width;
    
    [path addArcWithCenter:CGPointMake(width/2.0, width/2.0) 
                    radius:width/2.0 
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:false];
    
    [path addLineToPoint:CGPointMake(36.0-10.0, 60.0-10.0)];
    [path addLineToPoint:CGPointMake(85.0-20.0, 30.0-20.0)];
    
    return path;
}

@end

@interface SuccessAnimatedView : AnimatabelView

@property (strong, nonatomic) CAShapeLayer *circleLayer;
@property (strong, nonatomic) CAShapeLayer *outlineLayer;

@end

@implementation SuccessAnimatedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _outlineLayer = [CAShapeLayer layer];
        _circleLayer = [CAShapeLayer layer];
        
        [self setupLayers];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupLayers];
}

- (UIBezierPath *)outlineCircle {
    UIBezierPath *path = [UIBezierPath new];
    
    CGFloat startAngle = 0.0/180.0*M_PI;
    CGFloat endAngle = 360.0/180.0*M_PI;
    CGFloat width = self.frame.size.width;
    
    [path addArcWithCenter:CGPointMake(width/2.0, self.frame.size.height/2.0) 
                    radius:width/2.0 
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:false];    
    return path;
}

- (UIBezierPath *)path {
    UIBezierPath *path = [UIBezierPath new];
    
    CGFloat startAngle = 60.0/180.0*M_PI;
    CGFloat endAngle = 200.0/180.0*M_PI;
    CGFloat width = self.frame.size.width;
    
    [path addArcWithCenter:CGPointMake(width/2.0, self.frame.size.height/2.0) 
                    radius:width/2.0 
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:false];
    
    [path addLineToPoint:CGPointMake(36.0-10.0, 60.0-10.0)];
    [path addLineToPoint:CGPointMake(85.0-20.0, 30.0-20.0)];
    
    return path;
}

- (void)setupLayers {
    _outlineLayer.position = CGPointMake(0, 0);
    _outlineLayer.path =  [self outlineCircle].CGPath;
    _outlineLayer.fillColor = [UIColor clearColor].CGColor;
    _outlineLayer.strokeColor = [UIColor colorWithRed:150.0/255.0 green:216.0/255.0 blue:115.0/255.0 alpha:1].CGColor;
    _outlineLayer.lineCap = kCALineCapRound;
    _outlineLayer.lineWidth = 4;
    _outlineLayer.opacity = 0.1;
    
    [self.layer addSublayer:_outlineLayer];
    
    _circleLayer.position = CGPointMake(0, 0);
    _circleLayer.path = [self path].CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor colorWithRed:150.0/255.0 green:216.0/255.0 blue:115.0/255.0 alpha:1].CGColor;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineWidth = 4;
    _circleLayer.actions = @{
                                @"strokeStart":[NSNull null],
                                @"strokeEnd":[NSNull null],
                                @"transform":[NSNull null],
                            };
    
    [self.layer addSublayer:_circleLayer];
}

- (void)animate {
    
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    CGFloat factor = 0.045;
    
    strokeEnd.fromValue = @0.0;
    strokeEnd.toValue = @0.93;
    strokeEnd.duration = 10.0*factor;
    strokeEnd.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.2];
    
    strokeStart.fromValue = @0.0;
    strokeStart.toValue = @0.68;
    strokeStart.duration =  7.0*factor;
    strokeStart.beginTime =  CACurrentMediaTime() + 3.0*factor;
    strokeStart.fillMode = kCAFillModeBackwards;
    strokeStart.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.2];
    
    self.circleLayer.strokeStart = 0.68;
    self.circleLayer.strokeEnd = 0.93;
    
    [self.circleLayer addAnimation:strokeEnd forKey:@"strokeEnd"];
    [self.circleLayer addAnimation:strokeStart forKey:@"strokeStart"];
}

@end

@interface CancelAnimatedView : AnimatabelView

@property (strong, nonatomic) CAShapeLayer *circleLayer;
@property (strong, nonatomic) CAShapeLayer *crossPathLayer;

@end

@implementation CancelAnimatedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _circleLayer = [CAShapeLayer layer];
        _crossPathLayer = [CAShapeLayer layer];
        
        [self setupLayers];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupLayers];
}

- (void)setupLayers {

    _circleLayer.path = [self outlineCircle].CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor colorFromRGB:0xF27474].CGColor;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.lineWidth = 4;
    _circleLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _circleLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);

    [self.layer addSublayer:_circleLayer];
    
    _crossPathLayer.path =  [self crossPath].CGPath;
    _crossPathLayer.fillColor = [UIColor clearColor].CGColor;
    _crossPathLayer.strokeColor = [UIColor colorFromRGB:0xF27474].CGColor;
    _crossPathLayer.lineCap = kCALineCapRound;
    _crossPathLayer.lineWidth = 4;
    _crossPathLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _crossPathLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    
    [self.layer addSublayer:_crossPathLayer];
}

- (void)animate {
    CATransform3D t = CATransform3DIdentity;
    
    t.m34 = 1.0/-500.0;
    t = CATransform3DRotate(t, 90.0*M_PI/180.0, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    
    t2.m34 = 1.0/-500.0;
    t2 = CATransform3DRotate(t2, -M_PI, 1, 0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.3;
    animation.fromValue = [NSValue valueWithCATransform3D:t];
    animation.toValue = [NSValue valueWithCATransform3D:t2];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.circleLayer addAnimation:animation forKey:@"transform"];
    
    CATransform3D scale = CATransform3DIdentity;
    
    scale = CATransform3DScale(scale, 0.3, 0.3, 0);
    
    CABasicAnimation *crossAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    crossAnimation.duration = 0.3;
    crossAnimation.beginTime = CACurrentMediaTime() + 0.3;
    crossAnimation.fromValue = [NSValue valueWithCATransform3D:scale];
    crossAnimation.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :0.8 :0.7 :2.0];
    crossAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    [self.crossPathLayer addAnimation:crossAnimation forKey:@"scale"];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.beginTime = CACurrentMediaTime() + 0.3;
    fadeInAnimation.fromValue = @0.3;
    fadeInAnimation.toValue = @1.0;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    
    [self.crossPathLayer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (UIBezierPath *)outlineCircle {
    UIBezierPath *path = [UIBezierPath new];
    
    CGFloat startAngle = 0/180.0*M_PI;
    CGFloat endAngle = 360/180.0*M_PI;
    CGFloat width = self.frame.size.width;
    
    [path addArcWithCenter:CGPointMake(width/2.0, width/2.0) 
                    radius:width/2.0 
                startAngle:startAngle 
                  endAngle:endAngle 
                 clockwise:false];
    return path;
}

- (UIBezierPath *)crossPath {
    UIBezierPath *path = [UIBezierPath new];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat factor = width/5.0;
 
    [path moveToPoint:CGPointMake(height/2.0-factor, height/2.0-factor)];
    [path addLineToPoint:CGPointMake(height/2.0+factor, height/2.0+factor)];
    [path moveToPoint:CGPointMake(height/2.0+factor, height/2.0-factor)];
    [path addLineToPoint:CGPointMake(height/2.0-factor, height/2.0+factor)];
    
    return path;
}

@end

static const CGFloat kBakcgroundTansperancy = 0.7;
static const CGFloat kHeightMargin = 10.0;
static const CGFloat KTopMargin = 20.0;
static const CGFloat kWidthMargin = 10.0;
static const CGFloat kAnimatedViewHeight = 70.0;
static const CGFloat kMaxHeight = 300.0;
static const CGFloat kContentWidth = 300.0;
static const CGFloat kTitleHeight = 30.0;

static BOOL shouldNotAnimate = NO;

@interface XFSweetAlert ()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextView *subTitleTextView;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) AnimatabelView *animatedView;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) CGFloat textViewHeight;
@property (strong, nonatomic) XFSweetAlert *strongSelf;

@property (strong, nonatomic) void(^useAction)(BOOL isOtherButton);

@end

@implementation XFSweetAlert

#pragma mark - Initialize Methods

+ (instancetype)sweetAlert {
    XFSweetAlert *alert = [XFSweetAlert new];
    
    return alert;
}

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.frame = UIScreen.mainScreen.bounds;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:kBakcgroundTansperancy];
        
        _textViewHeight = 90.0;
        _strongSelf = self;
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGSize sz = [UIScreen mainScreen].bounds.size;
    NSString *sver = [UIDevice currentDevice].systemVersion;
    CGFloat ver = [sver floatValue];
    
    if (ver < 8.0) {
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            CGSize ssz = sz;
            sz = CGSizeMake(ssz.height, ssz.width);
        }
    }
    [self resizeAndRelayout];
}

- (void)dealloc {
    NSLog(@"XFSweetAlert dealloc");
}

#pragma mark - Private

- (void)setup {
    [self.view addSubview:self.contentView];
}

- (void)resizeAndRelayout {
    CGRect mainScreenBounds = [UIScreen mainScreen].bounds;
    CGFloat x = kWidthMargin;
    CGFloat y = KTopMargin;
    CGFloat width = kContentWidth - (kWidthMargin*2);
    
    if (_animatedView != nil) {
        _animatedView.frame = CGRectMake((kContentWidth-kAnimatedViewHeight)/2.0, y, kAnimatedViewHeight, kAnimatedViewHeight);
        [_contentView addSubview:_animatedView];
        y += kAnimatedViewHeight + kHeightMargin;
    }
    
    if (_imageView != nil) {
        _imageView.frame = CGRectMake((kContentWidth-kAnimatedViewHeight)/2.0, y, kAnimatedViewHeight, kAnimatedViewHeight);
        [_contentView addSubview:_imageView];
        y += _imageView.frame.size.height + kHeightMargin;
    }
    
    if (self.titleLabel.text.length > 0) {
        self.titleLabel.frame = CGRectMake(x, y, width, kTitleHeight);
        [_contentView addSubview:self.titleLabel];
        y += kTitleHeight + kHeightMargin;
    }
    
    if (self.subTitleTextView.text.length > 0) {
        NSString *subtitleString = self.subTitleTextView.text;
        CGRect rect = [subtitleString boundingRectWithSize:CGSizeMake(width, 0.0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:self.subTitleTextView.font} 
                                                   context:nil];
        _textViewHeight = ceil(rect.size.height) + 10.0;
        self.subTitleTextView.frame = CGRectMake(x, y, width, _textViewHeight);
        [_contentView addSubview:self.subTitleTextView];
        y += _textViewHeight + kHeightMargin;
    }
    
    NSMutableArray *buttonRect = [NSMutableArray array];
    
    for (UIButton *button in self.buttons) {
        NSString *string = [button currentTitle];
        CGRect temp = [string boundingRectWithSize:CGSizeMake(width, 0.0) 
                                           options:NSStringDrawingUsesLineFragmentOrigin 
                                        attributes:@{NSFontAttributeName:button.titleLabel.font}
                                           context:nil];
        [buttonRect addObject:[NSValue valueWithCGRect:temp]];
    }
    
    CGFloat totalWidth = 0.0;
    
    if (self.buttons.count == 2) {
        CGRect tempOne = [buttonRect[0] CGRectValue];
        CGRect tempTwo = [buttonRect[1] CGRectValue];
        
        totalWidth = tempOne.size.width + tempTwo.size.width + kWidthMargin + 40.0;
    } else {
        CGRect tempOne = [buttonRect[0] CGRectValue];
        
        totalWidth = tempOne.size.width + 20.0;
    }
    
    y += kHeightMargin;
    
    CGFloat buttonX = (kContentWidth - totalWidth)/2.0;
    
    for (int i=0;i<self.buttons.count;i++) {
        CGRect temp = [buttonRect[i] CGRectValue];
        UIButton *button = self.buttons[i];
        
        button.frame = CGRectMake(buttonX, y, temp.size.width+20.0, temp.size.height+10.0);
        button.layer.cornerRadius = 5.0;
        [button addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
        buttonX = button.frame.origin.x+ kWidthMargin + temp.size.width + 20.0;
        [_contentView addSubview:button];   
    }
    CGRect rectZero = [buttonRect[0] CGRectValue];
    
    y += kHeightMargin + rectZero.size.height + 10.0;
    
    if (y > kMaxHeight) {
        CGFloat diff = y - kMaxHeight;
        CGRect sFrame = self.subTitleTextView.frame;
        self.subTitleTextView.frame = CGRectMake(sFrame.origin.x, sFrame.origin.y, sFrame.size.width, sFrame.size.height - diff);
        
        for (UIButton *button in self.buttons) {
            CGRect bFrame = button.frame;
            
            button.frame = CGRectMake(bFrame.origin.x, bFrame.origin.y - diff, bFrame.size.width, bFrame.size.height);
        }
        
        y = kMaxHeight;
    }
    
    _contentView.frame = CGRectMake((mainScreenBounds.size.width-kContentWidth)/2.0, (mainScreenBounds.size.height-y)/2.0, kContentWidth, y);
}

- (void)pressed:(UIButton *)sender {
    [self closeAlert:sender.tag];
}

- (void)closeAlert:(NSUInteger)buttonIndex {
    if (self.useAction != nil) {
        BOOL isOtherButton = (buttonIndex == 1 ? true : false);
        
        shouldNotAnimate = YES;
        _useAction(isOtherButton);
        shouldNotAnimate = NO;
    }
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self cleanUpAlert];
        self.strongSelf = nil;
    }];
        
}

- (void)cleanUpAlert {
    if (self.animatedView != nil) {
        [self.animatedView removeFromSuperview];
        self.animatedView = nil;
    }
    [self.contentView removeFromSuperview];
    self.contentView = [UIView new];
}

- (void)animateAlert {
    self.view.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 1.0;
    }];
    
    CGAffineTransform previousTransform = self.contentView.transform;
    
    self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0);   
    
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
           self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0); 
        } completion:^(BOOL finished) {
        
            [UIView animateWithDuration:0.1 animations:^{
                self.contentView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                if (self.animatedView != nil) {
                    [self.animatedView animate];
                }
            } completion:^(BOOL finished) {
                self.contentView.transform = previousTransform; 
            }];
        }];
    }];
}

#pragma mark - Public

+ (void)showAlertWithTitle:(NSString *)title 
                  subTitle:(NSString *)subTitle 
                     style:(XFAlertStyle)style {
    [[XFSweetAlert sweetAlert] showAlertWithTitle:title subTitle:subTitle style:style];
}

+ (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
          otherButtonTitle:(NSString *)otherButtonTitle
                    action:(void(^)(BOOL isOtherButton))action {
    [[XFSweetAlert sweetAlert] showAlertWithTitle:title
                                         subTitle:subTitle 
                                            style:style 
                                      buttonTitle:buttonTitle 
                                 otherButtonTitle:otherButtonTitle 
                                           action:action];
}

+ (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
               buttonColor:(UIColor *)buttonColor
          otherButtonTitle:(NSString *)otherButtonTitle
          otherButtonColor:(UIColor *)otherButtonColor
                    action:(void(^)(BOOL isOtherButton))action {
    [[XFSweetAlert sweetAlert] showAlertWithTitle:title
                                         subTitle:subTitle 
                                            style:style 
                                      buttonTitle:buttonTitle 
                                      buttonColor:buttonColor
                                 otherButtonTitle:otherButtonTitle 
                                 otherButtonColor:otherButtonColor
                                           action:action];
}

- (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style {
    [self showAlertWithTitle:title subTitle:subTitle style:style buttonTitle:@"OK" otherButtonTitle:nil action:nil];
}

- (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
          otherButtonTitle:(NSString *)otherButtonTitle
                    action:(void(^)(BOOL isOtherButton))action { 
    [self showAlertWithTitle:title 
                    subTitle:subTitle 
                       style:style
                 buttonTitle:buttonTitle 
                 buttonColor:[UIColor colorFromRGB:0xAEDEF4] 
            otherButtonTitle:otherButtonTitle 
            otherButtonColor:[UIColor redColor]
                      action:action];
}

- (void)showAlertWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                     style:(XFAlertStyle)style 
               buttonTitle:(NSString *)buttonTitle
               buttonColor:(UIColor *)buttonColor
          otherButtonTitle:(NSString *)otherButtonTitle
          otherButtonColor:(UIColor *)otherButtonColor
                    action:(void(^)(BOOL isOtherButton))action {
    self.useAction = action;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self.view];
    [window bringSubviewToFront:self.view];
    self.view.frame = window.bounds;
    [self setup];
    
    switch (style) {
        case XFAlertStyleSuccess:
            self.animatedView = [SuccessAnimatedView new];
            break;
        case XFAlertStyleError: {
            self.animatedView = [CancelAnimatedView new];
        }
            break;
        case XFAlertStyleWarning: {
            self.animatedView = [InfoAnimatedView new];
        }
            break;
            
        case XFAlertStyleNone: {
            self.animatedView = nil;
        }
             break;
        default:
            
            break;
    }
    
    self.titleLabel.text = title;
    if (subTitle.length > 0) {
        self.subTitleTextView.text = subTitle;
    }
    
    self.buttons = [NSMutableArray array];
    
    if (buttonTitle.length > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.backgroundColor = buttonColor;
        button.tag = 0;
        
        [self.buttons addObject:button];
    } 
    
    if (otherButtonTitle.length > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:otherButtonTitle forState:UIControlStateNormal];
        button.backgroundColor = otherButtonColor;
        button.tag = 1;
        
        [self.buttons addObject:button];
    }
    
    [self resizeAndRelayout];
    if (shouldNotAnimate == true) {
        if (self.animatedView != nil) {
            [self.animatedView animate];
        }
    } else {
        [self animateAlert];
    }
}

#pragma mark - Setter & Getter

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
        
        _contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _contentView.layer.cornerRadius = 5.0;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderWidth = 0.5;
        
        [_contentView addSubview:[self titleLabel]];
        [_contentView addSubview:[self subTitleTextView]];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new]; 
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:25];
        _titleLabel.textColor = [UIColor colorFromRGB:0x575757];
    }
    return _titleLabel;
}

- (UITextView *)subTitleTextView {
    if (_subTitleTextView == nil) {
        _subTitleTextView = [UITextView new];
        
        _subTitleTextView.textAlignment = NSTextAlignmentCenter;
        _subTitleTextView.font = [UIFont systemFontOfSize:16];
        _subTitleTextView.editable = NO;
        _subTitleTextView.textColor = [UIColor colorFromRGB:0x797979];
    }
    return _subTitleTextView;
}

@end
