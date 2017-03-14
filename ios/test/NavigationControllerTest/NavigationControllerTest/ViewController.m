//
//  ViewController.m
//  NavigationControllerTest
//
//  Created by yongjie_zou on 16/8/8.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
#import "MyNavigationControllerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupButton];
    [self setupAddButton];
}

- (void)setupButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 100);
    [button setTitle:@"fdaf" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentNavigatonController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)setupAddButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 300, 100, 100);
    [button setTitle:@"addSubview" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addNavigationController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)presentNavigatonController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] init]];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)addNavigationController
{
    self.navigationController = [[MyNavigationControllerViewController alloc] initWithRootViewController:[[RootViewController alloc] init]];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    self.navigationController.view.frame = rootViewController.view.bounds;
    self.navigationController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.frame = CGRectMake(40, 20, [UIScreen mainScreen].bounds.size.width, 44);
    self.searchBar.placeholder = @"搜索";
    self.searchBar.showsCancelButton = YES;
    
    //如果navigationController不是属性，而是局部变量，又没有调用addChildViewController方法，则界面会加进来，但是navigationController会被释放，以致于无法接受点击事件。
    [rootViewController.view addSubview:self.navigationController.view];
//    [rootViewController.view addSubview:self.searchBar];
//    [rootViewController addChildViewController:navigationController];
}

@end
