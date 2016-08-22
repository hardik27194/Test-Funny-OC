//
//  AboutLogo3DTouchViewController.m
//  Funny
//
//  Created by yanzhen on 16/7/4.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "AboutLogo3DTouchViewController.h"

@interface AboutLogo3DTouchViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AboutLogo3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textView.text = @"点击Logo图片可以更换Logo,长按可以恢复系统Logo.";
}

@end
