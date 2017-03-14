//
//  TEUserManager.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TEUserModel;

@interface TEUserManager : NSObject

@property (nonatomic, assign, readonly) BOOL isLogin;
@property (nonatomic, strong, readonly) TEUserModel *userAccount;

+ (instancetype)shareInstance;

- (void)setUserAccount:(TEUserModel *)userAccount;

@end
