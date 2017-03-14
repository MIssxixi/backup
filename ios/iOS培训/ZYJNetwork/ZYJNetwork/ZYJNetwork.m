//
//  ZYJNetwork.m
//  ZYJNetwork
//
//  Created by yongjie_zou on 16/9/23.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ZYJNetwork.h"
#import "ZYJNetworkConfig.h"
#import "ZYJRequest.h"

@interface ZYJNetwork () <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) ZYJNetworkConfig *config;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;

@property (nonatomic, strong) NSMutableArray <ZYJRequest *> *requestArray;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation ZYJNetwork

- (instancetype)init
{
    static ZYJNetwork *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}

#pragma mark - public method
- (void)setConfig:(ZYJNetworkConfig *)config
{
    self.config = config;
}

- (void)get:(NSString *)url parameters:(NSDictionary *)parameters resultBack:(ZYJNetworkBackBlock)resultBack
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET" url:url parameters:parameters resultBack:resultBack];
    [dataTask resume];
}

- (void)post:(NSString *)url parameters:(NSDictionary *)parameters resultBack:(ZYJNetworkBackBlock)resultBack
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" url:url parameters:parameters resultBack:resultBack];
    [dataTask resume];
}
- (ZYJRequest *)download:(NSString *)url parameters:(NSDictionary *)parameters fileDownPath:(NSString *)fileDownPath progress:(ZYJProgressBlock)progressBlock resultBack:(ZYJNetworkBackBlock)resultBack
{
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:mRequest];
    [downloadTask resume];
    
    ZYJRequest *zyjRequest = [[ZYJRequest alloc] initWithTask:downloadTask session:session progress:progressBlock resultBlock:resultBack filePath:fileDownPath];
    [self.requestArray addObject:zyjRequest];
    
    return zyjRequest;
}

- (void)upload:(NSString *)url parameters:(nullable NSDictionary *)parameters formData:(NSData *)data fromPath:(NSString *)filePath  progress:(ZYJProgressBlock)progress resultBack:(ZYJNetworkBackBlock)resultBack
{
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    mRequest.HTTPMethod = @"POST";
    NSMutableData *bodyData = [NSMutableData data];
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    NSString *contentDispose = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type:image/png\r\n\r\n", boundary, @"file", @"tianxiao.jpg"];
    [bodyData appendData:[contentDispose dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:data];
    [bodyData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    mRequest.HTTPBody = bodyData;
    [mRequest setValue:contentType forHTTPHeaderField:@"Content-type"];
    [mRequest setValue:[NSString stringWithFormat:@"%lu", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:mRequest fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (resultBack)
        {
            resultBack(mRequest, data, response, error);
        }
    }];
    
    [uploadTask resume];
}

- (void)appendData:(NSMutableData *)data withName:(NSString *)name value:(NSString *)value boundary:(NSString *)boundary
{
    NSString *str = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, name, value];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - private method
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method url:(NSString *)urlString parameters:(id)parameters resultBack:(ZYJNetworkBackBlock)resultBack
{
    NSParameterAssert(method);
    NSParameterAssert(urlString);
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in parameters)
    {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:parameters[key]]];
    }
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = queryItems;
    
    NSParameterAssert(components);
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    mRequest.HTTPMethod = method;
    
    if ([[method uppercaseString] isEqualToString:@"GET"])
    {
        mRequest.URL = components.URL;
    }
    else if ([[method uppercaseString] isEqualToString:@"POST"])
    {
        if (![mRequest valueForHTTPHeaderField:@"Content-Type"]) {
            [mRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        [mRequest setHTTPBody:[components.query dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (resultBack)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                resultBack(mRequest, data, response, error);
            });
        }
    }];
    return dataTask;
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    for (ZYJRequest *request in self.requestArray)
    {
        if (request.requestId == task.taskIdentifier)
        {
            request.resultBack(task.currentRequest, nil, nil, error);
        }
    }
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    for (ZYJRequest *request in self.requestArray)
    {
        if (request.requestId == downloadTask.taskIdentifier)
        {
            NSData *data = [NSData dataWithContentsOfURL:location];
            [data writeToFile:request.filePath atomically:YES];
            request.resultBack(downloadTask.currentRequest, nil, downloadTask.response, nil);
        }
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    for (ZYJRequest *request in self.requestArray)
    {
        if (request.requestId == downloadTask.taskIdentifier)
        {
            if (request.progress)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                request.progress(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
                });
            }
        }
    }
}

#pragma mark - get
- (NSURLSessionConfiguration *)sessionConfig
{
    if (!_sessionConfig)
    {
        _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionConfig.timeoutIntervalForRequest = self.config.timeOut;
    }
    return _sessionConfig;
}

- (NSMutableArray <ZYJRequest *> *)requestArray
{
    if (!_requestArray)
    {
        _requestArray = [NSMutableArray array];
    }
    return _requestArray;
}

@end
