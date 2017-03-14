//
//  ViewController.m
//  SessionTest
//
//  Created by yongjie_zou on 16/7/20.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView
    [self get];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/p/fafc67475c73"];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        NSLog(@"%@", data);
    }];
    
    [task resume];
}

@end
