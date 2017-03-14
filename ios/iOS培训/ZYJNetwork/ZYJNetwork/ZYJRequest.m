//
//  ZYJRequest.m
//  ZYJNetwork
//
//  Created by yongjie_zou on 16/9/29.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ZYJRequest.h"

@interface ZYJRequest ()

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) ZYJProgressBlock progress;
@property (nonatomic, copy) ZYJNetworkBackBlock resultBack;
@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, strong) NSData *resumeData;

@end

@implementation ZYJRequest

- (instancetype)initWithTask:(NSURLSessionTask *)task
{
    if (self = [super init])
    {
        self.task = task;
    }
    return self;
}

- (instancetype)initWithTask:(NSURLSessionTask *)task session:(NSURLSession *)session progress:(ZYJProgressBlock)progress resultBlock:(ZYJNetworkBackBlock)result filePath:(NSString *)filePath
{
    self = [self initWithTask:task];
    if (self)
    {
        self.session = session;
        self.progress = progress;
        self.resultBack = result;
        self.filePath = filePath;
    }
    return self;
}

- (void)pause
{
    __weak typeof(self) weakself = self;
    if ([self.task isKindOfClass:[NSURLSessionDownloadTask class]])
    {
        NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask *)self.task;
        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            weakself.resumeData = resumeData;
            [weakself.task suspend];
        }];
    }
}

- (void)resume
{
    if ([self.task isKindOfClass:[NSURLSessionDownloadTask class]])
    {
        self.task = [self.session downloadTaskWithResumeData:_resumeData];
        [self.task resume];
        self.resumeData = nil;
    }
}

- (void)cancel
{
    [self.task cancel];
}

#pragma mark - get
- (NSUInteger)requestId
{
    return self.task.taskIdentifier;
}

@end
