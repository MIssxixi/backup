//
//  ZYJDB.h
//  ZYJSQLite
//
//  Created by yongjie_zou on 16/9/30.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import "sqlite3.h"
#import "StudentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^progressBlock)(CGFloat progress, StudentModel *student);

@interface ZYJDB : NSObject

+ (BOOL)creatStudentTable;

+ (NSArray <StudentModel *> *)getAllStudents;

+ (void)deleteStudents;

+ (void)insertStudents:(NSArray <StudentModel *> *)students progress:(progressBlock)progress useTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD;

+ (void)updateStudents:(NSArray <StudentModel *> *)students progress:(progressBlock)progress userTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD;

@end

NS_ASSUME_NONNULL_END
