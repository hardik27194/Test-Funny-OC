//
//  SuperThirdViewController.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"

@interface SuperThirdViewController ()

@end

@implementation SuperThirdViewController

-(void)dealloc{
    [self.footer free];
    [self.header free];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
}

-(instancetype)init{
    self = [super initWithNibName:@"SuperThirdViewController" bundle:nil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self superThirdInit];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
