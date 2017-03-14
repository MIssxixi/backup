//
//  ViewController.m
//  TableViewHeightTest
//
//  Created by yongjie_zou on 2016/12/10.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
