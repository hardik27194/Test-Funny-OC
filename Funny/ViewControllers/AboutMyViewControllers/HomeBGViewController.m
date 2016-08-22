//
//  HomeBGViewController.m
//  Funny
//
//  Created by yanzhen on 16/7/19.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "HomeBGViewController.h"
#import "YZCollectionViewCell.h"
#import <YZUIKit/YZUIKit.h>

static NSString *const YZCELL = @"YZCell";

@interface HomeBGViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YZHorizontalLayout *hLayout;
@property (nonatomic, strong) YZCircularLayout *cLayout;
@end

@implementation HomeBGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选取背景图片";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"bg_%d",i+1]];
    }
    
    _hLayout = [[YZHorizontalLayout alloc] initWithItemSize:CGSizeMake(220, 330) scale:0.4 minimumLineSpacing:60];
    _cLayout = [[YZCircularLayout alloc] initWithItemSzie:CGSizeMake(80, 120) radius:130 angle:M_PI_2];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:_hLayout];
    _collectionView.backgroundColor = YZColor(220, 220, 220);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"YZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:YZCELL];
    [self.view addSubview:_collectionView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
}

- (void)refresh{
    if ([_collectionView.collectionViewLayout isKindOfClass:[YZHorizontalLayout class]]) {
        [_collectionView setCollectionViewLayout:_cLayout animated:YES];
    }else{
        [_collectionView setCollectionViewLayout:_hLayout animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YZCELL forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:_dataSource[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换背景" message:@"选取此张图片作为首页背景？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:HOMEIMAGEPATH]) {
            [manager removeItemAtPath:HOMEIMAGEPATH error:nil];
        }
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:_dataSource[indexPath.row] forKey:HOMEBACKGROUNDIMAGENAME];
        [ud synchronize];
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
