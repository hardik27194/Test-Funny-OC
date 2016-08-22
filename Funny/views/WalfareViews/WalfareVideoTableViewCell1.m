//
//  WalfareVideoTableViewCell1.m
//  Funny
//
//  Created by yanzhen on 16/2/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "WalfareVideoTableViewCell1.h"

@interface WalfareVideoTableViewCell1 ()
@property (nonatomic, weak) UILabel *creatTimeLabel;
@property (nonatomic, weak) UILabel *mainTextLabel;
@end

@implementation WalfareVideoTableViewCell1

-(void)funnyVideoConfigOtherUI{
    UILabel *creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 200.0 , 25.0)];
    creatTimeLabel.font = [UIFont systemFontOfSize:CREATTIMELABELFONT];
    [self.contentView addSubview:creatTimeLabel];
    self.creatTimeLabel = creatTimeLabel;

    UILabel *mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 40.0, WIDTH - 20 , 0)];
    mainTextLabel.font = [UIFont systemFontOfSize:USERTEXTMAINLABELFONT];
    mainTextLabel.numberOfLines = 0;
    [self.contentView addSubview:mainTextLabel];
    self.mainTextLabel = mainTextLabel;
}

-(void)setModel:(WalfareVideoModel *)model{
    _model = model;
    self.creatTimeLabel.text = [NSString dateWithTimeInterval:model.update_time.longLongValue];
    
    CGSize newSize = [[GlobalManage shareGlobalManage] labelSize:model.wbody font:USERTEXTMAINLABELFONT width:WIDTH - 20];
    self.shareTitle = self.mainTextLabel.text = model.wbody;
    self.shareURL = model.vsource_url;
    self.mainTextLabel.frame = CGRectMake(10, 40, WIDTH - 20, newSize.height);
    
    CGFloat maxY = CGRectGetMaxY(self.mainTextLabel.frame);
    self.mainImageView.frame = CGRectMake(10, maxY + 5, WIDTH - 20, (WIDTH-20)*3/4);
    [self.mainImageView sd_setImageWithURL:[model.vpic_small stringToURL] placeholderImage:[GlobalManage shareGlobalManage].bigImage];
    self.playBtn.frame = CGRectMake(self.mainImageView.maxX - 70, self.mainImageView.maxY - 62, 70, 62);
    maxY = self.mainImageView.maxY;
    self.progressView.frame = CGRectMake(10, maxY, WIDTH - 20, 2);
    self.backView.height = maxY + 7;
    self.rowHeight = maxY + 12;
}

@end
