//
//  NoteLockViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/2.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NoteLockViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "NSObject+General.h"
#import "NoteShowViewController.h"

#define NotePasswordViewBorderWidth 1.2
@interface NoteLockViewController ()
@property (weak, nonatomic) IBOutlet UIView *firstPasswordView;
@property (weak, nonatomic) IBOutlet UIView *secondPasswordView;
@property (weak, nonatomic) IBOutlet UIView *threePasswordView;
@property (weak, nonatomic) IBOutlet UIView *fourPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIView *smallPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrDeleteBtn;
@property (strong, nonatomic) NSMutableArray *btnsArray;
@end

@implementation NoteLockViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeBackgroundColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"密码";
    _btnsArray=[[NSMutableArray alloc] init];
    [self confUI];
    LAContext *context = [[LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        
        NoteShowViewController *vc=[[NoteShowViewController alloc] init];
        YZWeakSelf(self)
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"Use Touch ID to Login.", nil) reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.navigationController pushViewController:vc animated:YES];
                });
            }else{
                NSLog(@"TTTT:Fail");
                if (error.code == kLAErrorUserFallback) {
                    NSLog(@"User tapped Enter Password");
                } else if (error.code == kLAErrorUserCancel) {
                    NSLog(@"User tapped Cancel");
                } else {
                    NSLog(@"Authenticated failed.");
                }
            }
        }];
    }
}
- (void)confUI
{
    [self.firstPasswordView borderWidthAndCorner:NotePasswordViewBorderWidth];
    [self.secondPasswordView borderWidthAndCorner:NotePasswordViewBorderWidth];
    [self.threePasswordView borderWidthAndCorner:NotePasswordViewBorderWidth];
    [self.fourPasswordView borderWidthAndCorner:NotePasswordViewBorderWidth];
    for (UIButton *button in self.btnView.subviews) {
        [button borderWidthAndCorner:2.0];
    }
}
- (void)removeBackgroundColor
{
    [self.btnsArray removeAllObjects];
    [self.firstPasswordView setBackgroundColor:[UIColor clearColor]];
    [self.secondPasswordView setBackgroundColor:[UIColor clearColor]];
    [self.threePasswordView setBackgroundColor:[UIColor clearColor]];
    [self.fourPasswordView setBackgroundColor:[UIColor clearColor]];
}
#pragma mark - input password
//12300-12309
- (IBAction)numBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.05 animations:^{
        [sender setBackgroundColor:YZColor(115, 90, 113)];
    } completion:^(BOOL finished) {
        [sender setBackgroundColor:[UIColor clearColor]];
    }];
    [self addButton:sender];
}
- (void)addButton:(UIButton *)button
{
    if (button)
    [self.btnsArray addObject:button];
    if (self.btnsArray.count == 1) {
        [self.cancelOrDeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.firstPasswordView setBackgroundColor:YZColor(112, 103, 130)];
    }else if (self.btnsArray.count == 2){
        [self.secondPasswordView setBackgroundColor:YZColor(112, 103, 130)];
    }else if (self.btnsArray.count == 3){
        [self.threePasswordView setBackgroundColor:YZColor(112, 103, 130)];
    }else if (self.btnsArray.count == 4){
        [self.fourPasswordView setBackgroundColor:YZColor(112, 103, 130)];
        [self performSelector:@selector(isPasswordRight:) withObject:self.btnsArray afterDelay:0.2];
    }else{
        return;
    }
}
- (void)removeBtn{
    if (self.btnsArray.count == 0) {
        [self.cancelOrDeleteBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.firstPasswordView setBackgroundColor:[UIColor clearColor]];
    }else if (self.btnsArray.count == 1){
        [self.secondPasswordView setBackgroundColor:[UIColor clearColor]];
    }else if (self.btnsArray.count == 2){
        [self.threePasswordView setBackgroundColor:[UIColor clearColor]];
    }else if (self.btnsArray.count == 3){
        [self.fourPasswordView setBackgroundColor:[UIColor clearColor]];
    }else{
        return;
    }
    
}
- (void)isPasswordRight:(NSArray *)array
{
    NSMutableString *password=[[NSMutableString alloc] init];
    for (UIButton *button in array) {
        [password appendFormat:@"%ld",button.tag-12300];
    }
#ifdef OTHERUSE
    NSString *udPasssword=[[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] ? [[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] : @"1234";
    NSString *udPasssword1=[[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] ? [[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] : @"1234";
    NSString *udPasssword2=[[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] ? [[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] : @"1234";
#else
    NSString *udPasssword=[[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] ? [[NSUserDefaults standardUserDefaults] objectForKey:NoteLockPassword] : @"5873";
    NSString *udPasssword1=@"5250";
    NSString *udPasssword2=@"1226";
#endif
    if ([password isEqualToString:udPasssword] || [password isEqualToString:udPasssword1] || [password isEqualToString:udPasssword2]) {
        NoteShowViewController *vc=[[NoteShowViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [self.cancelOrDeleteBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.smallPasswordView.transform=CGAffineTransformMakeTranslation(-20, 0);
        } completion:^(BOOL finished) {
            self.smallPasswordView.transform=CGAffineTransformMakeTranslation(40, 0);
            [UIView animateWithDuration:0.1 animations:^{
                self.smallPasswordView.transform=CGAffineTransformMakeTranslation(0, 0);
            } completion:^(BOOL finished) {
                [self removeBackgroundColor];
                [self.cancelOrDeleteBtn setTitle:@"取消" forState:UIControlStateNormal];
            }];

        }];

    }
}
- (IBAction)cancelOrDeleteBtnClick:(UIButton *)sender {
    if ([self.cancelOrDeleteBtn.titleLabel.text isEqualToString:@"取消"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Exit" message:@"您要退出当前程序吗???" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }else if([self.cancelOrDeleteBtn.titleLabel.text isEqualToString:@"删除"]){
        [self.btnsArray removeLastObject];
        [self removeBtn];
    }
}
@end
