//
//  NetEaseSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"
#import "NetEaseMacro.h"

@interface NetEaseSuperViewController : SuperThirdViewController
@property (nonatomic, copy) NSString *defaultURL;
@property (nonatomic, copy) NSString *pushURL;
@property (nonatomic, copy) NSString *key;

- (NSString *)requestURLString:(eRefresh)refresh;
- (void)refreshSuper;
- (void)netRequestWithRefresh:(eRefresh)refresh baseView:(YZRefreshBaseView *)baseView;
@end
