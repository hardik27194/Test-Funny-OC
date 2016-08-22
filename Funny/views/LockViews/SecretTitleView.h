//
//  SecretTitleView.h
//  Funny
//
//  Created by yanzhen on 15/10/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecretDidSelectDelegate <NSObject>

- (void)didSelectAtIndexPath:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end
@interface SecretTitleView : UIView
@property (nonatomic, weak) id<SecretDidSelectDelegate>delegate;
@property (assign, nonatomic) BOOL isSecretTitleViewHidden;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
- (void)toggleSecretTitleView;
@end
