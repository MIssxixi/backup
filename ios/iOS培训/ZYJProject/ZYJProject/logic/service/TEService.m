//
//  TEService.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TEService.h"
#import "AFNetworking.h"
#import "TEUserModel.h"
#import "TEUserManager.h"

@implementation TEService

+ (instancetype)shareInstance{
    static TEService *shareService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareService = [[self alloc] init];
    });
    return shareService;
}

- (void)login:(TEUserModel *)user callback:(serviceCallback)callback{
    NSString *url = @"http://172.21.129.244:9091/auth/login";
    NSDictionary *param = @{
                            @"account" : user.account,
                            @"password" : user.password
                            };
    [[AFHTTPSessionManager manager] POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback) {
            callback([responseObject objectForKey:@"result"], nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(nil, error.domain);
        }
    }];
}

- (void)list:(serviceCallback)callback{
    NSString *url = @"http://172.21.129.244:9091/user/classes";
    NSDictionary *param = nil;
    NSString *autoToken = [TEUserManager shareInstance].userAccount.autoToken;
    if (autoToken.length) {
        param = @{
                  @"autoToken" : autoToken
                  };
    }
    [[AFHTTPSessionManager manager] POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (callback) {
            callback([[responseObject objectForKey:@"result"] objectForKey:@"list"], nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(nil, error.domain);
        }
    }];
}

@end
