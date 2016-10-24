//
//  QRScanningViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/6.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "QRScanningViewController.h"
#import "QRStartScanningVC.h"

@interface QRScanningViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
@property (weak, nonatomic) IBOutlet UIButton *openURLButton;

@end

@implementation QRScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)openURL:(id)sender {
    if (self.textView.text.length<=0) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.textView.text] options:@{} completionHandler:nil];
}

- (IBAction)scanningAction:(id)sender {
    self.textView.text=@"";
    self.scanImageView=nil;
    self.openURLButton.hidden=YES;
    QRStartScanningVC *vc = [[QRStartScanningVC alloc] init];
    vc.scanVC = self;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)scanningDone:(NSString *)string{
    self.textView.text = string;
    [self dealWithURLString];
}

- (void)dealWithURLString
{
    if ([NSString isURLOrNot:self.textView.text]) {
        self.openURLButton.hidden=NO;
    }
}

@end
