//
//  main.m
//  BundleTest
//
//  Created by yongjie_zou on 16/7/20.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *allBundles = [NSBundle allBundles];
        NSString *path = [mainBundle pathForResource:@"main" ofType:@"m"];
        NSString *path1 = [mainBundle pathForResource:@"image" ofType:@"png"];
//        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@", mainBundle);
    }
    return 0;
}
