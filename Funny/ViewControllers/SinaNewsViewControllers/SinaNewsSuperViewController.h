//
//  SinaNewsSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"


@interface SinaNewsSuperViewController : SuperThirdViewController
@property (nonatomic, copy) NSString *titleName;
- (NSString *)requestURLString:(eRefresh)refresh;
- (void)refreshSuper;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView;
@end
