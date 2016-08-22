//
//  DrawPictureViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/30.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "DrawPictureViewController.h"
#import "DrawPicturePaintView.h"
#import "DrawPictureImageView.h"
#import "NSObject+General.h"
#import "MBProgressHUD+YZZ.h"

@interface DrawPictureViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawPicturePaintView *paintView;
@property (strong, nonatomic) DrawPictureImageView *dpView;
@end

@implementation DrawPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"画图";
}
#pragma mark - toolBar action
- (IBAction)cancel:(id)sender {
    [_paintView undo];
}
- (IBAction)clear:(id)sender {
    [_paintView clearScreen];
}
- (IBAction)eraser:(id)sender {
    _paintView.color = [UIColor whiteColor];
}
- (IBAction)photo:(id)sender {
    [self clear:nil];
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
- (IBAction)drawInPicture:(id)sender {
    if (_dpView) {
        [_dpView drawInPictureStart];
    }
}

- (IBAction)save:(id)sender {
    if (![_paintView isDrawInView]) {
        [MBProgressHUD showError:@"您没进行任何操作"];
        return;
    }
    UIImage *newImage = [UIImage imageWithCaptureView:_paintView];
    [[GlobalManage shareGlobalManage] saveImage:newImage];
    
}
#pragma mark - imagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    //_paintView.image=image;
    _dpView=[[DrawPictureImageView alloc] initWithFrame:_paintView.frame];
    __block DrawPictureViewController *blockSelf=self;
    _dpView.block=^(UIImage *image){
        blockSelf.paintView.image=image;
    };
    _dpView.image=image;
    [self.view addSubview:_dpView];
    _paintView.color=[UIColor blackColor];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - bottomView action
- (IBAction)sliderChange:(UISlider *)sender {
    _paintView.width=sender.value;
}
- (IBAction)colorButtonClick:(UIButton *)sender {
    _paintView.color=sender.backgroundColor;
}


@end
