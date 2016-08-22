//
//  GlobalManage.h
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YZShareInstance.h"

@interface GlobalManage : NSObject
@property (nonatomic, strong, readonly) UIImage *headImage;
@property (nonatomic, strong, readonly) UIImage *bigImage;

HShareInstance(GlobalManage);
- (CGSize)labelSize:(NSString *)text font:(CGFloat)font width:(CGFloat)width;
- (void)saveImage:(UIImage *)image;
- (void)clearCache;
@end
