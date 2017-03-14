//
//  ViewController.m
//  SearchKit
//
//  Created by yongjie_zou on 16/7/21.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface ViewController () <UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSString *string;

@end

@implementation ViewController

- (void)dealloc
{
    [self.navigationController removeObserver:self forKeyPath:@"viewControllers"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(200, 100, 100, 100);
    [button setTitle:@"search" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    NSString *a = @"abc";
    NSString *b = @"abc";
    
    [self.navigationController addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.string = @"dfa";
//    [self addObserver:self forKeyPath:@"string" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
}

- (void)show
{
    self.string = @"b";
//    SearchViewController *searchVC = [[SearchViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:searchVC];
//    [self presentViewController:navi animated:YES completion:nil];
////    [self presentViewController:searchVC animated:YES completion:nil];
    ViewController *viewController = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
//    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
////    searchController.searchResultsUpdater = self;
//    searchController.searchBar.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 100);
//    searchController.searchBar.text = @"fad";
//    [self.view addSubview:searchController.searchBar];
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}
@end
