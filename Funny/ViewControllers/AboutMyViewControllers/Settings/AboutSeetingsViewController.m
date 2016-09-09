//
//  AboutSeetingsViewController.m
//  Funny
//
//  Created by yanzhen on 16/9/9.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "AboutSeetingsViewController.h"

static const CGFloat SETTINGS_ROWHEIGHT = 50.0;
static const CGFloat SETTINGS_SECTIONHEIGHTERH = 10.0;
@interface AboutSeetingsViewController ()

@end

@implementation AboutSeetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = SETTINGS_ROWHEIGHT;
    self.tableView.backgroundColor = YZColor(230, 230, 237);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *items = @[@[@"隐私设置"],@[@"打开WIFI"],@[@"打开移动网络"]];
    [self.dataSource addObjectsFromArray:items];
}
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *items = self.dataSource[section];
    return items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGS_CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SETTINGS_CELL"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.separatorInset
    }
    NSArray *items = self.dataSource[indexPath.section];
    cell.textLabel.text = items[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SETTINGS_SECTIONHEIGHTERH;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = YZColor(230, 230, 237);
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = @[UIApplicationOpenSettingsURLString,@"prefs:root=WIFI",@"prefs:root=MOBILE_DATA_SETTINGS_ID"];
    NSURL *url = [NSURL URLWithString:array[indexPath.section]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }

}

@end
