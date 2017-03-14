//
//  TEUserCache.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEUserCache : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)shareCache;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(nullable id <NSCoding>)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

NS_ASSUME_NONNULL_END

@end
