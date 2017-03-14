//
//  TEMyLiveViewController.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TEMyLiveViewController.h"
#import "Masonry.h"
#import "TEMyLiveViewCell.h"
#import "TEConst.h"
#import "MJRefresh.h"
#import "TEService.h"
#import "TELiveClassModel.h"
#import "TETip.h"

static NSString * const TEMyLiveViewCellIdentifer = @"TEMyLiveViewCellIdentifer";

@interface TEMyLiveViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <TELiveClassModel *> *dataArray;

@end

@implementation TEMyLiveViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupSubviews{
    [self.view addSubview:self.tableView];
    
    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - network
- (void)refresh{
    WS(weakSelf)
    [[TEService shareInstance] list:^(id response, NSString *errorMessage) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (errorMessage.length) {
            [TETip show:errorMessage];
            return ;
        }
        [weakSelf.dataArray removeAllObjects];
        NSArray *array = [MTLJSONAdapter modelsOfClass:[TELiveClassModel class] fromJSONArray:response error:nil];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        weakSelf.tableView.mj_footer.hidden = NO;
    }];
}

- (void)getMore{
    WS(weakSelf)
    [[TEService shareInstance] list:^(id response, NSString *errorMessage) {
        [weakSelf.tableView.mj_footer endRefreshing];
        if (errorMessage.length) {
            [TETip show:errorMessage];
            return ;
        }
        NSArray *array = [MTLJSONAdapter modelsOfClass:[TELiveClassModel class] fromJSONArray:response error:nil];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TEMyLiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEMyLiveViewCellIdentifer forIndexPath:indexPath];
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

#pragma mark - get
- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = TE_COLOR(@"f0f0f0");
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[TEMyLiveViewCell class] forCellReuseIdentifier:TEMyLiveViewCellIdentifer];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

- (NSMutableArray <TELiveClassModel *> *)dataArray{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
