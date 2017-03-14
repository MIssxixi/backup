//
//  ViewController.m
//  TableHeaderViewAutolayoutTest
//
//  Created by yongjie_zou on 2017/1/10.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
