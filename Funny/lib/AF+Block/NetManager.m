//
//  NetManager.m
//  test
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"

@implementation NetManager
+ (void)requestDataWithURLString:(NSString *)urlString contentType:(NSString *)type finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (type.length) {
        //json
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:type,nil];
    }else{
        //xml
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        finishedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failedBlock(error.localizedDescription);
    }];
}
@end
