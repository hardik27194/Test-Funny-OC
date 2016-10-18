//
//  RootViewController.m
//  Funny
//
//  Created by yanzhen on 16/6/3.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "RootViewController.h"
#import "FunnyDeclareViewController.h"
#import "IconButton.h"
#import <YZUIKit/YZTransition.h>

@interface RootViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic) NSArray *imagesNameArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (nonatomic, strong) YZTransition *transition;
@end

@implementation RootViewController

static NSString *AppNameVC[] = {
    [kApp_Content]         = @"ContentTabBarViewController",
    [kApp_GifShow]         = @"GifShowTabBarViewController",
    [kApp_BuDeJie]         = @"BuDeJieTabBarViewController",
    [kApp_Walfare]         = @"WalfareTabBarViewController",
    [kApp_UCNews]          = @"UCNewsTabBarViewController",
    [kApp_NetEaseNews]     = @"NetEaseTabBarViewController",
    [kApp_SinaNews]        = @"SinaNewsTabBarViewController",
    [kApp_SinaVideo]       = @"SinaVideoTabBartViewController",
    [kApp_Secret]          = @"SecretFirstViewController",
    [kApp_DrawPictures]    = @"DrawPictureViewController",
    [kApp_Note]            = @"NoteLockViewController",
    [kApp_QRCode]          = @"QRHeadViewController",
};

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSData *data = [NSData dataWithContentsOfFile:HOMEIMAGEPATH];
    if (data.length > 0) {
        UIImage *image = [UIImage imageWithData:data];
        _imageView.image = image;
    }else{
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud objectForKey:HOMEBACKGROUNDIMAGENAME]) {
            _imageView.image = [UIImage imageNamed:[ud objectForKey:HOMEBACKGROUNDIMAGENAME]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Y&Z Area";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configUI];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

- (void)configUI{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imageView];
    for (NSInteger i=0; i<self.imagesNameArray.count; i++) {
        NSInteger x=i%4;
        NSInteger y=i/4;
        CGFloat spaceX=(WIDTH-240)/5.0;
        IconButton *button = [IconButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(spaceX+(spaceX+60)*x, 64+20+100*y, 60, 90);
        button.tag=100+i;
        UIImage *image = [[UIImage imageNamed:self.imagesNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [_scrollView addSubview:button];
    }
}

- (void)selectedBtn:(NSInteger)tag{
    [self intoVC:tag];
}

- (void)buttonAction:(UIButton *)button
{
    [self intoVC:button.tag];
}

- (void)intoVC:(NSInteger)tag{
    UIViewController *vc = nil;
    NSString *className = AppNameVC[tag];
    if (tag < kApp_Secret) {
        vc = [[NSClassFromString(className) alloc] init];
    }else{
        UIViewController *svc = [[NSClassFromString(className) alloc] init];
        vc = [[UINavigationController alloc] initWithRootViewController:svc];
    }
    vc.modalPresentationStyle = UIModalPresentationCustom;
    _transition = [[YZTransition alloc] init];
    _transition.type = YZTransitionTypeCustom;
    vc.transitioningDelegate = _transition;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    UIViewController *vc = nil;
    //UIScrollView 含有其他控件
    for (UIView *iconBtn in _scrollView.subviews) {
        if ([iconBtn isKindOfClass:[IconButton class]]) {
            if (CGRectContainsPoint(iconBtn.frame, location)) {
                vc = [[FunnyDeclareViewController alloc] initWithTag:iconBtn.tag rootVC:self];
            }
        }
    }
    return vc;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    //[self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - action
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _imageView.image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"homeBackGroundImage"];
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    [data writeToFile:HOMEIMAGEPATH atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray *)titleArray{
    if (!_titleArray) {
         _titleArray=[[NSArray alloc] initWithObjects:@"内涵段子",@"快手",@"不得姐",@"福利社",@"UC新闻",@"网易新闻",@"新浪新闻",@"新浪视频",@"Area",@"画图",@"Note",@"二维码", nil];
    }
    return _titleArray;
}

-(NSArray *)imagesNameArray{
    if (!_imagesNameArray) {
        _imagesNameArray=[[NSArray alloc]initWithObjects:@"content",@"gifShow",@"budejie",@"walfare",@"uc",@"netease",@"sina",@"sina",@"secret",@"drawPicture",@"note",@"QR", nil];
    }
    return _imagesNameArray;
}

@end
