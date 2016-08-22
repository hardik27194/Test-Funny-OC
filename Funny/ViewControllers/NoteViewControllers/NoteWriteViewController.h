//
//  NoteWriteViewController.h
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteShowViewController;
@interface NoteWriteViewController : UIViewController
- (instancetype)initWithAddNewNote:(NoteShowViewController *)vc;
- (instancetype)initWithModifyOldNote:(NSIndexPath *)indexPath noteViewController:(NoteShowViewController *)vc model:(NoteModel *)model;
@end
