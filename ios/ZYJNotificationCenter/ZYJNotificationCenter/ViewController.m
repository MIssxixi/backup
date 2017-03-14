//
//  ViewController.m
//  ZYJNotificationCenter
//
//  Created by yongjie_zou on 16/8/1.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ZYJNotificationCenter.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UILabel *forNameLabel;

@property (nonatomic, copy) NSMutableArray *forNameObserverArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *addObserverButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addObserverButton.frame = CGRectMake(0, 50, 100, 50);
    [addObserverButton setTitle:@"addObserver" forState:UIControlStateNormal];
    [addObserverButton addTarget:self action:@selector(addObserver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addObserverButton];
    
    UIButton *removerObserverButton = [UIButton buttonWithType:UIButtonTypeSystem];
    removerObserverButton.frame = CGRectMake(150, 50, 150, 50);
    [removerObserverButton setTitle:@"removeObserver" forState:UIControlStateNormal];
    [removerObserverButton addTarget:self action:@selector(removeObserver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removerObserverButton];
    
    UIButton *sendNotificationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sendNotificationButton.frame = CGRectMake(0, 100, 150, 50);
    [sendNotificationButton setTitle:@"send notification" forState:UIControlStateNormal];
    [sendNotificationButton addTarget:self action:@selector(sendNotification) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendNotificationButton];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, screenWidth, 50)];
    [self.view addSubview:self.label];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 50)];
    [self.view addSubview:self.myLabel];
    
    self.forNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, screenWidth, 50)];
    [self.view addSubview:self.forNameLabel];
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"testNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testWithParameter:) name:@"testNotification" object:nil];
    
    [[ZYJNotificationCenter defaultCenter] addObserver:self selector:@selector(myTest) name:@"myNotification" object:self];
    [[ZYJNotificationCenter defaultCenter] addObserver:self selector:@selector(myTest) name:@"myNotification" object:self];
    id observer = [[ZYJNotificationCenter defaultCenter] addObserverForName:@"myNotification" object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        static NSInteger receiveCount = 1;
        self.forNameLabel.text = [NSString stringWithFormat:@"my addObserverForName : receive %ld times", (long)receiveCount];
        receiveCount++;
    }];
    [self.forNameObserverArray addObject:observer];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[ZYJNotificationCenter defaultCenter] removeObserver:self];
    for (id observer in self.forNameObserverArray) {
        [[ZYJNotificationCenter defaultCenter] removeObserver:observer];
    }
}

- (void)sendNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:nil];
    
    [[ZYJNotificationCenter defaultCenter] postNotificationName:@"myNotification" object:self];
}

- (void)test:(NSNotification *)notification
{
    static NSInteger receiveCount = 1;
    self.label.text = [NSString stringWithFormat:@"system addObserver : receive %ld times", (long)receiveCount];
    receiveCount++;
}

- (void)myTest
{
    static NSInteger receiveCount = 1;
    self.myLabel.text = [NSString stringWithFormat:@"my addObserver : receive %ld times", (long)receiveCount];
    receiveCount++;
}

- (void)testWithParameter:(NSNotification *)notification
{
    NSLog(@"%@", notification);
}

- (NSMutableArray *)forNameObserverArray
{
    if (!_forNameObserverArray) {
        _forNameObserverArray = [NSMutableArray new];
    }
    return _forNameObserverArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
