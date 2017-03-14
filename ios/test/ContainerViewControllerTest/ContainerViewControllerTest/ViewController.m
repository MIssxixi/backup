//
//  ViewController.m
//  ContainerViewControllerTest
//
//  Created by yongjie_zou on 16/8/17.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //http://stackoverflow.com/questions/12909788/what-exactly-willmovetoparentviewcontroller-and-didmovetoparentviewcontroller
    ChildViewController *childViewController = [[ChildViewController alloc] init];
    [self.view addSubview:childViewController.view];
    [self addChildViewController:childViewController];
    [childViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
