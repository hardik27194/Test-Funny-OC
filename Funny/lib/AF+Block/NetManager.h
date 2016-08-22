//
//  NetManager.h
//  Y&Z
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define JSON @"application/json"
//#define XMLL @"text/html"
typedef void(^GetDataFinishedBlock)(id responseObj);
typedef void(^GetDataFailedBlock)(NSString *error);

@interface NetManager : NSObject
/**
 * @brief Get请求的方法
 *
 * @param urlString           网址
 * @param type                数据类型(application/json,text/html)
 XML类型传nil
 * @param finishedBlock       请求成功
 * @param GetDataFailedBlock  请求失败
 *
 * @return NO
 */
+ (void)requestDataWithURLString:(NSString *)urlString contentType:(NSString *)type finished:(GetDataFinishedBlock)finishedBlock failed:(GetDataFailedBlock)failedBlock;
@end
