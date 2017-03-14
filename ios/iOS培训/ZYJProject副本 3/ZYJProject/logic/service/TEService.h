//
//  TEService.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TEUserModel;

typedef void(^serviceCallback)(id response, NSString *errorMessage);

@interface TEService : NSObject

+ (instancetype)shareInstance;

- (void)login:(TEUserModel *)user callback:(serviceCallback)callback;

- (void)list:(serviceCallback)callback;

@end
