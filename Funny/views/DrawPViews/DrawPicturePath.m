//
//  DrawPicturePath.m
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "DrawPicturePath.h"

@implementation DrawPicturePath
+(instancetype)paintPathWithLineWidth:(CGFloat)width color:(UIColor *)color startPoint:(CGPoint)startPoint
{
    DrawPicturePath *path=[[self alloc] init];
    path.lineWidth=width;
    path.color = color;
    [path moveToPoint:startPoint];
    return path;
}
@end
