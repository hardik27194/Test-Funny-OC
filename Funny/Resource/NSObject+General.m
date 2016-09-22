//
//  NSObject+General.m
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NSObject+General.h"
#import <objc/runtime.h>

static void * key = (void *)@"AppName";
@implementation NSObject (General)
-(void)setAppName:(NSString *)appName{
    objc_setAssociatedObject(self, key, appName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)appName{
    return objc_getAssociatedObject(self, key);
}
@end


//获得的point不够全面，中间会有点断开
@implementation UIBezierPath (AllPoint)

-(NSArray *)getAllPathPoints
{
    CGPathRef pathRef=self.CGPath;
    NSMutableArray *pointsArray=[[NSMutableArray alloc] init];
    CGPathApply(pathRef, (__bridge void *)(pointsArray), MyCGPathApplierFunc);
    return pointsArray;
}
void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}


@end

@implementation NSString (currentTime)

-(NSURL *)stringToURL{
    return [NSURL URLWithString:self];
}

-(long long)timeStringToLongLong{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:self];
    return (long long)[date timeIntervalSince1970];
}

+ (NSString *)currentTime
{
    NSTimeInterval currentTime=[[NSDate date] timeIntervalSince1970];
    long long currentLonglongTime=(long long)currentTime;
    NSString *urlString=[NSString stringWithFormat:@"%lld",currentLonglongTime];
    return urlString;
}
+ (NSString *)dateWithTimeInterval:(NSTimeInterval)time
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:date];
}
+(NSString *)noteString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM HH:mm"];
    return [format stringFromDate:[NSDate date]];
}
+ (NSString *)dateString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:[NSDate date]];
}
+(BOOL)isURLOrNot:(NSString *)urlString
{
    if (![urlString hasPrefix:@"http://"]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    NSRange range = [urlString rangeOfString:@"^http://([\\w-]+\\.)+[\\w-]+[\\w:]+(/[\\w-./?%&=]*)?$" options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) return NO;
    return YES;
}
- (NSString*)toHexString
{
    if (self.length <=0) {
        return nil;
    }
    NSString* hextString = @"";
    for( int i = 0; i < self.length; i ++){
        unichar ch =  [self characterAtIndex:i];
        hextString = [hextString stringByAppendingFormat:@"%04x",ch];
    }
    return hextString.uppercaseString;
}
- (NSInteger)fileSize{
    NSInteger fileSize = 0;
    NSFileManager *fileManage = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exist = [fileManage fileExistsAtPath:self isDirectory:&isDir];
    if (exist) {
        if (isDir) {
            NSArray *subPaths = [fileManage subpathsAtPath:self];
            for (NSString *subpath in subPaths) {
                NSString *path = [self stringByAppendingPathComponent:subpath];
                BOOL isDirectory = NO;
                [fileManage fileExistsAtPath:path isDirectory:&isDirectory];
                if (!isDirectory) {
                    fileSize += [[fileManage attributesOfItemAtPath:path error:nil][NSFileSize] integerValue];
                }
            }
        }else{
            fileSize = [[fileManage attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
        }
    }
    return fileSize;
}
- (void)writeLogToFile:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    FILE *fp=fopen(path.UTF8String,"a+");
    fseek(fp, 0, SEEK_END);
    fwrite(self.UTF8String, strlen(self.UTF8String), 1, fp);
    fwrite("\n", strlen("\n"), 1, fp);
    fclose(fp);
}
@end
@implementation UIView (corner)
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

-(CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

-(UIColor *)borderColor{
    return objc_getAssociatedObject(self, @selector(borderColor));
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}

#pragma mark - ****
//-(void)setBorderWidth:(CGFloat)borderWidth{
//    self.layer.borderWidth = borderWidth;
//}
//
//-(CGFloat)borderWidth{
//    return self.layer.borderWidth;
//}
//
//-(void)setBorderColor:(UIColor *)borderColor{
//    self.layer.borderColor = borderColor.CGColor;
//}
//
//-(UIColor *)borderColor{
//    return [UIColor colorWithCGColor:self.layer.borderColor];
//}

- (void)corner
{
    [self layoutIfNeeded];
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
}
- (void)borderWidthAndCorner:(CGFloat)borderWidth
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
    self.layer.borderWidth=borderWidth;
    self.layer.borderColor=YZColor(89, 76, 102).CGColor;
}
- (void)lockManageBorderWidth:(CGFloat)borderW
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.width/2;
    self.layer.borderWidth=borderW;
    self.layer.borderColor=YZColor(93, 187, 210).CGColor;
}

@end
@implementation UIImage (ShotScreen)

+ (UIImage *)imageNamedWithHZW:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/HZW/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)imageNamedWithFunny:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/Funny/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)imageNamedWithTabBar:(NSString *)name{
    NSString *imageName = [@"YZSource.bundle/TabBar/" stringByAppendingString:name];
    return [UIImage imageNamed:imageName];
}


+ (instancetype)imageWithCaptureView:(UIView *)view{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    [view.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end

@implementation CALayer (BorderColor)
-(void)setBorderColorUI:(UIColor *)color{
    self.borderColor = color.CGColor;
}
@end

