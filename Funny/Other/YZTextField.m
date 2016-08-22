//
//  YZTextField.m
//  Funny
//
//  Created by yanzhen on 15/10/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "YZTextField.h"

@implementation YZTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y, bounds.size.width, bounds.size.height);
}
- (void)awakeFromNib
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=6;
    
}
@end
