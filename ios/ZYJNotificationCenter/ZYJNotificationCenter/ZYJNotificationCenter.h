//
//  ZYJNotificationCenter.h
//  ZYJNotificationCenter
//
//  Created by yongjie_zou on 16/8/1.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYJNotificationCenter : NSObject

+ (ZYJNotificationCenter *)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)postNotification:(NSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block NS_AVAILABLE(10_6, 4_0);

@end

NS_ASSUME_NONNULL_END