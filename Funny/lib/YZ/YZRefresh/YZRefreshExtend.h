//
//  YZRefreshExtend.h
//  YZRefreshView
//
//  Created by yanzhen on 16/2/24.
//  Copyright © 2016年 yanzhen. All rights reserved.
//
typedef enum {
    YZRefreshHeader = -1, // 头部控件
    YZRefreshFooter = 1 // 尾部控件
} YZRefreshViewType;

typedef enum {
    YZRefreshStatusNormal = 1,
    YZRefreshStatusPulling = 2,
    YZRefreshStatusRefreshing = 3,
    YZRefreshStatusWillRefreshing = 4
}YZRefreshStatus;

extern const CGFloat YZRefreshViewHeight;
extern const CGFloat YZRefreshAnimationDuration;

extern NSString *const YZRefreshBundleImageName;
extern NSString *const YZRefreshNormalImageName;

extern NSString *const YZRefreshContentOffset;
extern NSString *const YZRefreshContentSize;

#define YZSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define YZSCREENWIDTH  [UIScreen mainScreen].bounds.size.width