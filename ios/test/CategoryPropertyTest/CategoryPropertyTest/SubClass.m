//
//  SubClass.m
//  CategoryPropertyTest
//
//  Created by yongjie_zou on 16/10/9.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "SubClass.h"
#import "SuperClass+Text.h"

@implementation SubClass

- (instancetype)init
{
    if (self = [super init])
    {
        self.text = @"text";
        NSLog(@"%@", self.text);
    }
    return self;
}

@end
