//
//  ViewController.m
//  TimerTest
//
//  Created by yongjie_zou on 2017/2/27.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "TimeObject.h"

@interface ViewController ()

@property (nonatomic, strong) TimeObject *time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TimeObject *time = [TimeObject new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
