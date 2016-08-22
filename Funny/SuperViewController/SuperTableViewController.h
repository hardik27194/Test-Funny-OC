//
//  SuperTableViewController.h
//  Funny
//
//  Created by yanzhen on 16/4/12.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
