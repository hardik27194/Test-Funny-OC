//
//  WalfareTextTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "WalfareTextTableViewCell1.h"

@interface WalfareTextTableViewCell1 ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@end
@implementation WalfareTextTableViewCell1

-(void)textConfigOtherUI{
    UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 200.0 , 25.0)];
    creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
    [self.contentView addSubview:creatTimeLabel];
    self.creatTimeLabel = creatTimeLabel;
}

-(void)setModel:(WalfareTextModel *)model{
    _model = model;
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:model.update_time.longLongValue];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.wbody font:USERTEXTMAINLABELFONT width:WIDTH - 20];
    self.mainTextLabel.text = model.wbody;
    self.mainTextLabel.frame = CGRectMake(10, 40, WIDTH - 20, newSize.height);
    
    CGFloat maxY = CGRectGetMaxY(self.mainTextLabel.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 10;
}

@end
