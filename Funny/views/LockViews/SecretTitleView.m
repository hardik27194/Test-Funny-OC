//
//  SecretTitleView.m
//  Funny
//
//  Created by yanzhen on 15/10/29.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretTitleView.h"

@interface SecretTitleView ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UITableView *tableView;
@end
@implementation SecretTitleView
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self=[super initWithFrame:frame];
    if (self) {
        self.titleArray=titleArray;
        _isSecretTitleViewHidden=YES;
        self.clipsToBounds=YES;
        [self confUI];
       
    }
    return self;
}
- (void)confUI
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 132)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=44;
    [self addSubview:_tableView];
}
#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SecretTitleCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecretTitleCell"];
    }
    cell.textLabel.text=_titleArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectAtIndexPath: indexPath:)]) {
        [_delegate didSelectAtIndexPath:_titleArray[indexPath.row] indexPath:indexPath];
        [self toggleSecretTitleView];
    }
}
#pragma mark - view
- (void)toggleSecretTitleView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height=0;
        if (self.isSecretTitleViewHidden) {
            height=132;
        }
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    } completion:^(BOOL finished) {
        self.isSecretTitleViewHidden=!self.isSecretTitleViewHidden;
    }];

}
@end
