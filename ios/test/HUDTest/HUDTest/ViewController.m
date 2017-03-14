//
//  ViewController.m
//  HUDTest
//
//  Created by yongjie_zou on 2016/12/16.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        view.text = @"label";
        view.backgroundColor = [UIColor redColor];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = view;
        [hud layoutIfNeeded];
        hud.yOffset = 100;
        [hud setNeedsLayout];
        [hud layoutIfNeeded];
//        MBProgressHUD *tempHud = [[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:tempHud];
//        tempHud.customView = hud.customView;
//        tempHud.mode = hud.mode;
//        [tempHud removeFromSuperview];
        
        
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(5);
        } completionBlock:^{
            
        }];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
