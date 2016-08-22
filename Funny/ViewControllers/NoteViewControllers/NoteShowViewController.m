//
//  NoteShowViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/3.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NoteShowViewController.h"
#import "NoteWriteViewController.h"
#import "NoteCollectionViewCell.h"

@interface NoteShowViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NoteViewDeleteBtnClickDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation NoteShowViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isEdit) {
        [self editButtonClick];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:NotePathHeader error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:NotePathHeader withIntermediateDirectories:YES attributes:nil error:&error];
    }
    self.title=@"Note Manage";
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    [self confUI];
}
- (void)confUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing=15;
    flowLayout.minimumLineSpacing=10;
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-44) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=YZColor(200, 200, 200);    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"NoteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NoteCell"];
}

#pragma mark - toolBar action
- (IBAction)addNewNote:(id)sender {
    NoteWriteViewController *vc=[[NoteWriteViewController alloc] initWithAddNewNote:self];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)editButtonClick
{
    if ([self.rightButton.titleLabel.text isEqualToString:@"Edit"]) {
        self.isEdit=YES;
        [self.rightButton setTitle:@"Done" forState:UIControlStateNormal];
    }else{
        self.isEdit=NO;
        [self.rightButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    [self.collectionView reloadData];
}
- (void)addNewNoteWithModel:(NoteModel *)model
{
    [self.dataSource addObject:model];
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:NotePath];
    [self.collectionView reloadData];
}
- (void)modifyOldNoteWithModel:(NoteModel *)model indexPath:(NSIndexPath *)indexPath
{
    [self.dataSource replaceObjectAtIndex:indexPath.item withObject:model];
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:NotePath];
    [self.collectionView reloadData];
}
#pragma mark - collectionView dataSourec
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"NoteCell" forIndexPath:indexPath];
    NoteModel *model=self.dataSource[indexPath.item];
    cell.model=model;
    cell.deletegate=self;
    cell.deleteButton.tag=1230000+indexPath.item;
    __block typeof(self) blockSelf =self;
    cell.block=^(NoteCollectionViewCell *noteCell){
        [blockSelf goToNoteWrite:model indexPath:indexPath];
    };
    if (self.isEdit) {
        cell.deleteButton.hidden=NO;
    }else{
        cell.deleteButton.hidden=YES;
    }
    return cell;
}
#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEdit) {
        return;
    }
    NoteModel *model=self.dataSource[indexPath.item];
    [self goToNoteWrite:model indexPath:indexPath];
}
- (void)goToNoteWrite:(NoteModel *)model indexPath:(NSIndexPath *)indexPath
{
    NoteWriteViewController *vc=[[NoteWriteViewController alloc] initWithModifyOldNote:indexPath noteViewController:self model:model];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark -  collectionView layout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH/2-15, 170);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 8, 10, 8);
}
#pragma mark - NoteCell delegate
- (void)deleteOneItem:(UIButton *)button
{
    [self.dataSource removeObjectAtIndex:button.tag-1230000];
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:NotePath];
    [self.collectionView reloadData];
}
#pragma mark - dataSource
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
        NSError *error;
        [[NSFileManager defaultManager] attributesOfItemAtPath:NotePath error:&error];
        if (!error) {
            _dataSource=[NSKeyedUnarchiver unarchiveObjectWithFile:NotePath];
        }
    }
    return _dataSource;
}
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame=CGRectMake(0, 0, 40, 40);
        [_rightButton setTitle:@"Edit" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
@end
