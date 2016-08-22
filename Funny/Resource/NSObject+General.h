//
//  NSObject+General.h
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (General)
@property (nonatomic, copy) NSString *appName;
@end
/******************UIBezierPath**************/
@interface UIBezierPath (AllPoint)
- (NSArray *)getAllPathPoints;
@end
/******************NSString**************/
@interface NSString (currentTime)
- (NSURL *)stringToURL;
- (long long)timeStringToLongLong;
+ (NSString *)currentTime;
+ (NSString *)dateWithTimeInterval:(NSTimeInterval)time;
+ (NSString *)noteString;
+ (NSString *)dateString;
+ (BOOL)isURLOrNot:(NSString *)urlString;
//转换为16进制大写
- (NSString*)toHexString;
- (NSInteger)fileSize;
- (void)writeLogToFile:(NSString *)path;
@end
/*******************UIImageView***********/
@interface UIView (corner)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign, readonly) CGFloat maxX;
@property (nonatomic, assign, readonly) CGFloat maxY;
#pragma mark - *****
//可以在XIB keyPath设置属性
//@property (nonatomic, assign) CGFloat borderWidth;
//@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

- (void)corner;
- (void)borderWidthAndCorner:(CGFloat)borderWidth;
- (void)lockManageBorderWidth:(CGFloat)borderW;

@end
@interface UIImage (ShotScreen)
+ (instancetype)imageWithCaptureView:(UIView *)view;
+ (UIImage *)imageNamedWithTabBar:(NSString *)name;
+ (UIImage *)imageNamedWithFunny:(NSString *)name;
+ (UIImage *)imageNamedWithHZW:(NSString *)name;
@end

