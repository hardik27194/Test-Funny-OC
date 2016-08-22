//
//  AboutMyManagerViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutMyManagerViewController.h"
#import "AboutManageFPViewController.h"
#import "AboutManageMPViewController.h"
#import "UserModifyPasswordViewController.h"

#define ManageVColor [UIColor colorWithRed:0.0 green:178/255.0 blue:252/255.0 alpha:1]
@interface AboutMyManagerViewController ()
@property (weak, nonatomic) IBOutlet UIView *firstPasswordView;
@property (weak, nonatomic) IBOutlet UIView *secondPasswordView;
@property (weak, nonatomic) IBOutlet UIView *thirdPasswordView;
@property (weak, nonatomic) IBOutlet UIView *fourthPasswordView;
@property (weak, nonatomic) IBOutlet UIView *smallBackView;
@property (weak, nonatomic) IBOutlet UIView *smallView1;
@property (weak, nonatomic) IBOutlet UIView *smallView2;
@property (weak, nonatomic) IBOutlet UIView *smallView3;
@property (weak, nonatomic) IBOutlet UIView *smallView4;
@property (weak, nonatomic) IBOutlet UIView *btnsView;
@property (strong, nonatomic) NSMutableArray *btnsArray;
@end

@implementation AboutMyManagerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self clearAll];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _btnsArray=[[NSMutableArray alloc] init];
    self.title=@"密码管理";
    [self confUI];
}
- (void)confUI
{
    for (UIButton *button in self.btnsView.subviews) {
        [button lockManageBorderWidth:2.0];
    }
    for (UIView *smallView in self.smallBackView.subviews) {
        [smallView lockManageBorderWidth:2.0];
    }
}
- (IBAction)forgetPassword:(UIButton *)sender {
#ifdef OTHERUSE
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *forget=[ud objectForKey:@"Forget"];
    if (forget.length<=0) {
        [ud setObject:@"1234" forKey:@"Forget"];
        [ud synchronize];
        UserModifyPasswordViewController *vc=[[UserModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        AboutManageFPViewController *vc=[[AboutManageFPViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
#else
    AboutManageFPViewController *vc=[[AboutManageFPViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
#endif
}

- (IBAction)btnsClick:(UIButton *)sender {
    [UIView animateWithDuration:0.05 animations:^{
        [sender setBackgroundColor:YZColor(115, 90, 113)];
    } completion:^(BOOL finished) {
        [sender setBackgroundColor:[UIColor clearColor]];
    }];
    [self addButton:sender];
}
- (void)addButton:(UIButton *)button
{
    [self.btnsArray addObject:button];
    if (self.btnsArray.count == 1) {
        [self.firstPasswordView setBackgroundColor:ManageVColor];
    }else if (self.btnsArray.count == 2){
        [self.secondPasswordView setBackgroundColor:ManageVColor];
    }else if (self.btnsArray.count == 3){
        [self.thirdPasswordView setBackgroundColor:ManageVColor];
    }else if (self.btnsArray.count == 4){
        [self.fourthPasswordView setBackgroundColor:ManageVColor];
        [self performSelector:@selector(isPasswordRight:) withObject:self.btnsArray afterDelay:0.2];
    }else{
        return;
    }
}
- (void)isPasswordRight:(NSArray *)array
{
    NSMutableString *password=[[NSMutableString alloc] init];
    for (UIButton *button in array) {
        [password appendFormat:@"%@",button.titleLabel.text];
    }
    NSString *udPasssword=[self makePassword];
    if ([password isEqualToString:udPasssword]) {
        AboutManageMPViewController *vc=[[AboutManageMPViewController alloc] init];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.smallBackView.transform=CGAffineTransformMakeTranslation(-20, 0);
        } completion:^(BOOL finished) {
            self.smallBackView.transform=CGAffineTransformMakeTranslation(40, 0);
            [UIView animateWithDuration:0.1 animations:^{
                self.smallBackView.transform=CGAffineTransformMakeTranslation(0, 0);
            } completion:^(BOOL finished) {
                [self clearAll];
            }];
            
        }];
        
    }
}

- (NSString *)makePassword
{
    NSString *password=[NSString dateString];
    NSString *rangeString=[password substringToIndex:10];
    rangeString=[rangeString substringFromIndex:2];
    NSArray *_array=[rangeString componentsSeparatedByString:@"-"];
    NSMutableArray *array=[[NSMutableArray alloc] initWithArray:_array];
    [array removeObjectAtIndex:1];
    NSString *string=@"";
    for (NSString *str in array) {
        string=[string stringByAppendingFormat:@"%@",str];
    }
#ifdef OTHERUSE
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *forget=[ud objectForKey:@"Forget"];
    if (forget.length>0) return forget;
    return @"1234";
#else
    return string;
#endif
}
- (void)clearAll
{
    [self.btnsArray removeAllObjects];
    for (UIView *smallView in self.smallBackView.subviews) {
        [smallView setBackgroundColor:[UIColor clearColor]];
    }

}

@end
