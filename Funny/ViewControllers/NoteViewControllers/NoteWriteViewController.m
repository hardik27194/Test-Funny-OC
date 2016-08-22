//
//  NoteWriteViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NoteWriteViewController.h"
#import "MBProgressHUD+YZZ.h"
#import "NoteShowViewController.h"

@interface NoteWriteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (assign, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) NoteShowViewController *vc;
@property (strong, nonatomic) NoteModel *model;
@end

@implementation NoteWriteViewController

- (instancetype)initWithAddNewNote:(NoteShowViewController *)vc
{
    if (self=[super init]) {
        self.vc=vc;
    }
    return self;
}
- (instancetype)initWithModifyOldNote:(NSIndexPath *)indexPath noteViewController:(NoteShowViewController *)vc model:(NoteModel *)model
{
    if (self=[super init]) {
        self.model=model;
        self.vc=vc;
        self.indexPath=indexPath;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Note";
    if (self.indexPath) {
        self.textView.text=self.model.noteTitle;
    }
    [self.textView becomeFirstResponder];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonClick)];
}
#pragma mark - barButtonItem Action
- (void)saveButtonClick
{
    if (self.textView.text.length<=0) {
        [self.view makeCenterToast:@"内容为空,请重新输入"];
        return;
    }else{
        NoteModel *model=[[NoteModel alloc] init];
        model.noteTitle=self.textView.text;
        model.noteTime=[NSString noteString];
        if (self.indexPath) {
            [self.vc modifyOldNoteWithModel:model indexPath:self.indexPath];
        }else{
            [self.vc addNewNoteWithModel:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
