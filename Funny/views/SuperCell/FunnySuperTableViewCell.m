//
//  FunnySuperTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnySuperTableViewCell.h"

@implementation FunnySuperTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [self funnySuperConfigUI];
    }
    return self;
}

- (void)funnySuperConfigUI{
    [self funnySuperBackView];
    [self funnySuperOtherView];
}

-(void)funnySuperBackView{
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(5, 5, WIDTH-10, 0)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    self.backView = backView;
}

-(void)funnySuperOtherView{
    
}
@end
