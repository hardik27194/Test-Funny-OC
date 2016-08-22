//
//  WalfareGirlsTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "WalfareGirlsTableViewCell.h"

@interface WalfareGirlsTableViewCell ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@end

@implementation WalfareGirlsTableViewCell

-(void)pictureConfigOtherUI{
    [self pictureSave:YES];
    UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 200.0 , 25.0)];
    creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
    [self.contentView addSubview:creatTimeLabel];
    self.creatTimeLabel = creatTimeLabel;
}

-(void)setModel:(WalfareGirlModel *)model{
    _model = model;
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:model.update_time.longLongValue];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.wbody font:USERTEXTMAINLABELFONT width:WIDTH - 20];
    self.mainTextLabel.text = model.wbody;
    self.mainTextLabel.frame = CGRectMake(10, 40, WIDTH - 20, newSize.height);
    
    CGFloat maxY = CGRectGetMaxY(self.mainTextLabel.frame);
    CGFloat scale=model.wpic_m_width.intValue / (WIDTH - 20);
    CGFloat height=model.wpic_m_height.intValue / scale;
    self.mainImageView.frame=CGRectMake(10, maxY + 5, WIDTH-20, height);
    [self.mainImageView sd_setImageWithURL:[model.wpic_middle stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    
    maxY = CGRectGetMaxY(self.mainImageView.frame);
    self.backView.height = maxY + 5;
    self.rowHeight = maxY + 10;
}

@end
