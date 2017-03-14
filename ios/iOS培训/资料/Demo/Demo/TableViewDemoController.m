//
//  TableViewDemoController.m
//  Demo
//
//  Created by Mac_ZL on 16/8/2.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import "TableViewDemoController.h"
#import "DetailViewController.h"
#import "CustomTableViewCell.h"
@interface TableViewDemoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        //初始化
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        //设置DataSource
        [_tableView setDataSource:self];
        //设置Delegate
        [_tableView setDelegate:self];
        //设置分割线样式
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        //设置分割线颜色
        [_tableView setSeparatorColor:[UIColor redColor]];
        
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITabelView DataSource
//必须实现的有两个

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"CellIdentifier";
    CustomTableViewCell* cell =(CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    //基本样式
//    [cell.textLabel setText:[NSString stringWithFormat:@"row is %@",@(indexPath.row)]];
//    [cell.imageView setImage:[UIImage imageNamed:@"ic_good_big_gray"]];
//    [cell.detailTextLabel setText:@"今日未签到"];
//    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSString *rowInfo = [NSString stringWithFormat:@"row:%@",@(indexPath.row+1)];
    if (indexPath.row % 2 == 0)
    {
        [cell setImgName:@"ic_good_big_gray"];
        [cell setTitle:[NSString stringWithFormat:@"%@--%@",rowInfo,@"差评"]];
    }
    else
    {
        [cell setImgName:@"ic_good_big"];
        [cell setTitle:[NSString stringWithFormat:@"%@--%@",rowInfo,@"好评"]];
    }

    return cell;
}

#pragma mark - UITabelView Delegate
//优化UITableViewCell高度计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 44;
    //动态调整高度
    return [CustomTableViewCell heightForCell:indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    [vc setText:[NSString stringWithFormat:@"row is %@",@(indexPath.row+1)]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
