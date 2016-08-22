//
//  YZKeyboardTool.m
//  Funny
//
//  Created by yanzhen on 15/10/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "YZKeyboardTool.h"

@interface YZKeyboardTool ()

@end
@implementation YZKeyboardTool
+(instancetype)keyboardToolStandard
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YZKeyboardTool" owner:nil options:nil] lastObject];
}
- (instancetype)init
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YZKeyboardTool" owner:nil options:nil] lastObject];
}

- (IBAction)pre:(id)sender {
    if ([_delegate respondsToSelector:@selector(keyBoardClick:)]) {
        [_delegate keyBoardClick:yPre];
    }
}
- (IBAction)next:(id)sender {
    if ([_delegate respondsToSelector:@selector(keyBoardClick:)]) {
        [_delegate keyBoardClick:yNext];
    }
}
- (IBAction)done:(id)sender {
    if ([_delegate respondsToSelector:@selector(keyBoardClick:)]) {
        [_delegate keyBoardClick:yDone];
    }
}


@end
