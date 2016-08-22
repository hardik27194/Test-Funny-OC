//
//  SinaVideoSuperViewController.h
//  Funny
//
//  Created by yanzhen on 15/10/21.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperThirdViewController.h"

#define SinaVideoCell @"SinaVideoCell"
#define SinaVideoHeight 275
@interface SinaVideoSuperViewController : SuperThirdViewController
@property (nonatomic, copy) NSString *titleName;
@property (strong, nonatomic) UIImageView *layerImageView;
@end
