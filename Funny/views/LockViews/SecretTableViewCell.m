//
//  SecretTableViewCell.m
//  Funny
//
//  Created by yanzhen on 15/10/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretTableViewCell.h"

@interface SecretTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@end
@implementation SecretTableViewCell

-(void)setModel:(SecretModel *)model
{
    _model=model;
    NSString *account=[model.company stringByAppendingString:@" : "];
    _accountLabel.text=[account stringByAppendingString:model.account];
    NSString *password=[model.password stringByAppendingString:@"    "];
    _passwordLabel.text=[password stringByAppendingString:model.remarks];
    UIImage *image=[[UIImage imageNamedWithHZW:@"大熊_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_headImageView corner];
    _headImageView.image=image;
}





- (void)awakeFromNib {
    // Initialization code
    //self.backgroundColor=YZColor(246, 246, 246);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
