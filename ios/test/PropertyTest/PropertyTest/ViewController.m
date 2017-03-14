//
//  ViewController.m
//  PropertyTest
//
//  Created by yongjie_zou on 16/10/9.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *mutableArrayStrong;
@property (nonatomic, copy) NSMutableArray *mutableArrayCopy;
@property (nonatomic, strong) NSArray *arraryStrong;
@property (nonatomic, copy) NSArray *arrayCopy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"array"];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:@[@"mutableArray"]];
    
    self.mutableArrayStrong = mutableArray;
    self.mutableArrayCopy = mutableArray;
    NSLog(@"%p, %p, %p", mutableArray, self.mutableArrayStrong, self.mutableArrayCopy);
    
    self.arrayCopy = mutableArray;
    self.arraryStrong = mutableArray;
    NSLog(@"%p, %p, %p", mutableArray, self.arraryStrong, self.arrayCopy);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
