//
//  YZRefreshFooterView.m
//  YZRefreshView
//
//  Created by yanzhen on 16/2/24.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "YZRefreshFooterView.h"
#import "YZRefreshExtend.h"

@implementation YZRefreshFooterView
+(instancetype)footer{
    return [[YZRefreshFooterView alloc] init];
}

-(void)setScrollView:(UIScrollView *)scrollView{
    [scrollView addObserver:self forKeyPath:YZRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
    [super setScrollView:scrollView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([YZRefreshContentSize isEqualToString:keyPath]) {
        CGFloat originY = MAX(self.scrollView.frame.size.height- _scrollViewInitInset.top - _scrollViewInitInset.bottom, self.scrollView.contentSize.height);
        self.frame = CGRectMake(0, originY, self.frame.size.width, YZRefreshViewHeight);
    }
}

- (CGFloat)beginRefreshY{
    CGFloat height = self.scrollView.frame.size.height - _scrollViewInitInset.bottom - _scrollViewInitInset.top;
    CGFloat h =  self.scrollView.contentSize.height - height;
    if (h > 0) {
        return h - _scrollViewInitInset.top;
    }else{
        return -_scrollViewInitInset.top;
    }
}

-(YZRefreshViewType)refreshViewType{
    return YZRefreshFooter;
}

-(void)free{
    [super free];
    [self.scrollView removeObserver:self forKeyPath:YZRefreshContentSize];

}
@end
