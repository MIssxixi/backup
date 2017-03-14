//
//  PushViewController.m
//  NavigationControllerTest
//
//  Created by yongjie_zou on 16/8/8.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupBackBar
{
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    backBar.imageInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.navigationItem.leftBarButtonItem = backBar;
}

- (void)pop
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
