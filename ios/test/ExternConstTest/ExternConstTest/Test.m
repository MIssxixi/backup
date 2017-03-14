//
//  Test.m
//  ExternConstTest
//
//  Created by yongjie_zou on 16/7/18.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "Test.h"

const NSString *constStringFromM = @"const string from .m";

NSString *const externConstString = @"extern const string";

void f();

void f()
{
    
}

@implementation TraceObj

+ (void)helloWorld
{
    NSLog(@"hellow World");
}

@end