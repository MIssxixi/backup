//
//  TEUserCache.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TEUserCache.h"
#import "TMCache.h"

NSString *const TECache_Root_Dir_Name = @"com.zouyongjie.te.cache";

@interface TEUserCache ()

@property (nonatomic, strong) TMCache *tmCache;

@end

@implementation TEUserCache

- (instancetype)init{
    //不能通过该方法初始化
    return nil;
}

- (instancetype)initWithName:(NSString *)name path:(NSString *)path{
    if(self = [super init]){
        _tmCache = [[TMCache alloc] initWithName:name rootPath:path];
    }
    return self;
}

+ (instancetype)shareCache{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *directory = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *path = [directory stringByAppendingPathComponent:@"cache"];
        NSURL *rootDir = [NSURL fileURLWithPath:path isDirectory:YES];
        [self createDirectory:rootDir shouldBackup:NO error:nil];
        sharedInstance = [[self alloc] initWithName:@"userName" path:path];
    });
    return sharedInstance;
}

+ (BOOL)createDirectory:(NSURL *)URL shouldBackup:(BOOL)shouldBackup error:(NSError **)error
{
    BOOL success = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        success = [[NSFileManager defaultManager] createDirectoryAtURL:URL
                                           withIntermediateDirectories:YES
                                                            attributes:nil
                                                                 error:error];
    }
    if (success && !shouldBackup) {
        NSError *error = nil;
        success = [URL setResourceValue:@(!shouldBackup)
                                 forKey: NSURLIsExcludedFromBackupKey error: &error];
    }
    return success;
}

- (id)objectForKey:(NSString *)key;
{
    return [self.tmCache objectForKey:key];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key;
{
    if (object) {
        [self.tmCache setObject:object forKey:key];
    }
    else
    {
        [self removeObjectForKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key;
{
    [self.tmCache removeObjectForKey:key];
}

- (void)removeAllObjects;
{
    [self.tmCache removeAllObjects];
}

@end
