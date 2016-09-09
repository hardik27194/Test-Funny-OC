//
//  AboutMyViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/25.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutMyViewController.h"
#import "AboutMyManagerViewController.h"
#import "AboutMyDeclareViewController.h"
#import "AboutMyAboutViewController.h"
#import "AboutSeetingsViewController.h"
#import "HomeBGViewController.h"
#import "SDWebImageManager.h"

static const CGFloat AIS_HEIGHT = 228.5;
static const CGFloat ABOUT_ROWHEIGHT = 52.5;

@interface AboutMyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIView *tableHeaderView;
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation AboutMyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamedWithFunny:@"clear"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamedWithFunny:@"clear"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YZColor(247, 247, 247);
    self.title = @"Funny";
    [self confUI];
}

- (void)exit{
    exit(0);
}

- (NSString *)fileSize{
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"default"];
    NSInteger bytes = [filePath fileSize];
    return [NSString stringWithFormat:@"%.2fMB",bytes / 1000 / 1000.0];
}

#pragma mark - tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AboutCell"];
    }
    if (indexPath.row  == 0) {
        cell.detailTextLabel.textColor = YZColor(255, 133, 25);
        cell.detailTextLabel.text = [self fileSize];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[GlobalManage shareGlobalManage] clearCache];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        return;
    }else{
        NSArray *vcs = @[@"HomeBGViewController",@"AboutMyManagerViewController",@"AboutSeetingsViewController",@"AboutMyDeclareViewController",@"AboutMyAboutViewController"];
        UIViewController *vc = [[NSClassFromString(vcs[indexPath.row - 1]) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //[self beginScroll:scrollView.contentOffset.y];
    [self beginScroll1:scrollView.contentOffset.y];

}

#pragma mark - 伸缩一
- (void)TableViewHeadView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, AIS_HEIGHT)];
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, AIS_HEIGHT)];
    [backView addSubview:self.tableHeaderView];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, AIS_HEIGHT)];
    self.headerImageView.image = [UIImage imageNamedWithHZW:@"Ais"];
    //确定headerImageView的缩放锚点和位置
    self.headerImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.headerImageView.layer.position = CGPointMake(0.5 * WIDTH, 0);
    self.headerImageView.userInteractionEnabled = YES;
    
    [self.tableHeaderView addSubview:self.headerImageView];
    self.tableView.tableHeaderView = backView;
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _headerImageView.image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"AboutHeadImage"];
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    [data writeToFile:[filePath stringByAppendingPathComponent:@"image.data"] atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)filePath{
    return [DocumentsPath stringByAppendingPathComponent:@"AboutHeadImage/image.data"];
}

- (void)beginScroll:(CGFloat)offsetY{
    if (offsetY < 0) {
        CGFloat scale = 1 - offsetY / AIS_HEIGHT;
        self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);
        CGRect rect = self.tableHeaderView.frame;
        rect.origin.y = offsetY;
        self.tableHeaderView.frame = rect;
    }
}

#pragma mark - 伸缩二
- (void)TableViewHeadView1{
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, AIS_HEIGHT)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, AIS_HEIGHT)];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    self.headerImageView.image = [UIImage imageNamedWithHZW:@"Ais"];
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data.length > 0) {
        UIImage *image = [UIImage imageWithData:data];
        _headerImageView.image = image;
    }
    _headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_headerImageView addGestureRecognizer:tap];
    [self.tableHeaderView addSubview:self.headerImageView];
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)beginScroll1:(CGFloat)offsetY{
    if (offsetY < 0) {
        CGFloat scale = 1 - offsetY / AIS_HEIGHT;
        self.headerImageView.transform = CGAffineTransformMakeScale(scale, scale);
        CGRect rect = self.headerImageView.frame;
        rect.origin.y = offsetY;
        self.headerImageView.frame = rect;
    }
}

#pragma mark - UI
- (void)confUI
{
    NSArray *array =[[NSArray alloc] initWithObjects:@"清除缓存",@"首页背景",@"管理员",@"设置",@"声明",@"关于", nil];
    [self.dataSource addObjectsFromArray:array];
    self.tableView.rowHeight = ABOUT_ROWHEIGHT;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 10, WIDTH, 50);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn setTitleColor:YZColor(255, 133, 25) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;
    
    //[self TableViewHeadView];
    [self TableViewHeadView1];
}

@end
