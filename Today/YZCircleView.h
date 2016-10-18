//
//  YZCircleView.h
//  test
//
//  Created by yanzhen on 16/10/18.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZCircleView : UIView

- (instancetype)initWithRadius:(CGFloat)radius frame:(CGRect)frame;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat subTitleFontSize;
@property (nonatomic, assign) CGFloat progress;
@end
