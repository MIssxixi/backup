//
//  NSObject+Category.m
//  XtraceTest
//
//  Created by yongjie_zou on 16/7/19.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

static const void *tag = &tag;

@implementation NSObject (Category)

- (NSString *)categoryString
{
    return objc_getAssociatedObject(self, tag);
}

- (void)setCategoryString:(NSString *)categoryString
{
    objc_setAssociatedObject(self, tag, categoryString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
