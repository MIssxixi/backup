//
//  test.m
//  SynthesizeTest
//
//  Created by yongjie_zou on 16/7/5.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "Test.h"

@interface Test()

@property (nonatomic, copy) NSString *normalString;
@property (nonatomic, copy, readonly) NSString *readonlyString;

@end


@implementation Test
@synthesize normalString = _normalString;           //同时重写getter和setter时，编译器不再自动合成

- (void)function
{
    self.normalString = @"abc";
    NSLog(@"%@", self.normalString);
}

#pragma mark- normalString
- (void)setNormalString:(NSString *)string
{
    _normalString = string;
}

- (NSString *)normalString
{
    return _normalString;
}

#pragma mark- readonlyString


@end
