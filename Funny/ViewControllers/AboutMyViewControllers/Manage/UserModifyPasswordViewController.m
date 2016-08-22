//
//  UserModifyPasswordViewController.m
//  Funny
//
//  Created by yanzhen on 15/12/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "UserModifyPasswordViewController.h"
#import "YZTextField.h"
#import "MBProgressHUD+YZZ.h"

@interface UserModifyPasswordViewController ()
@property (weak, nonatomic) IBOutlet YZTextField *firstPasswordTF;
@property (weak, nonatomic) IBOutlet YZTextField *secondPTF;
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation UserModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _sureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _sureBtn.frame=CGRectMake(0, 0, 40, 40);
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [_sureBtn addTarget:self action:@selector(sureBtnClick:)
    forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightB=[[UIBarButtonItem alloc] initWithCustomView:_sureBtn];
    self.navigationItem.rightBarButtonItem=rightB;
    
    
}
- (void)sureBtnClick:(UIButton *)btn
{
    if (self.firstPasswordTF.text.length<=0 || self.secondPTF.text.length<=0) {
        return;
    }
    if (self.firstPasswordTF.text.length != 4 || self.secondPTF.text.length != 4) {
        [MBProgressHUD showMessage:@"请输入四位密码" success:NO stringColor:[UIColor redColor] toView:self.view];
        return;
    }
    if (![self.firstPasswordTF.text isEqualToString:self.secondPTF.text]) {
        [MBProgressHUD showMessage:@"两次输入密码不同，请重新输入" success:NO stringColor:[UIColor redColor] toView:self.view];
        self.firstPasswordTF.text=@"";
        self.secondPTF.text=@"";
    }else{
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:self.firstPasswordTF.text forKey:@"Forget"];
        [ud synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
