//
//  ViewController.m
//  KeyboardTest
//
//  Created by yongjie_zou on 16/9/6.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "TXKeyboardHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[TXKeyboardHelper sharedInstance] ]
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    textView.text = @"test";
    [self.view addSubview:textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
