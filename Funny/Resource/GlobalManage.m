//
//  GlobalManage.m
//  Funny
//
//  Created by yanzhen on 16/2/2.
//  Copyright © 2016年 yanzhen. All rights reserved.
//

#import "GlobalManage.h"
#import "MBProgressHUD+YZZ.h"
#import <mach/mach.h>

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
#pragma mark - CPU占用率
- (float)cpu_usage
{
    kern_return_t			kr = { 0 };
    task_info_data_t		tinfo = { 0 };
    mach_msg_type_number_t	task_info_count = TASK_INFO_MAX;
    
    kr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    task_basic_info_t		basic_info = { 0 };
    thread_array_t			thread_list = { 0 };
    mach_msg_type_number_t	thread_count = { 0 };
    
    thread_info_data_t		thinfo = { 0 };
    thread_basic_info_t		basic_info_th = { 0 };
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads( mach_task_self(), &thread_list, &thread_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    long	tot_sec = 0;
    long	tot_usec = 0;
    float	tot_cpu = 0;
    
    for ( int i = 0; i < thread_count; i++ )
    {
        mach_msg_type_number_t thread_info_count = THREAD_INFO_MAX;
        
        kr = thread_info( thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count );
        if ( KERN_SUCCESS != kr )
            return 0.0f;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if ( 0 == (basic_info_th->flags & TH_FLAGS_IDLE) )
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
    
    kr = vm_deallocate( mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t) );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    return tot_cpu;
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
