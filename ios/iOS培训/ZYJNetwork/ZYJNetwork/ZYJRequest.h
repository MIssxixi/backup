//
//  ZYJRequest.h
//  ZYJNetwork
//
//  Created by yongjie_zou on 16/9/29.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYJNetwork.h"

@interface ZYJRequest : NSObject

- (instancetype)initWithTask:(NSURLSessionTask *)task;
- (instancetype)initWithTask:(NSURLSessionTask *)task session:(NSURLSession *)session progress:(ZYJProgressBlock)progress resultBlock:(ZYJNetworkBackBlock)result filePath:(NSString *)filePath;

@property (nonatomic, assign, readonly) NSUInteger requestId;
@property (nonatomic, copy, readonly) ZYJProgressBlock progress;
@property (nonatomic, copy, readonly) ZYJNetworkBackBlock resultBack;
@property (nonatomic, copy, readonly) NSString *filePath;

- (void)pause;

- (void)resume;

- (void)cancel;

@end
