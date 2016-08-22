//
//  AboutMyDeclareViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutMyDeclareViewController.h"

@interface AboutMyDeclareViewController ()

@end

@implementation AboutMyDeclareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"声明";
    NSString *text=@"This App resources are from the network, app for personal and some other people use, not for commercial profit。\nThis App just for iPhone 6s、iPhone 6.";
    UILabel *declareLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 64, WIDTH-20, 0)];
    declareLabel.font=[UIFont systemFontOfSize:20];
    declareLabel.numberOfLines=0;
    declareLabel.text=text;
    CGSize newSize=[text boundingRectWithSize:CGSizeMake(WIDTH-20, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    declareLabel.frame=CGRectMake(10, 70, WIDTH-20, newSize.height);
    //declareLabel.backgroundColor=[UIColor redColor];
    [self.view addSubview:declareLabel];
    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(declareLabel.frame)+10, WIDTH-20, 25)];
    myLabel.text=@"----- Y&Z";
    myLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:myLabel];
    
}


@end
