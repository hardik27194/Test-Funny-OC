//
//  SecretPasswordViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/27.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretPasswordViewController.h"
#import "SecretAddNewItemViewController.h"
#import "SecretTableViewCell.h"

@interface SecretPasswordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong ,nonatomic) NSMutableArray *v2Array;
@property (strong, nonatomic) NSMutableArray *appleArray;
@property (nonatomic, strong) NSMutableArray *mailArray;
@property (strong, nonatomic) NSMutableArray *gameArray;
@property (strong, nonatomic) NSMutableArray *baiduArray;
@property (strong, nonatomic) NSMutableArray *qqArray;
@property (strong, nonatomic) NSMutableArray *alibabaArray;
@property (strong, nonatomic) NSMutableArray *otherArray;
@property (strong, nonatomic) NSMutableArray *nowArray;
@end

@implementation SecretPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:SecretPathHeader error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:SecretPathHeader withIntermediateDirectories:YES attributes:nil error:&error];
    }
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array=self.dataSource[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecretTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SecretCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SecretTableViewCell" owner:self options:nil] lastObject];
    }
    NSArray *modelArray=self.dataSource[indexPath.section];
    SecretModel *model=modelArray[indexPath.row];
    UILongPressGestureRecognizer *longGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
    [cell addGestureRecognizer:longGesture];
    cell.model=model;
    return cell;
}
- (void)longGestureAction:(UILongPressGestureRecognizer *)longGesture
{
    if (longGesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    self.tableView.editing=!self.tableView.editing;
//    if (self.tableView.isEditing)
//    {
//        [_tableView setEditing:NO animated:YES];
//    }else{
//        [self.tableView setEditing:YES animated:YES];
//    }

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleArray[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
#pragma mark - tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array=self.dataSource[indexPath.section];
    SecretModel *model=array[indexPath.row];
    SecretAddNewItemViewController *vc=[[SecretAddNewItemViewController alloc] initWithSecretModel:model titleArray:self.titleArray[indexPath.row] viewController:self indexPath:indexPath];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.section;
    NSMutableArray *array = self.dataSource[row];
    [array removeObjectAtIndex:indexPath.row];
    [self.dataSource replaceObjectAtIndex:row withObject:array];
    [NSKeyedArchiver archiveRootObject:array toFile:[self pathForRow:row]];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - actions
- (void)addNewItem
{
    SecretAddNewItemViewController *vc=[[SecretAddNewItemViewController alloc] initWithTitleArray:self.titleArray viewController:self];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - self out
//下面两项可以简化
- (NSString *)pathForRow:(NSInteger)row{
    NSArray *array = [[NSArray alloc] initWithObjects:SecretV2FilePath,SecretAppleFilePath,SecretMailFilePath,SecretGameFilePath,SecretBaiduFilePath,SecretQQFilePath,SecretAlibabaFilePath,SecretOtherFilePath,SecretNowFilePath, nil];
    return array[row];
}
- (void)addNewPassword:(SecretModel *)model row:(NSInteger)row
{
    NSMutableArray *array = self.dataSource[row];
    [array addObject:model];
    [self.dataSource replaceObjectAtIndex:row withObject:array];
    [NSKeyedArchiver archiveRootObject:array toFile:[self pathForRow:row]];
    [self.tableView reloadData];
    
}
- (void)modifyPassword:(SecretModel *)model  indexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.section;
    NSMutableArray *array = self.dataSource[row];
    [array replaceObjectAtIndex:indexPath.row withObject:model];
    [self.dataSource replaceObjectAtIndex:row withObject:array];
    [NSKeyedArchiver archiveRootObject:array toFile:[self pathForRow:row]];
    [self.tableView reloadData];

}
- (void)renewAllSource
{
    [self.dataSource removeAllObjects];
    if (self.dataSource.count > 0) {
        [self.tableView reloadData];
    }
}
#pragma mark - lazy loading
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray=[[NSArray alloc] initWithObjects:@"V2",@"Apple",@"Mail",@"Game",@"Baidu",@"QQ",@"Alibaba",@"Other",@"Now", nil];
    }
    return _titleArray;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
        [_dataSource addObject:self.v2Array];
        [_dataSource addObject:self.appleArray];
        [_dataSource addObject:self.mailArray];
        [_dataSource addObject:self.gameArray];
        [_dataSource addObject:self.baiduArray];
        [_dataSource addObject:self.qqArray];
        [_dataSource addObject:self.alibabaArray];
        [_dataSource addObject:self.otherArray];
        [_dataSource addObject:self.nowArray];
    }
    return _dataSource;
}
- (NSMutableArray *)v2Array
{
    if (!_v2Array) {
        _v2Array=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretV2FilePath error:&error];
        if (!error) {
            _v2Array=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretV2FilePath];
    }
  }
        return _v2Array;
}
- (NSMutableArray *)appleArray
{
    if (!_appleArray) {
        _appleArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretAppleFilePath error:&error];
        if (!error) {
            _appleArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretAppleFilePath];
        }
    }
    return _appleArray;
}
- (NSMutableArray *)mailArray
{
    if (!_mailArray) {
        _mailArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretMailFilePath error:&error];
        if (!error) {
            _mailArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretMailFilePath];
        }
    }
    return _mailArray;
}
- (NSMutableArray *)gameArray
{
    if (!_gameArray) {
        _gameArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretGameFilePath error:&error];
        if (!error) {
            _gameArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretGameFilePath];
        }
    }
    return _gameArray;
}
- (NSMutableArray *)baiduArray
{
    if (!_baiduArray) {
        _baiduArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretBaiduFilePath error:&error];
        if (!error) {
            _baiduArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretBaiduFilePath];
        }
    }
    return _baiduArray;
}
- (NSMutableArray *)qqArray
{
    if (!_qqArray) {
        _qqArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretQQFilePath error:&error];
        if (!error) {
            _qqArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretQQFilePath];
        }
    }
    return _qqArray;
}
- (NSMutableArray *)alibabaArray
{
    if (!_alibabaArray) {
        _alibabaArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretAlibabaFilePath error:&error];
        if (!error) {
            _alibabaArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretAlibabaFilePath];
        }
    }
    return _alibabaArray;
}
- (NSMutableArray *)otherArray
{
    if (!_otherArray) {
        _otherArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretOtherFilePath error:&error];
        if (!error) {
            _otherArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretOtherFilePath];
        }
    }
    return _otherArray;
}
- (NSMutableArray *)nowArray
{
    if (!_nowArray) {
        _nowArray=[[NSMutableArray alloc] init];
        NSFileManager *manage=[NSFileManager defaultManager];
        NSError *error;
        [manage attributesOfItemAtPath:SecretNowFilePath error:&error];
        if (!error) {
            _nowArray=[NSKeyedUnarchiver unarchiveObjectWithFile:SecretNowFilePath];
        }
    }
    return _nowArray;
}

@end

