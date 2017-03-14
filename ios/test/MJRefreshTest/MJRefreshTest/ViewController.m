//
//  ViewController.m
//  MJRefreshTest
//
//  Created by yongjie_zou on 16/8/6.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.tableView.mj_header.hidden = NO;
    [self.tableView.mj_header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        
    });
}

- (void)refresh
{
    self.count = 20;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = @"fqwiefhpqwihefpowqjefop";
    cell.textLabel.font = [UIFont systemFontOfSize:60];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

@end
