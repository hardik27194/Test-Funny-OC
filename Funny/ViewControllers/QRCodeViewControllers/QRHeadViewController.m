//
//  QRHeadViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/6.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "QRHeadViewController.h"
#import "QRMakeViewController.h"
#import "QRScanningViewController.h"

@interface QRHeadViewController ()
@property (strong, nonatomic) QRMakeViewController *makeVC;
@property (strong, nonatomic) QRScanningViewController *scanVc;
@end

@implementation QRHeadViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    [super viewDidLoad];
}

- (void)configUI{
    NSArray *itemsArray=@[@"生成二维码",@"扫描二维码"];
    UISegmentedControl *segment=[[UISegmentedControl alloc] initWithItems:itemsArray];
    segment.frame=CGRectMake(0, 0, 150, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex=0;
    self.navigationItem.titleView=segment;
    self.makeVC=[[QRMakeViewController alloc] init];
    self.scanVc=[[QRScanningViewController alloc] init];
    [self addChildViewController:self.makeVC];
    [self addChildViewController:self.scanVc];
    [self.view addSubview:self.scanVc.view];
    [self.view addSubview:self.makeVC.view];
}

#pragma mark - segment Action
- (void)segmentAction:(UISegmentedControl *)segment
{
//    if (segment.selectedSegmentIndex == 0) {
//        [self.view bringSubviewToFront:self.makeVC.view];
//    }else{
//        [self.makeVC.view endEditing:YES];
//        [self.view bringSubviewToFront:self.scanVc.view];
//    }
    if (segment.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.scanVc.view.alpha=0;
        } completion:^(BOOL finished) {
            self.makeVC.view.alpha=1;
        }];
    }else{
        [self.makeVC.view endEditing:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.makeVC.view.alpha=0;
        } completion:^(BOOL finished) {
            self.scanVc.view.alpha=1;
        }];

    }

}
@end
