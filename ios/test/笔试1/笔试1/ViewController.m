//
//  ViewController.m
//  笔试1
//
//  Created by yongjie_zou on 2017/3/6.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [self convertIPFromString:@"3a6b7ab5a10b"]);
}

- (NSString *)convertIPFromString:(NSString *)string{
    NSUInteger total = 0;   //IP地址对应的32位二进制数
    NSUInteger index = 0;   //转化二进制数的位置
    NSUInteger number = 0;  //输入字符串中的数字
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
                total |= (0xffffffff >> (32 - number)) << (32 - index);
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
    
    NSString *IP = [NSString new];
    if (index == 32) {
        IP = [NSString stringWithFormat:@"%lu.%lu.%lu.%lu", (total >> 24) & 0xff, (total >> 16) & 0xff, (total >> 8) & 0xff, total & 0xff];
    } else {
        IP = @"输入格式错误";
    }
    return IP;
}


//- (NSString *)convertIPFromString:(NSString *)string{
//    NSUInteger total = 0;   //IP地址对应的32位二进制数
//    NSUInteger index = 0;   //转化二进制数的位置
//    NSUInteger number = 0;  //输入字符串中的数字
//    NSInteger i = 0;
//    for (; i < string.length; i++) {
//        NSString *tempChar = [string substringWithRange:NSMakeRange(i, 1)];
//        if ([tempChar isEqualToString:@"a"]) {
//            if (number == 0) {
//                index++;
//            } else {
//                index += number;
//            }
//            number = 0;
//        } else if ([tempChar isEqualToString:@"b"]) {
//            if (number == 0) {
//                index++;
//                total |= 1 << (32 - index);
//            } else {
//                index += number;
//                total |= (0xffffffff >> (32 - number)) << (32 - index);
//            }
//            number = 0;
//        } else {
//            if (number == 0) {
//                number = tempChar.integerValue;
//            } else {
//                number = number * 10 + tempChar.integerValue;
//            }
//        }
//    }
//    
//    NSString *IP = [NSString new];
//    if (index == 32) {
//        IP = [NSString stringWithFormat:@"%lu.%lu.%lu.%lu", (total >> 24) & 0xff, (total >> 16) & 0xff, (total >> 8) & 0xff, total & 0xff];
//    } else {
//        IP = @"输入格式错误";
//    }
//    return IP;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
