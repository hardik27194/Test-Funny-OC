//
//  FunnyVideoTableViewCell.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "FunnyVideoTableViewCell.h"
#import "WXApi.h"

#define BUFFER_SIZE 1024 * 100
#define YZLABELFONT 14
@implementation FunnyVideoTableViewCell

-(BOOL)refresh{
    return self.playBtn.selected || self.isPause;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILongPressGestureRecognizer *l = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
        [self addGestureRecognizer:l];
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
        [self addGestureRecognizer:pin];
    }
    return self;
}

- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    if (pin.state == UIGestureRecognizerStateBegan) {
        if (self.playBtn.selected || self.isPause) {
            if ([_delegate respondsToSelector:@selector(playVideoOnWindow:)]) {
                [_delegate playVideoOnWindow:self];
            }
        }
    }
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)l{
    if (l.state == UIGestureRecognizerStateBegan) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.shareTitle ? self.shareTitle : @"搞笑视频";
        NSData *data = UIImageJPEGRepresentation(self.mainImageView.image, 0.3);
        //不做无限压缩
        CGFloat scale = 0.2;
        for (int i = 0; i < 3; i++) {
            scale *= 0.5;
            if (data.length / 1000 > 16) {
                data = UIImageJPEGRepresentation(self.mainImageView.image, scale);
            }else{
                break;
            }
        }
        UIImage *image = [UIImage imageWithData:data];
        if (data.length / 1000 > 17) {
            image = [UIImage imageNamedWithFunny:@"play"];
        }
        [message setThumbImage:image];
        
        WXVideoObject *ext = [WXVideoObject object];
        ext.videoUrl = self.shareURL ? self.shareURL : @"http://www.baidu.com";
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    }
}

-(void)funnySuperOtherView{
    [self funnyVideoConfigUI];
    [self funnyVideoConfigOtherUI];
}

- (void)funnyVideoConfigUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, WIDTH - 20, 0)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    self.mainImageView = imageView;
    
    UIButton * playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    playBtn.backgroundColor = [UIColor clearColor];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"play_start"] forState:UIControlStateNormal];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"play_pause"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:playBtn];
    self.playBtn = playBtn;
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainImageView.frame), WIDTH - 20, 2)];
    progressView.progressTintColor = YZColor(255, 155, 23);
    progressView.progress = 0.0;
    [self.contentView addSubview:progressView];
    self.progressView = progressView;
}

- (void)playBtnClick{
    self.playBtn.selected = !self.playBtn.selected;
//    if ([self.delegate respondsToSelector:@selector(videoStartPlay:)]) {
//        [self.delegate videoStartPlay:self];
//    }
    if ([_delegate respondsToSelector:@selector(videoPlay:videoCell:)]) {
        [_delegate videoPlay:self.playBtn.selected videoCell:self];
    }
}

-(void)funnyVideoConfigOtherUI{
    
}

@end
