//
//  NEContentTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/20.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "NEContentTableViewCell.h"

@implementation NEContentTableViewCell
{
    UIView *_backView;
    UILabel *_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = YZColor(246, 246, 246);
        [self confUI];
    }
    return self;
}
- (void)confUI
{
    _backView=[[UIView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, 0)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_backView];
    //
    _label=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, WIDTH-30, 0)];
    _label.numberOfLines=0;
    _label.font=[UIFont systemFontOfSize:17];
    [_backView addSubview:_label];
    
}

-(void)setModel:(NetEaseDefaultModel *)model
{
    _model=model;
    _label.text=model.digest;
    CGSize oldSize=CGSizeMake(_label.frame.size.width, 9999);
    CGSize newSize=[model.digest boundingRectWithSize:oldSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _label.frame=CGRectMake(5, 5, WIDTH-30, newSize.height);
    _backView.frame=CGRectMake(10, 10, WIDTH-20, newSize.height+10);
    _rowHeight=CGRectGetMaxY(_backView.frame)+10;
}
@end
