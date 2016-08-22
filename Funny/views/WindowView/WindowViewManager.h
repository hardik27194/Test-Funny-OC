//
//  WindowViewManager.h
//  Funny
//
//  Created by yanzhen on 16/7/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>

@interface WindowViewManager : NSObject
HShareInstance(WindowViewManager)

@property (nonatomic, readonly) BOOL isWindowViewShow;

/** 视频播放一定时间（未使用快进功能）  */
- (void)videoPlayCurrentTime:(CMTime)time videoUrlString:(NSString *)urlString;
- (void)videoPlayWithVideoUrlString:(NSString *)urlString;
@end
