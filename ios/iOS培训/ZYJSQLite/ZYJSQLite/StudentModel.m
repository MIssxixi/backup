//
//  StudentModel.m
//  ZYJSQLite
//
//  Created by yongjie_zou on 16/9/30.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[StudentModel class]])
    {
        return NO;
    }
    
    StudentModel *student = object;
    if (self.studentId == student.studentId)
    {
        return YES;
    }
    return NO;
}

@end
