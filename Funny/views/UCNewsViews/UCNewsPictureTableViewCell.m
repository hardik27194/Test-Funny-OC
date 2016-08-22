//
//  UCNewsPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/19.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "UCNewsPictureTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface UCNewsPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *onlyImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
@implementation UCNewsPictureTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = YZColor(246, 246, 246);
    }
    return self;
}
-(void)setModel:(UCNewsModel *)model
{
    _model=model;
    _titleLabel.text=model.title;
    long long time=model.publish_time.longLongValue/1000;
    NSString *bottomString=[NSString dateWithTimeInterval:time];
    bottomString=[bottomString stringByAppendingString:@"    "];
    bottomString=[bottomString stringByAppendingString:model.origin_src_name];
    _bottomLabel.text=bottomString;
    //
    UIImage *image=[[UIImage imageNamedWithHZW:@"small"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSArray *array=model.thumbnails;
    NSDictionary *dict1=array[0];
    [_onlyImageView sd_setImageWithURL:[NSURL URLWithString:dict1[@"url"]] placeholderImage:image];
   
}

@end
