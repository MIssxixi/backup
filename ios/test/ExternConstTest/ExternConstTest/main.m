//
//  main.m
//  ExternConstTest
//
//  Created by yongjie_zou on 16/7/18.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import "Xtrace.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        extern NSString *constStringFromH;
        extern NSString *constStringFromM;
//        extern NSString * constPointerFromH;
//        constStringFromH = @"ff";
//        constStringFromH = string;
//        constPointerFromH = @"aa";
//        NSLog(@"%@", constStringFromH);
        NSLog(@"%@", constStringFromM);
//        NSLog(@"%@", constPointerFromH);
        
        NSLog(@"%@", externConstString);
        
        [TraceObj xtrace];
        [TraceObj helloWorld];
//        NSArray *array = @[@1];
//        NSArray *array1 = [NSArray arrayWithObjects:@1, nil];
        /**
         *  不能编译通过
         */
//        extern NSString *stringNotDefined;
//        NSLog(@"%@", stringNotDefined);
    }
    return 0;
}
