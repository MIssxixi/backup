//
//  ViewController.m
//  BlockTest
//
//  Created by yongjie_zou on 2017/3/3.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self exampleB];
    
}

- (void) exampleB_addBlockToArray:(NSMutableArray *)array {
    char b = 'B';
    NSObject *a = [NSObject new];
    [array addObject:a];
//    [array addObject:^{
//        printf("%cn", b);
//    }];
}

- (void) exampleB {
    NSMutableArray *array = [NSMutableArray array];
    [self exampleB_addBlockToArray:array];
    NSLog(@"%@", [array objectAtIndex:0]);
//    void (^block)() = [array objectAtIndex:0];
//    block();
}

@end
