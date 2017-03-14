//
//  TEUserManager.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TEUserManager.h"
#import "TEUserModel.h"
#import "TEUserCache.h"

static NSString * const TEUserAccountKey = @"TEUserAccountKey";
static NSString * const TEIsLoginKey = @"TEIsLoginKey";

@interface TEUserManager ()

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) TEUserModel *userAccount;
@property (nonatomic, strong) TEUserCache *userCache;

@end

@implementation TEUserManager

- (instancetype)init{
    if (self = [super init]) {
        _userAccount = [[TEUserCache shareCache] objectForKey:TEUserAccountKey];
        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:TEIsLoginKey];
        _isLogin = number.boolValue;
    }
    return self;
}

+ (instancetype)shareInstance{
    static TEUserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (void)setUserAccount:(TEUserModel *)userAccount{
    _userAccount = userAccount;
    if (userAccount) {
        self.isLogin = YES;
        [[TEUserCache shareCache] setObject:userAccount forKey:TEUserAccountKey];
    }
    else{
        self.isLogin = NO;
        [[TEUserCache shareCache] removeObjectForKey:TEUserAccountKey];
    }
}

- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    [[NSUserDefaults standardUserDefaults] setObject:@(isLogin) forKey:TEIsLoginKey];
}

@end
