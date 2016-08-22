//
//  NoteCollectionViewCell.h
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteCollectionViewCell;
typedef void(^TextViewClickBlock)(NoteCollectionViewCell *cell);
@protocol NoteViewDeleteBtnClickDelegate <NSObject>

- (void)deleteOneItem:(UIButton *)button;

@end
@interface NoteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) NoteModel *model;
@property (weak, nonatomic) id<NoteViewDeleteBtnClickDelegate>deletegate;
@property (nonatomic, copy) TextViewClickBlock block;
@end
