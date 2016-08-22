//
//  SuperSecondViewController.m
//  Funny
//
//  Created by yanzhen on 15/9/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SuperSecondViewController.h"
#import "AboutMyViewController.h"
#import "SuperSecondTableViewCell.h"
#import "AddImageView.h"
#import "MBProgressHUD+YZZ.h"
#import "RectangularView.h"
#import "ShotPartScreenView.h"
#import <YZUIKit/YZUIKit.h>
#import "AppDelegate.h"

@interface SuperSecondViewController ()<PartShotDelegate,YZCircularMenuDelegate>
@property (strong, nonatomic) AddImageView *addSecondImageView;
@property (nonatomic, strong) RectangularView *rView;
@property (nonatomic, strong) ShotPartScreenView *shotPartView;
@property (nonatomic, strong) YZActionSheet *sheet;
@end

@implementation SuperSecondViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setHidesBottomBarWhenPushed:NO];
    if (self.addSecondImageView) {
        [self superTapAction];
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self superTapAction];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self superTapAction];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *superTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(superTapAction)];
    superTap.numberOfTouchesRequired=2;
    superTap.delegate=self;
    [self.view addGestureRecognizer:superTap];
    [self confUI1];
    
    
}
- (void)superTapAction
{
    if (self.addSecondImageView.isAddImageViewHidden) {
        return;
    }else{
        [self secondButtonAction];
    }
}

- (void)confUI1
{
    UIImage *menuItemImage = [UIImage imageNamedWithFunny:@"menu_bg"];
    YZCircularMenuItem *(^block)(NSString *contentImageName) = ^(NSString *contentImageName){
        return [[YZCircularMenuItem alloc] initWithImage:menuItemImage
                                                                     highlightedImage:nil
                                                                         ContentImage:[UIImage imageNamedWithFunny:contentImageName]
                                                              highlightedContentImage:nil];
    };
    NSArray *menuItems = @[block(@"shotPart"),block(@"home"),block(@"exit"),block(@"my")];
    
    YZCircularMenuItem *startItem = [[YZCircularMenuItem alloc] initWithImage:[UIImage imageNamedWithFunny:@"menu"]
                                                       highlightedImage:nil
                                                           ContentImage:[UIImage imageNamedWithFunny:@"plus"]
                                                highlightedContentImage:[UIImage imageNamedWithFunny:@"plusHL"]];
    
    YZCircularMenu *menu = [[YZCircularMenu alloc] initWithFrame:CGRectMake(0, HEIGHT - 200 - 49, 200, 200) startItem:startItem startPoint:CGPointMake(20, 180) menuWholeAngle:M_PI_2 menuItems:menuItems];
    menu.delegate = self;
    menu.alpha = 0.5;
    [self.view addSubview:menu];
}

- (void)superAboutMy{
    return;
}

- (void)secondButtonAction
{
    [self.addSecondImageView toggleAddImageView];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self superTapAction];
}
#pragma mark - YZCircularMenuDelegate
-(void)yZCircularMenu:(YZCircularMenu *)menu didSelectIndex:(NSInteger)index{
    menu.alpha = 0.5;
    if (0 == index) {
        [self shotPart];
    }else if (1 == index){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (2 == index){
        AppDelegate *appDelegate = SharedAppDelegate;
        [self.sheet showInView:appDelegate.window];
    }else if (3 == index){
        AboutMyViewController *avc=[[AboutMyViewController alloc] init];
        avc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:avc animated:YES];
    }
}

-(void)yZCircularMenuWillAnimateOpen:(YZCircularMenu *)menu{
    menu.alpha = 1.0;
}

-(void)yZCircularMenuWillAnimateClose:(YZCircularMenu *)menu{
    menu.alpha = 0.5;
}

- (void)shotPart
{
//    UIActionSheet* sheet=[[UIActionSheet alloc] initWithTitle:@"部分截图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"方式一",@"方式二", nil];
//    [sheet showInView:self.view];
    [self.view addSubview:self.shotPartView];
}
//截屏
- (void)screenshot
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    [self.view.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    //[[GlobalManage shareGlobalManage] saveImage:newImage];
    [self testImage:newImage frame:CGRectMake(0, 0, WIDTH, HEIGHT-64-49)];
}
- (void)screenShotPart:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self testImage:newImage frame:frame];
    
}

- (void)testImage:(UIImage *)oldImage frame:(CGRect)frame
{
    CGFloat scale=[UIScreen mainScreen].scale;
    frame.origin.x*=scale;
    frame.origin.y*=scale;
    frame.size.width*=scale;
    frame.size.height*=scale;
    CGImageRef imageRef = oldImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(frame.origin.x, frame.origin.y+64*scale, frame.size.width, frame.size.height));
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, frame, subImageRef);
    UIImage* newImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext(); //返回裁剪的部分图像
    [[GlobalManage shareGlobalManage] saveImage:newImage];

}
#pragma mark - shot delegate
- (void)shotOrNotShot:(BOOL)shot frame:(CGRect)frame
{
    [self.rView removeFromSuperview];
    self.rView=nil;
    if (shot) {
        [self screenShotPart:frame];
    }
}
- (void)shotPartView:(BOOL)shot frame:(CGRect)frame
{
    [self.shotPartView removeFromSuperview];
    self.shotPartView=nil;
    if (shot) {
        [self screenShotPart:frame];
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    //NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
#pragma mark - lazy var

-(YZActionSheet *)sheet{
    if (!_sheet) {
        YZActionSheetItem *titleItem = [[YZActionSheetItem alloc] initWithTitle:@"退出程序" color:nil font:0];
        YZActionSheetItem *item = [[YZActionSheetItem alloc] initWithTitle:@"确定" color:nil font:0];
        _sheet = [[YZActionSheet alloc] initWithTitle:titleItem cancelItem:nil actionItems:@[item] didSelect:^(NSInteger index) {
            if (index == 1) {
                exit(0);
            }
        }];
    }
    return _sheet;
}

- (ShotPartScreenView *)shotPartView
{
    if (!_shotPartView) {
        _shotPartView=[[ShotPartScreenView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-64-49)];
        __weak SuperSecondViewController *blockSelf=self;
        _shotPartView.block=^(BOOL shot,CGRect rect){
            [blockSelf shotPartView:shot frame:rect];
        };
    }
    return _shotPartView;
}
- (RectangularView *)rView
{
    if (!_rView) {
        _rView=[[RectangularView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
        _rView.backgroundColor=[UIColor clearColor];
        _rView.delegate=self;
    }
    return _rView;
}

@end
