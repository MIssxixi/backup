//
//  ChildViewController.m
//  ContainerViewControllerTest
//
//  Created by yongjie_zou on 16/8/17.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(100, 100, 100, 100);
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
