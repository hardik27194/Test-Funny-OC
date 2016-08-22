//
//  SuperTableViewController.m
//  Funny
//
//  Created by yanzhen on 16/4/12.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "SuperTableViewController.h"

@interface SuperTableViewController ()

@end

@implementation SuperTableViewController

-(instancetype)init{
    self = [super initWithNibName:@"SuperTableViewController" bundle:nil];
    if (self) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"1111";
    return cell;
}



@end
