//
//  DrawPicturePaintView.m
//  DrawPicture
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "DrawPicturePaintView.h"
#import "DrawPicturePath.h"

@interface DrawPicturePaintView ()
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) NSMutableArray *paths;
@end
@implementation DrawPicturePaintView
-(void)drawRect:(CGRect)rect
{
    if (!self.paths.count) return;
    for (DrawPicturePath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image=(UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            [path.color set];
            [path stroke];
        }
    }
        
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _width=2;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point=[touch locationInView:self];
    DrawPicturePath *path = [DrawPicturePath paintPathWithLineWidth:_width color:_color startPoint:point];
    
    _path = path;
    [self.paths addObject:path];


}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point=[touch locationInView:self];
    [_path addLineToPoint:point];
    [self setNeedsDisplay];

}
#pragma mark - out
-(void)clearScreen
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
- (void)undo
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
-(BOOL)isDrawInView
{
    if (_paths.count) {
        return YES;
    }
    return NO;
}
#pragma mark - lazy loading
- (NSMutableArray *)paths
{
    if (!_paths) {
        _paths=[[NSMutableArray alloc] init];
    }
    return _paths;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self.paths addObject:image];
    
    [self setNeedsDisplay];
}

@end
