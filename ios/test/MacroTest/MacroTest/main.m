//
//  main.m
//  MacroTest
//
//  Created by yongjie_zou on 2017/1/19.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define add(a,b,c) [NSString stringWithFormat:@"%d-%d-%d", a,  c]
#define test(a,b) add(a,,b)

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSLog(@"%@", test(1, 3));
    }
    return 0;
}
