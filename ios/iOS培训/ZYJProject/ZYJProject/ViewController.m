//
//  ViewController.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "TEConst.h"
#import "Masonry.h"
#import "TMCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:button];
    WS(weakSelf)
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
}

- (void)go
{
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

@end
