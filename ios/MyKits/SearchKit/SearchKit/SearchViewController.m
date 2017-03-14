//
//  SearchViewController.m
//  SearchKit
//
//  Created by yongjie_zou on 16/7/21.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDispalyController;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 100, 50, 50);
    [button setTitle:@"go" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *dimissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dimissButton.frame = CGRectMake(50, 300, 50, 50);
    [dimissButton setTitle:@"dimiss" forState:UIControlStateNormal];
    [dimissButton addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dimissButton];
}

- (void)go
{
    [self.navigationController.view addSubview:self.searchBar];
}

- (void)dimiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UISearchDisplayController *)searchDispalyController
{
    if (!_searchDispalyController) {
        _searchDispalyController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchDispalyController.delegate = self;
        _searchDispalyController.searchResultsDelegate = self;
        _searchDispalyController.searchResultsDataSource = self;
    }
    return _searchDispalyController;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
    }
    return _searchBar;
}

@end
