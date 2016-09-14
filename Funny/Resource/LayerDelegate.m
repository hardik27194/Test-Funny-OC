//
//  LayerDelegate.m
//  Funny
//
//  Created by yanzhen on 16/9/14.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "LayerDelegate.h"

@implementation LayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //CGContextSetFillColorWithColor(ctx, [[UIColor greenColor] CGColor]);
    UIGraphicsPushContext(ctx);
    CGFloat x = WIDTH - 90;
    if (_rightSpace > 0) {
        x = WIDTH - _rightSpace;
    }
    //PartyLetPlain SnellRoundhand-Bold SnellRoundhand SnellRoundhand-Black
    //SavoyeLetPlain Zapfino
    //IowanOldStyle-BoldItalic
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName: YZColor(255, 133, 25),
                           NSFontAttributeName: [UIFont fontWithName:@"IowanOldStyle-BoldItalic" size:18]
                           };
    if (_left) {
        [@"Y&Z TV" drawInRect:CGRectMake(5, 5, 120, 40) withAttributes:dict];
    }else{
        [@"Y&Z TV" drawInRect:CGRectMake(x, 0, 120, 40) withAttributes:dict];
    }
    
    
    //可以去掉（？？？？？）
    UIGraphicsPopContext();
}
@end
