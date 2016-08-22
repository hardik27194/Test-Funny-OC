//
//  FunnyDeclareViewController.m
//  Funny
//
//  Created by yanzhen on 16/7/4.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "FunnyDeclareViewController.h"
#import "RootViewController.h"
#import "GeneralEnum.h"

@interface FunnyDeclareViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak) RootViewController *rootVC;

@end

@implementation FunnyDeclareViewController

-(instancetype)initWithTag:(NSInteger)tag rootVC:(RootViewController *)rootVC{
    if (self = [super init]) {
        _tag = tag;
        _rootVC = rootVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self makeText:_tag];
    
}

- (void)makeText:(NSInteger)tag{
    
    NSArray *array = @[@"资源来自《内涵段子》。",@"资源来自《快手》。",@"资源来自《百思不得姐》。",@"资源来自《内涵福利社》。",@"资源来自《UC》。",@"资源来自《网易》。",@"资源来自《新浪》。",@"资源来自《新浪》。",@"**************",@"画图",@"笔记",@"生成二维码和扫描二维码"];
    _textView.text = array[tag - 100];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"快速进入" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [_rootVC selectedBtn:_tag];
    }];
    NSArray *actions = @[action];
    return actions;
}

@end
