//
//  RootViewController.m
//  NavigationControllerTest
//
//  Created by yongjie_zou on 16/8/8.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "RootViewController.h"
#import "PushViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setupBackBar];
    [self setupButton];
    [self setupLeftNavigationItem];
    [self setupRightNavigationItem];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(40, 20, 340, 44);
    searchBar.placeholder = @"fasf";
    [self.navigationController.view addSubview:searchBar];
}

- (void)setupBackBar
{
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    backBar.imageInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.navigationItem.leftBarButtonItem = backBar;
}

- (void)pop
{
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 100, 100, 100);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)push
{
    [self.navigationController pushViewController:[[PushViewController alloc] init] animated:YES];
}

- (void)setupLeftNavigationItem
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"remove" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)remove
{
    [self.navigationController.view removeFromSuperview];
}

- (void)setupRightNavigationItem
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)cancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
