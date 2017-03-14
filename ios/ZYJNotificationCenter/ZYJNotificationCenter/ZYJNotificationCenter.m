//
//  ZYJNotificationCenter.m
//  ZYJNotificationCenter
//
//  Created by yongjie_zou on 16/8/1.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ZYJNotificationCenter.h"

@interface ObserverModel : NSObject

@property (nonatomic, copy) NSString *selector;
@property (nonatomic, strong) id observer;
@property (nonatomic, strong) id object;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, copy) void (^block)(NSNotification *note);

@end

@implementation ObserverModel


@end


@interface ZYJNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary <NSString *,NSMutableArray *> *observerDictionary;

@end

@implementation ZYJNotificationCenter

+ (ZYJNotificationCenter *)defaultCenter
{
    static ZYJNotificationCenter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super alloc] init];
    });
    return sharedInstance;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    NSMutableArray *observerArray = [self.observerDictionary valueForKey:aName];
    if (!observerArray) {
        observerArray = [NSMutableArray new];
        [self.observerDictionary setValue:observerArray forKey:aName];
    }
    
    ObserverModel *model = [ObserverModel new];
    model.selector = NSStringFromSelector(aSelector);
    model.observer = observer;
    model.object = anObject;
    
    [observerArray addObject:model];
}

- (id <NSObject>)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification * _Nonnull))block
{
    NSMutableArray *observerArray = [self.observerDictionary valueForKey:name];
    if (!observerArray) {
        observerArray = [NSMutableArray new];
        [self.observerDictionary setValue:observerArray forKey:name];
    }
    ObserverModel *model = [ObserverModel new];
    model.observer = [ObserverModel new];
    model.object = obj;
    model.queue = queue;
    model.block = block;
    [observerArray addObject:model];
    return model.observer;
}

- (void)postNotification:(NSNotification *)notification
{
    [self postNotificationName:notification.name object:notification.object userInfo:notification.userInfo];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    [self postNotificationName:aName object:anObject userInfo:nil];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    NSMutableArray *observerArray = [self.observerDictionary valueForKey:aName];
    if (!observerArray) {
        return;
    }
    
    if (anObject) {
        for (ObserverModel *model in observerArray) {
            if (model.object == anObject && [model.observer respondsToSelector:NSSelectorFromString(model.selector)]) {
                if ([model.selector containsString:@":"]) {
                    NSNotification *notification = [[NSNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
                    [model.observer performSelector:NSSelectorFromString(model.selector) withObject:notification];
                }
                else
                {
                    [model.observer performSelector:NSSelectorFromString(model.selector)];
                }
            }
            else if (model.object == anObject && model.block)
            {
                NSNotification *tempNotification = [[NSNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
                [model.queue addOperationWithBlock:^{
                    model.block(tempNotification);
                }];
            }
        }
    }
    else
    {
        for (ObserverModel *model in observerArray) {
            if (!model.object && [model.observer respondsToSelector:NSSelectorFromString(model.selector)]) {
                if ([model.selector containsString:@":"]) {
                    NSNotification *notification = [[NSNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
                    [model.observer performSelector:NSSelectorFromString(model.selector) withObject:notification];
                }
                else
                {
                    [model.observer performSelector:NSSelectorFromString(model.selector)];
                }
            }
            else if (model.block)
            {
                NSNotification *tempNotification = [[NSNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
                [model.queue addOperationWithBlock:^{
                    model.block(tempNotification);
                }];
            }
        }
    }
}

- (void)removeObserver:(id)observer
{
    [self removeObserver:observer name:nil object:nil];
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    if (!observer) {
        return;
    }
    
    if (aName) {
        NSMutableArray *observerArray = [self.observerDictionary valueForKey:aName];
        NSMutableIndexSet *tempSet = [NSMutableIndexSet new];
        for (ObserverModel *model in observerArray) {
            if (model.observer == observer) {
                if (anObject && model.object == anObject) {
                    [tempSet addIndex:[observerArray indexOfObject:model]];
                }
                else
                {
                    [tempSet addIndex:[observerArray indexOfObject:model]];
                }
            }
        }
        [observerArray removeObjectsAtIndexes:tempSet];
    }
    else
    {
        for (NSMutableArray *observerArray in [self.observerDictionary allValues]) {
            NSMutableIndexSet *tempSet = [NSMutableIndexSet new];
            for (ObserverModel *model in observerArray) {
                if (model.observer == observer) {
                    if (anObject && model.object == anObject) {
                        [tempSet addIndex:[observerArray indexOfObject:model]];
                    }
                    else
                    {
                        [tempSet addIndex:[observerArray indexOfObject:model]];
                    }
                }
            }
            [observerArray removeObjectsAtIndexes:tempSet];
        }
    }
}

#pragma mark - get

- (NSMutableDictionary *)observerDictionary
{
    if (!_observerDictionary) {
        _observerDictionary = [NSMutableDictionary new];
    }
    return _observerDictionary;
}

@end
