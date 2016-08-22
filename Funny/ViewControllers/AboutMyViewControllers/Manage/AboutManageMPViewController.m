//
//  AboutManageMPViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/10.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutManageMPViewController.h"
#import "YZTextField.h"
#import "MBProgressHUD+YZZ.h"

@interface AboutManageMPViewController ()
@property (weak, nonatomic) IBOutlet YZTextField *password1TF;
@property (weak, nonatomic) IBOutlet YZTextField *password2TF;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (assign, nonatomic) NSInteger segmentIndex;
@end

@implementation AboutManageMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self confUI];
    
}
- (void)confUI
{
    NSArray *itemsArray=@[@"手势密码",@"数字密码"];
    UISegmentedControl *segment=[[UISegmentedControl alloc] initWithItems:itemsArray];
    segment.frame=CGRectMake(0, 0, 150, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex=0;
    self.navigationItem.titleView=segment;
    self.sureButton.layer.masksToBounds=YES;
    self.sureButton.layer.cornerRadius=6.0;
    self.password1TF.placeholder=@"0--8组合,不能超过9位";
    self.segmentIndex=0;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self noTFFirstResponder];
}
- (void)noTFFirstResponder
{
    if (self.password1TF.isFirstResponder) {
        [self.password1TF resignFirstResponder];
    }else if (self.password2TF.isFirstResponder){
        [self.password2TF resignFirstResponder];
    }
}
#pragma mark - action
- (void)segmentAction:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {
        self.segmentIndex=0;
        self.password1TF.placeholder=@"0--8组合,不能超过9位";
    }else{
        self.segmentIndex=1;
        self.password1TF.placeholder=@"0--9组合,不能超过4位";
    }
}
- (IBAction)sureButtonAction:(UIButton *)sender {
    [self noTFFirstResponder];
    if (self.password1TF.text.length<=0 || self.password2TF.text.length<=0) {
        return;
    }
    if (![self.password1TF.text isEqualToString:self.password2TF.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"两次输入的密码不一样" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.password1TF.text=@"";
            self.password2TF.text=@"";
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        if (self.segmentIndex == 0) {
            [ud setObject:self.password2TF.text forKey:PassWordOne];
        }else if (self.segmentIndex == 1){
            [ud setObject:self.password2TF.text forKey:NoteLockPassword];
        }
        [ud synchronize];
        self.password1TF.text=@"";
        self.password2TF.text=@"";
        [MBProgressHUD showSuccess:@"密码修改成功"];
    }
}
@end
