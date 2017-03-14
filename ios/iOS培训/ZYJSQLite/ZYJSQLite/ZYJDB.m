//
//  ZYJDB.m
//  ZYJSQLite
//
//  Created by yongjie_zou on 16/9/30.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ZYJDB.h"

@interface ZYJDB ()

@end

@implementation ZYJDB

static sqlite3 *db = nil;

+ (sqlite3 *)open
{
    /**
     *  数据库已经打开
     */
    if (db)
    {
        return db;
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *sqlPath = [documentPath stringByAppendingPathComponent:@"ZYJDB.sqlite"];
    
    if(sqlite3_open([sqlPath UTF8String], &db) == SQLITE_OK)
    {
        return db;
    }
    else
    {
        return nil;
    }
    
}

+ (void)close
{
    sqlite3_close(db);
    db = nil;
}

+ (BOOL)creatStudentTable
{
    NSString *sql = @"create table if not exists student (studentId integer primary key, studentName text not null)";
    sqlite3 *tempDB = [ZYJDB open];
    NSInteger result = sqlite3_exec(tempDB, sql.UTF8String, nil, nil, nil);
    [ZYJDB close];
    return result == SQLITE_OK;
}

+ (StudentModel *)getStudentWithId:(NSInteger)studentId
{
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    StudentModel *student = nil;
    
    NSString *sql = @"select studentName from student where studentId = ?";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, (int)studentId);
        
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            student = [StudentModel new];
            student.studentId = studentId;
            student.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(stmt, 0)];
        }
    }
    
    sqlite3_finalize(stmt);
    
    return student;
}

+ (NSArray <StudentModel *> *)getAllStudents
{
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    NSMutableArray <StudentModel *> *students = [NSMutableArray array];
    
    NSString *sql = @"select * from student";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            StudentModel *student = [StudentModel new];
            student.studentId = sqlite3_column_int(stmt, 0);
            student.name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding];
            [students addObject:student];
        }
    }
    
    sqlite3_finalize(stmt);
    
    return students;
}

+ (BOOL)insertStudent:(StudentModel *)student
{
    @synchronized (self) {
    
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    NSString *sql = @"insert into student values(?,?)";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, (int)student.studentId);
        sqlite3_bind_text(stmt, 2, student.name.UTF8String, -1, nil);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    
    return result;
    }
}

+ (BOOL)updateStudent:(StudentModel *)student
{
    @synchronized (self) {
    
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    NSString *sql = @"update student set studentName = ? where studentId = ?";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, student.name.UTF8String, -1, nil);
        sqlite3_bind_int(stmt, 2, (int)student.studentId);
        
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    return result;
    }
}

+ (void)deleteStudentWithId:(NSInteger)studentId
{
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    NSString *sql = @"delete from student where studentId = ?";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_int(stmt, 1, (int)studentId);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
}

+ (void)deleteStudents
{
    sqlite3 *tempDB = [ZYJDB open];
    sqlite3_stmt *stmt = nil;
    
    NSString *sql = @"delete from student";
    NSInteger result = sqlite3_prepare_v2(tempDB, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
}

+ (void)insertStudents:(NSArray<StudentModel *> *)students progress:(progressBlock)progress useTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD
{
    if (students.count < 1)
    {
        return;
    }
    
    NSDictionary *params = @{
                             @"students" : students,
                             @"progress" : progress,
                             @"useTransaction" : [NSNumber numberWithBool:useTransaction],
                             @"useGCD" : [NSNumber numberWithBool:useGCD]
                             };
    if (useGCD)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self insertStudentsMethod:params];
        });
    }
    else
    {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(insertStudentsMethod:) object:params];
        [thread start];
//        [NSThread detachNewThreadSelector:@selector(insertStudentsMethod:) toTarget:self withObject:params];
    }
}

+ (void)updateStudents:(NSArray<StudentModel *> *)students progress:(progressBlock)progress userTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD
{
    if (students.count < 1)
    {
        return;
    }
    
    NSDictionary *params = @{
                             @"students" : students,
                             @"progress" : progress,
                             @"useTransaction" : [NSNumber numberWithBool:useTransaction],
                             @"useGCD" : [NSNumber numberWithBool:useGCD]
                             };
    if (useGCD)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self updateStudentsMethod:params];
        });
    }
    else
    {
        [NSThread detachNewThreadSelector:@selector(updateStudentsMethod:) toTarget:self withObject:params];
    }
}

