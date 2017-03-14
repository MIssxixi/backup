//
//  main.m
//  笔试
//
//  Created by yongjie_zou on 2017/3/6.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *string = @"5a27b";
        NSString *IP = [NSString new];
        NSUInteger total = 0;
        NSUInteger index = 0;
        NSUInteger number = 0;
        NSInteger i = 0;
        for (; i < string.length; i++) {
            NSString *tempChar = [string substringWithRange:NSMakeRange(i, 1)];
            if ([tempChar isEqualToString:@"a"]) {
                if (number == 0) {
                    index++;
                } else {
                    index += number;
                }
                number = 0;
            } else if ([tempChar isEqualToString:@"b"]) {
                if (number == 0) {
                    index++;
                    total |= 1 << (32 - index);
                } else {
                    index += number;
                    total |= ((1 << (number + 1)) - 1) << (32 - index);
//                    total |= (4294967295 >> (32 - number)) << (32 - index);
                }
                number = 0;
            } else {
                if (number == 0) {
                    number = tempChar.integerValue;
                } else {
                    number = number * 10 + tempChar.integerValue;
                }
            }
        }
        
        IP = [NSString stringWithFormat:@"%lu.%lu.%lu.%lu", (total >> 24) & 225, (total >> 16) & 225, (total >> 8) & 225, total & 225];
        NSLog(@"%@", IP);
        
//        NSArray *constArray = @[@(1), @(3), @(7), @(15), @(31), @(63), @(127), @(255)];
//        NSInteger i = string.length - 1;
//        NSInteger byteCount = 0;
//        NSInteger byteNumber = 0;
//        for (; i >= 0; i++) {
//            NSString *tempChar = [string substringWithRange:NSMakeRange(i, 1)];
//            if ([tempChar isEqualToString:@"a"]){
//                continue;
//            } else if ([tempChar isEqualToString:@"b"]) {
//                
//            } else {
//                NSInteger number = tempChar.integerValue;
//                NSInteger quotient = (byteCount + number) / 8;
//                if (quotient > 0) {
//                    byteNumber += ((NSNumber *)constArray[number]).integerValue * (8 - byteCount);
//                    byteCount = (byteCount + number) % 8;
//                } else {
//                    byteNumber += ((NSNumber *)constArray[number]).integerValue * number;
//                    byteCount += number;
//                }
//            }
//        }
    }
    return 0;
}
//
//- (NSString *)stringConvertToIP:(NSString *)string {
//    
//}


