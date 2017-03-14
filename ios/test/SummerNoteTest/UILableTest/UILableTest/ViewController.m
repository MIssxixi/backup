//
//  ViewController.m
//  UILableTest
//
//  Created by yongjie_zou on 16/9/22.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 60)];
    label.backgroundColor = [UIColor grayColor];
    label.numberOfLines = 0;
    label.text = @"fpohowihegpoqwigj\nfhpwefhp";
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
