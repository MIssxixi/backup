//
//  ViewController.m
//  AutoreleaseTest
//
//  Created by yongjie_zou on 16/10/29.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//__weak id reference = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *str = nil;
//    @autoreleasepool {
//        str = [NSString stringWithFormat:@"test"];
//    }
//    NSString *str = @"test";
//    reference = str;
    
    for (NSInteger i = 0; i < 500000; i++) {
        @autoreleasepool {
//            NSString *string1 = [NSString stringWithFormat:@"test1:%ld", i];
//            NSString *string2 = [NSString stringWithFormat:@"test2:%ld", i];
            
            NSString *string1 = [[NSString alloc] initWithFormat:@"test1:%ld", i];
            NSString *string2 = [[NSString alloc] initWithFormat:@"test2:%ld", i];
//            NSNumber *number = @(i);
            
            NSLog(@"%ld:%@ %@ ", i, string1, string2);
        }
    }
//    NSLog(@"%@", str);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    NSLog(@"%@", reference);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    NSLog(@"%@", reference);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
