//
//  YZRefreshBaseView.h
//  YZRefreshView
//
//  Created by yanzhen on 16/2/24.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZRefreshBaseView;

typedef void(^BeginRefreshingBlock)(YZRefreshBaseView *baseView);
typedef void(^EndRefreshingBlock)(YZRefreshBaseView *baseView);

@interface YZRefreshBaseView : UIView
{
    /**       初始化时scrollView的contentInset     */
    UIEdgeInsets _scrollViewInitInset;
}
@property (nonatomic, weak) UIScrollView *scrollView;
/**            在普通状态下显示的图片              */
@property (nonatomic, strong) UIImage *normalImage;
/**            刷新状态下展示的动画(图片数组)              */
@property (nonatomic, strong) NSArray *animationImages;

@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;
@property (nonatomic, copy) EndRefreshingBlock endRefreshingBlock;

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

- (void)beginRefreshing;
- (void)endRefreshing;
/**
  *子类重写
  */
- (void)free;
@end
