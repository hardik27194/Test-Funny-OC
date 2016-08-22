//
//  YZRefreshHeaderView.m
//  YZRefreshView
//
//  Created by yanzhen on 16/2/24.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "YZRefreshHeaderView.h"
#import "YZRefreshExtend.h"

@implementation YZRefreshHeaderView

+(instancetype)header{
    return [[YZRefreshHeaderView alloc] init];
}

- (CGFloat)beginRefreshY{return _scrollViewInitInset.top;}

-(YZRefreshViewType)refreshViewType{
    return YZRefreshHeader;
}
@end
