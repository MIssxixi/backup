//
//  ViewController.m
//  ViewContentModeTest
//
//  Created by yongjie_zou on 16/7/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 40, 40)];
//    self.imageView.contentMode =
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setImage:[UIImage imageNamed:@"test2.jpg"]];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
