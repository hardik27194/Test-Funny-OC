//
//  GifShowSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"
#import "GifShowMacro.h"

@interface GifShowSuperViewController : SuperThirdViewController

- (void)gifShowNetRequest;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView;
@end