#pragma mark - thread method
+ (void)insertStudentsMethod:(NSDictionary *)dictionary
{
    NSMutableArray <StudentModel *> *students = [dictionary objectForKey:@"students"];
    progressBlock progress = [dictionary objectForKey:@"progress"];
    BOOL useTransaction = [[dictionary objectForKey:@"useTransaction"] boolValue];
    BOOL useGCD = [[dictionary objectForKey:@"useGCD"] boolValue];
    if (useTransaction)
    {
        char *errorMsg;
        sqlite3 *tempDB = [ZYJDB open];
        if (sqlite3_exec(tempDB, "BEGIN", NULL, NULL, &errorMsg) == SQLITE_OK)
        {
            NSInteger count = students.count;
            for (NSInteger index = 0; index < count; index++)
            {
                StudentModel *student = students[index];
                [self insertStudent:student];
                if (progress)
                {
                    if (useGCD)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            progress(100.0 * (index + 1) / count, student);
                        });
                    }
                    else
                    {
                        NSDictionary *params = @{
                                                 @"progress" : progress,
                                                 @"progressFloat" :[NSNumber numberWithFloat:100.0 * (index + 1) / count],
                                                 @"student" : student
                                                };
                        [self performSelectorOnMainThread:@selector(updateUI:) withObject:params waitUntilDone:NO];
                    }
                }
            }
            if (sqlite3_exec(tempDB, "COMMIT", NULL, NULL, NULL) == SQLITE_OK)
            {
                
            }
        }
    }
    else
    {
        NSInteger count = students.count;
        for (NSInteger index = 0; index < count; index++)
        {
            StudentModel *student = students[index];
            
            [self insertStudent:student];
            if (progress)
            {
                if (useGCD)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        progress(100.0 * (index + 1) / count, student);
                    });
                }
                else
                {
                    NSDictionary *params = @{
                                             @"progress" : progress,
                                             @"progressFloat" :[NSNumber numberWithFloat:100.0 * (index + 1) / count],
                                             @"student" : student
                                             };
                    [self performSelectorOnMainThread:@selector(updateUI:) withObject:params waitUntilDone:NO];
                }
            }
        }
    }
}

+ (void)updateUI:(NSDictionary *)dictionary
{
    progressBlock progress = [dictionary objectForKey:@"progress"];
    CGFloat progressFloat = [[dictionary objectForKey:@"progressFloat"] floatValue];
    StudentModel *student = [dictionary objectForKey:@"student"];
    progress(progressFloat, student);
    if (progressFloat > 99.99)
    {
        [[NSThread currentThread] cancel];
    }
}

+ (void)updateStudentsMethod:(NSDictionary *)dictionary
{
    NSMutableArray <StudentModel *> *students = [dictionary objectForKey:@"students"];
    progressBlock progress = [dictionary objectForKey:@"progress"];
    BOOL useTransaction = [[dictionary objectForKey:@"useTransaction"] boolValue];
    BOOL useGCD = [[dictionary objectForKey:@"useGCD"] boolValue];
    if (useTransaction)
    {
        char *errorMsg;
        sqlite3 *tempDB = [ZYJDB open];
        if (sqlite3_exec(tempDB, "BEGIN", NULL, NULL, &errorMsg) == SQLITE_OK)
        {
            NSInteger count = students.count;
            for (NSInteger index = 0; index < count; index++)
            {
                StudentModel *student = students[index];
                [self updateStudent:student];
                
                if (progress)
                {
                    if (useGCD)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            progress(100.0 * (index + 1) / count, student);
                        });
                    }
                    else
                    {
                        NSDictionary *params = @{
                                                 @"progress" : progress,
                                                 @"progressFloat" :[NSNumber numberWithFloat:100.0 * (index + 1) / count],
                                                 @"student" : student
                                                 };
                        [self performSelectorOnMainThread:@selector(updateUI:) withObject:params waitUntilDone:NO];
                    }
                }
            }
            if (sqlite3_exec(tempDB, "COMMIT", NULL, NULL, NULL) == SQLITE_OK)
            {
                
            }
        }
    }
    else
    {
        NSInteger count = students.count;
        for (NSInteger index = 0; index < count; index++)
        {
            StudentModel *student = students[index];
            [self updateStudent:student];
            
            if (progress)
            {
                if (useGCD)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        progress(100.0 * (index + 1) / count, student);
                    });
                }
                else
                {
                    NSDictionary *params = @{
                                             @"progress" : progress,
                                             @"progressFloat" :[NSNumber numberWithFloat:100.0 * (index + 1) / count],
                                             @"student" : student
                                             };
                    [self performSelectorOnMainThread:@selector(updateUI:) withObject:params waitUntilDone:NO];
                }
            }
        }
    }
}

@end
