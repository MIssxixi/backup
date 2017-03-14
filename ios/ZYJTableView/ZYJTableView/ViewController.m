//
//  ViewController.m
//  ZYJTableView
//
//  Created by yongjie_zou on 16/8/3.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ZYJTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <ZYJTableViewCellModel *>*dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZYJTableViewCell alloc] init];
    }
    [cell updateWithModel:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZYJTableViewCell heightWithModel:self.dataArray[indexPath.row]];
}


#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
        [_tableView registerClass:[ZYJTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray <ZYJTableViewCellModel *> *)dataArray
{
    if (!_dataArray) {
        ZYJTableViewCellModel *model1 = [[ZYJTableViewCellModel alloc] init];
        //如果是“精”＋“全字母”显示会分行显示，原因不明
        model1.titleString = @"【热点】跟谁学CEO陈向东确认参加全球社会企业家生态论坛";
        model1.detailString = @"2016（第二届）全球社会企业家生态论坛将于2016年9月9日在俄哦佛问";
        model1.sourceString = @"教培圈新闻姐 2016-08－02 09:16:25";
        model1.supportCount = 134987952;
        model1.commentCount = 145237409;
        
        ZYJTableViewCellModel *model2 = [[ZYJTableViewCellModel alloc] init];
        model2.titleString = @"机构用户产品反馈qq群：492109023";
        model2.detailString = @"在跟谁学成立2周年之际，感谢一路以来支持跟谁学的老用户老朋友们，我们的成长离不开";
        model2.sourceString = @"跟谁学机构服务  2016-07-29 17:38:21";
        model2.supportCount = 0;
        model2.commentCount = 0;
        
        ZYJTableViewCellModel *model3 = [[ZYJTableViewCellModel alloc] init];
        model3.titleString = @"收藏！百万高考过来人总结的15条高三定律｜附新高三一轮复习安排";
        model3.detailString = @"小编说16高考已经结束，17高考还会远吗？如果您的孩子对过完高呢";
        model3.sourceString = @"北京高考  2016－07-29 16:52:29";
        model3.supportCount = 2;
        model3.commentCount = 0;
        
        ZYJTableViewCellModel *model4 = [[ZYJTableViewCellModel alloc] init];
        model4.titleString = @"【改革早知道！】2017年起北京将调整少数民族考生加分项目&中考改革新方案细则说明饿发我IE放假哦我";
        model4.detailString = @"关于2017年中考改革目前具体加分比例、实施细则还在研究当中了";
        model4.sourceString = @"北京中考  2016－07-30 17:39:28";
        model4.supportCount = 2;
        model4.commentCount = 0;
        
        ZYJTableViewCellModel *model5 = [[ZYJTableViewCellModel alloc] init];
        model5.titleString = @"测试一下";
        model5.detailString = @"就一行";
        model5.sourceString = @"武研 2016-08-03 14:23:00";
        model5.supportCount = 93284;
        model5.commentCount = 89;
        _dataArray = @[model1, model2, model3, model4, model5];
    }
    return _dataArray;
}

@end
