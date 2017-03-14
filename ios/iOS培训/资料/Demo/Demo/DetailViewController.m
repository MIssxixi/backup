//
//  DetailViewController.m
//  Demo
//
//  Created by Mac_ZL on 16/8/2.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:self.text];
    [self.view addSubview:label];
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
