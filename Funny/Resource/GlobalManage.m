//
//  GlobalManage.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "GlobalManage.h"
#import "MBProgressHUD+YZZ.h"

@implementation GlobalManage
MShareInstance(GlobalManage);
-(CGSize)labelSize:(NSString *)text font:(CGFloat)font width:(CGFloat)width{
    CGSize oldSize = CGSizeMake(width, MAXFLOAT);
    return [text boundingRectWithSize:oldSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}

-(void)clearCache{
    SDWebImageManager *manage=[SDWebImageManager sharedManager];
    [manage cancelAll];
    [manage.imageCache clearMemory];
    [manage.imageCache clearDisk];
    
    
    NSArray *pathcaches=NSSearchPathForDirectoriesInDomains(NSCachesDirectory
                                                            , NSUserDomainMask
                                                            , YES);
    NSString* cacheDirectory  = [pathcaches objectAtIndex:0];
    
    NSFileManager *m = [NSFileManager defaultManager];
    [m removeItemAtPath:cacheDirectory error:nil];
}

#pragma mark - saveImage
-(UIImage *)headImage{
    return [UIImage imageNamedWithHZW:@"大熊_2"];
}

-(UIImage *)bigImage{
    return [UIImage imageNamedWithHZW:@"大熊_1"];
}

-(void)saveImage:(UIImage *)image{
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != nil) {
        [MBProgressHUD showMessage:@"保存失败" success:NO stringColor:[UIColor redColor]];
    }else{
        [MBProgressHUD showMessage:@"已保存到相册" success:YES stringColor:[UIColor redColor]];
    }
}
@end
