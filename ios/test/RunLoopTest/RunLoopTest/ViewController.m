//
//  ViewController.m
//  RunLoopTest
//
//  Created by yongjie_zou on 2016/10/31.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) void(^block)();

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [self.view addSubview:self.label];

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

- (void)updateLabel
{
    static NSInteger time = 0;
    self.label.text = [NSString stringWithFormat:@"%ld", (long)time++];
    
    
//    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"Test1"
//                                                                    object:nil
//                                                                     queue:nil
//                                                                usingBlock:^(NSNotification * _Nonnull note) {
//                                                                    NSLog(@"%@", self);
//                                                                }];
//    NSLog(@"%@", observer);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
