//
//  NoteCollectionViewCell.m
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NoteCollectionViewCell.h"

@interface NoteCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
@implementation NoteCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [_deleteBtn setBackgroundImage:[UIImage imageNamedWithFunny:@"Delete"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.textView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.block) {
        _block(self);
    }
}
-(void)setModel:(NoteModel *)model
{
    _model=model;
    _textView.text=model.noteTitle;
    _timeLabel.text=model.noteTime;
}
- (IBAction)deleteBtnClick:(UIButton *)sender {
    if ([_deletegate respondsToSelector:@selector(deleteOneItem:)]) {
        [_deletegate deleteOneItem:sender];
    }
}

@end
