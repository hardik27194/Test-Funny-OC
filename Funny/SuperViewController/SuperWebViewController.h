//
//  SuperWebViewController.h
//  Funny
//
//  Created by yanzhen on 16/6/28.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperWebViewController : UIViewController<UIWebViewDelegate>
- (instancetype)initWithUrlString:(NSString *)urlString;
@end
