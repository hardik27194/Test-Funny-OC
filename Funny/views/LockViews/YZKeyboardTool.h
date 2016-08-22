//
//  YZKeyboardTool.h
//  Funny
//
//  Created by yanzhen on 15/10/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyBoardActionDelegate <NSObject>

- (void)keyBoardClick:(NSInteger)index;

@end
typedef enum {
    yPre=0,//上一个
    yNext,//下一个
    yDone//完成
}eKeyboardItemType;
@interface YZKeyboardTool : UIView
@property (nonatomic, weak) id<KeyBoardActionDelegate>delegate;
+ (instancetype)keyboardToolStandard;
@end
