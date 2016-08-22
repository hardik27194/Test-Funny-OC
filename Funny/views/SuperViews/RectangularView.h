//
//  RectangularView.h
//  line
//
//  Created by yanzhen on 15/10/23.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kMoveUnknow,
    kMoveLeft,
    kMoveDown,
    kMoveRight,
    kMoveUp
}eMoveType;
@protocol PartShotDelegate  <NSObject>

- (void)shotOrNotShot:(BOOL)shot frame:(CGRect) frame;

@end
@interface RectangularView : UIView
@property (nonatomic, weak) id<PartShotDelegate>delegate;
@end
