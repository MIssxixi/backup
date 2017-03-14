//
//  ViewController.m
//  TableViewInScrollViewTest
//
//  Created by yongjie_zou on 2017/2/16.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.tableView];
    
    __weak __typeof(&*self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(weakSelf.scrollView);
        make.height.mas_equalTo(weakSelf.view.mas_height).multipliedBy(1.5);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).mas_offset(40);
        make.left.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom);
        make.left.bottom.right.equalTo(weakSelf.contentView);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - get
- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor greenColor];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 40);
    }
    return _scrollView;
}

- (UIView *)contentView{
    if (!_contentView){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)headerView{
    if (!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 40)];
        _headerView.backgroundColor = [UIColor orangeColor];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height - 80)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
