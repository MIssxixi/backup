//
//  ZYJNetwork.h
//  ZYJNetwork
//
//  Created by yongjie_zou on 16/9/23.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYJNetworkConfig;
@class ZYJRequest;

NS_ASSUME_NONNULL_BEGIN

/**
 *  网络请求结束回调
 *
 *  @param request  请求头
 *  @param data     返回结果
 *  @param response 返回数据
 *  @param error    出错信息
 */
typedef void(^ZYJNetworkBackBlock)(NSURLRequest *request, NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);

/**
 *  下载/上传进度回调
 *
 *  @param bytesWritten       本次下载／上传字节数
 *  @param totalBytesWritten  下载／上传总字节数
 *  @param totalBytesExpected 预计下载／上传总字节数
 */
typedef void(^ZYJProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpected);

@interface ZYJNetwork : NSObject

+ (instancetype)sharedInstance;

- (void)setConfig:(ZYJNetworkConfig *)config;

- (void)get:(NSString *)url parameters:(nullable NSDictionary *)parameters resultBack:(nullable ZYJNetworkBackBlock)resultBack;

- (void)post:(NSString *)url parameters:(nullable NSDictionary *)parameters resultBack:(nullable ZYJNetworkBackBlock)resultBack;

- (ZYJRequest *)download:(NSString *)url parameters:(nullable NSDictionary *)parameters fileDownPath:(NSString *)fileDownPath progress:(nullable ZYJProgressBlock)progressBlock resultBack:(nullable ZYJNetworkBackBlock)resultBack;

- (void)upload:(NSString *)url parameters:(nullable NSDictionary *)parameters formData:(NSData *)data fromPath:(NSString *)path progress:(nullable ZYJProgressBlock)progress resultBack:(nullable ZYJNetworkBackBlock)resultBack;

@end

NS_ASSUME_NONNULL_END