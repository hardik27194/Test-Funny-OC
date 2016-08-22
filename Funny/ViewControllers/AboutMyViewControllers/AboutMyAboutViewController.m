//
//  AboutMyAboutViewController.m
//  Funny
//
//  Created by yanzhen on 15/11/9.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "AboutMyAboutViewController.h"
#import "AboutLogo3DTouchViewController.h"
#import "NewVersonViewController.h"
#import "NSObject+General.h"

@interface AboutMyAboutViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *aboutImageView;
@property (weak, nonatomic) IBOutlet UILabel *versonLable;
@property (weak, nonatomic) IBOutlet UIImageView *versonImageV;


@end

@implementation AboutMyAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"关于";
    
    _aboutImageView.image = [UIImage imageNamedWithHZW:@"aboutFunny"];
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data.length > 0) {
        UIImage *image = [UIImage imageWithData:data];
        _aboutImageView.image = image;
    }
    _versonImageV.image = [UIImage imageNamedWithFunny:@"version"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    self.versonLable.text=version;
    [self.aboutImageView corner];
    [self registerForPreviewingWithDelegate:self sourceView:self.view];

}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _aboutImageView.image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"about"];
    NSError *error;
    [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (error) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    [data writeToFile:[filePath stringByAppendingPathComponent:@"image.data"] atomically:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)filePath{
    return [DocumentsPath stringByAppendingPathComponent:@"about/image.data"];
}


- (IBAction)longGestureAction:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:nil];
        _aboutImageView.image = [UIImage imageNamedWithHZW:@"aboutFunny"];
    }
    
}
#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    UIViewController *vc = nil;
    if (CGRectContainsPoint(_aboutImageView.frame, location)) {
        vc = [[AboutLogo3DTouchViewController alloc] init];
    }else if (CGRectContainsPoint(_versonImageV.frame, location)) {
        vc = [[NewVersonViewController alloc] init];
    }
    return vc;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}

@end
