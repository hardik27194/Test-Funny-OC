//
//  AddImageView.m
//  Funny
//
//  Created by yanzhen on 15/9/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AddImageView.h"
#import "SuperSecondTableViewCell.h"

#define AddTableViewRowHeight 45
@interface AddImageView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *titleSecondArray;
@property (strong, nonatomic) UITableView *addSecondTableView;
@end
@implementation AddImageView
- (NSArray *)titleSecondArray{
    if (!_titleSecondArray) {
        _titleSecondArray=[[NSArray alloc] initWithObjects:@"全屏截图",@"部分截图",@"主页面",@"退出", nil];
    }
    return _titleSecondArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.isAddImageViewHidden=YES;
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        self.clipsToBounds=YES;
        UIImage *imageSecond=[UIImage imageNamedWithFunny:@"addView"];
        UIEdgeInsets insetsSecond = UIEdgeInsetsMake(40, 15 , 30 , 15 );
        self.image=[imageSecond resizableImageWithCapInsets:insetsSecond resizingMode:UIImageResizingModeStretch];
        _addSecondTableView=[[UITableView alloc] initWithFrame:CGRectMake(1, 5, 108, self.titleSecondArray.count*AddTableViewRowHeight)];
        _addSecondTableView.rowHeight=AddTableViewRowHeight;
        _addSecondTableView.delegate=self;
        _addSecondTableView.dataSource=self;
        _addSecondTableView.scrollsToTop=NO;
        _addSecondTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _addSecondTableView.backgroundColor=[UIColor clearColor];
        [self addSubview:_addSecondTableView];
    }
    return self;
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleSecondArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuperSecondTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"addSecondTableViewCell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SuperSecondTableViewCell" owner:self options:nil] lastObject];
    }
    cell.titleSecondLabel.text=self.titleSecondArray[indexPath.row];
    if (indexPath.row == self.titleSecondArray.count-1) {
        cell.bottomSecondImageView.hidden=YES;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self toggleAddImageView];
    if ([_delegate respondsToSelector:@selector(selectAtTableView:)]) {
        [_delegate selectAtTableView:indexPath.row];
    }
}
#pragma mark - animation
- (void)toggleAddImageView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height=0;
        if (self.isAddImageViewHidden) {
            height=self.titleSecondArray.count*AddTableViewRowHeight+2;
        }
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    } completion:^(BOOL finished) {
        self.isAddImageViewHidden=!self.isAddImageViewHidden;
    }];
}
@end
