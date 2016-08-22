//
//  FunnyTextTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyTextTableViewCell.h"

@implementation FunnyTextTableViewCell

-(void)funnySuperOtherView{
    [self textConfigUI];
    [self textConfigOtherUI];
}

- (void)textConfigUI{
    
    UILabel *mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 65.0, WIDTH - 25.0, 0.0)];
    mainTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
    mainTextLabel.numberOfLines = 0;
    [self.contentView addSubview:mainTextLabel];
    self.mainTextLabel = mainTextLabel;
}

-(void)textConfigOtherUI{
    
}

@end
