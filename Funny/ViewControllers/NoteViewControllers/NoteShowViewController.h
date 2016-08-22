//
//  NoteShowViewController.h
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NotePathHeader [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"note"]
#define NotePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"note/note.data"]
@interface NoteShowViewController : UIViewController
- (void)addNewNoteWithModel:(NoteModel *)model;
- (void)modifyOldNoteWithModel:(NoteModel *)model indexPath:(NSIndexPath *)indexPath;
@end
