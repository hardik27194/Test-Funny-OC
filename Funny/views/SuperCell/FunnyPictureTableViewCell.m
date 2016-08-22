//
//  FunnyPictureTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyPictureTableViewCell.h"

@implementation FunnyPictureTableViewCell

-(void)funnySuperOtherView{
    [self pictureConfigUI];
    [self pictureConfigOtherUI];
}

- (void)pictureConfigUI{
    UILabel *mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0)];
    mainTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
    mainTextLabel.numberOfLines = 0;
    [self.contentView addSubview:mainTextLabel];
    self.mainTextLabel = mainTextLabel;
    
    UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.mainTextLabel.frame), WIDTH - 25, 0)];
    [self.contentView addSubview:mainImageView];
    mainImageView.userInteractionEnabled = YES;
    self.mainImageView = mainImageView;
}

- (void)pictureConfigOtherUI{
    
}

#pragma mark - saveImage
- (void)pictureSave:(BOOL)isSave{
    if (isSave) {
        UILongPressGestureRecognizer *l = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        tap.numberOfTouchesRequired = 2;
        [self.mainImageView addGestureRecognizer:l];
    }
}

- (void)tapAction:(UILongPressGestureRecognizer *)l
{
    if (l.state == UIGestureRecognizerStateBegan) {
        UIImageView *tapView=(UIImageView *)l.view;
        [[GlobalManage shareGlobalManage] saveImage:tapView.image];
    }
}


@end
