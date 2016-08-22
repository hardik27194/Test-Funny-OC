//
//  SecretFirstViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/27.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretFirstViewController.h"
#import "SecretLockViewController.h"

@interface SecretFirstViewController ()

@end

@implementation SecretFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"My Area";
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"railway" ofType:@"gif"];
//    NSData *gif = [NSData dataWithContentsOfFile:filePath];
//    UIWebView *webViewBG = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [webViewBG loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webViewBG.userInteractionEnabled = NO;
//    [self.view addSubview:webViewBG];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
    UIImage *image=[[UIImage imageNamedWithFunny:@"railway"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageView.image=image;
    [self.view addSubview:imageView];
    //
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 20)];
    welcomeLabel.text = @"Welcome to my area";
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.font = [UIFont systemFontOfSize:20];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:welcomeLabel];
//    UILabel *welcomeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 20)];
//    welcomeLabel1.text = @"Not myself can't in";
//    welcomeLabel1.textColor = [UIColor whiteColor];
//    welcomeLabel1.font = [UIFont systemFontOfSize:20];
//    welcomeLabel1.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:welcomeLabel1];
//    UILabel *welcomeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.view.bounds.size.width, 20)];
//    welcomeLabel2.text = @"非本人不得入内";
//    welcomeLabel2.textColor = [UIColor whiteColor];
//    welcomeLabel2.font = [UIFont systemFontOfSize:20];
//    welcomeLabel2.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:welcomeLabel2];


    UIButton *(^block)(CGFloat h, NSString *title, SEL action) = ^(CGFloat h, NSString *title, SEL action){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, HEIGHT-h, WIDTH-80, 40)];
        btn.layer.borderColor = [[UIColor whiteColor] CGColor];
        btn.layer.borderWidth = 2.0;
        btn.titleLabel.font = [UIFont systemFontOfSize:24];
        [btn setTintColor:[UIColor whiteColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };
    
    UIButton *loginBtn = block(140, @"Login", @selector(login));
    [self.view addSubview:loginBtn];
    
    UIButton *logout = block(80, @"Logout", @selector(logout));
    [self.view addSubview:logout];


}

- (void)login
{
    self.navigationItem.backBarButtonItem.title=@"返回";
    
    SecretLockViewController *lvc=[[SecretLockViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}
- (void)logout
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
