//
//  DrawPictureImageView.m
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "DrawPictureImageView.h"
#import "NSObject+General.h"

@implementation DrawPictureImageView
{
    UIImageView *_imageView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addGesture];
    }
    return self;
}
- (void)drawInPictureStart{
    [UIView animateWithDuration:0.5 animations:^{
        
        _imageView.alpha = 0.3;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.alpha = 1;
        } completion:^(BOOL finished) {
            
            // 1.截屏
            UIImage *newImage = [UIImage imageWithCaptureView:self];
            
            // 2.把图片传给控制器
            _block(newImage);
            
            // 3.把自己移除父控件
            [self removeFromSuperview];
            
        }];
        
    }];

}
#pragma mark - gesture
- (void)addGesture{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    _imageView = imageView;
    [self addSubview:imageView];
    
    UIPinchGestureRecognizer *pin=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    pin.delegate=self;
    [_imageView addGestureRecognizer:pin];
    UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate=self;
    [_imageView addGestureRecognizer:rotation];
    
}
- (void)pinAction:(UIPinchGestureRecognizer *)pin
{
    _imageView.transform=CGAffineTransformScale(_imageView.transform, pin.scale, pin.scale);
    pin.scale=1;
}
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    _imageView.transform=CGAffineTransformRotate(_imageView.transform, rotation.rotation);
    
    // 复位
    rotation.rotation = 0;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)setImage:(UIImage *)image
{
    _image=image;
    _imageView.image=image;
}
@end
