//
//  TimeObject.m
//  TimerTest
//
//  Created by yongjie_zou on 2017/2/27.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "TimeObject.h"

@interface HWWeakTimerTarget : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSTimer* timer;

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

@end

@implementation HWWeakTimerTarget
- (void) fire:(NSTimer *)timer {
    if(self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats {
    HWWeakTimerTarget* timerTarget = [[HWWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;
}

@end

@implementation TimeObject

- (void)dealloc {
    
}

- (instancetype)init {
    self = [super init];
    __weak typeof(self) weakSelf = self;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(log) userInfo:nil repeats:NO];
//    NSTimer *target = [HWWeakTimerTarget scheduledTimerWithTimeInterval:0 target:self selector:@selector(log) userInfo:nil repeats:YES];
    return self;
}

- (void)log {
    NSLog(@"time");
}

@end
