//
//  ViewController.m
//  SearchTest
//
//  Created by yongjie_zou on 16/8/18.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearch];
}

- (void)setupButton
{
    
}

- (void)setupSearch
{
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.active = YES;
    [self.view addSubview:searchController.searchBar];
//    [self presentViewController:searchController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
