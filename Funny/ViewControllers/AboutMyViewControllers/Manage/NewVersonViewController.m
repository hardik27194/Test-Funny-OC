//
//  NewVersonViewController.m
//  Funny
//
//  Created by yanzhen on 16/7/4.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "NewVersonViewController.h"

@interface NewVersonViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NewVersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新版本说明";
    _textView.text = @"1.3.1:部分页面引入了3DTouch的功能  1.3.7:添加UIView XIB属性  1.3.8增加系统首页背景 2.2.1:视频小窗口缩放 2.2.4:Touch ID解锁 3.0.0:Xcode 8 3.0.1:修改了cell复用的问题";
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton");
    }];
    NSArray *actions = @[action];
    return actions;
}
@end
