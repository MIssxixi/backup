//
//  MyNavigationControllerViewController.m
//  NavigationControllerTest
//
//  Created by yongjie_zou on 16/8/17.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "MyNavigationControllerViewController.h"

@interface MyNavigationControllerViewController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation MyNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* !!!: 解决 interactivePopGestureRecognizer-BUG
     *  iOS7以后 如果 navigationBar 被隐藏或使用自定义返回按钮，滑动返回会失效，
     *  see @http://keighl.com/post/ios7-interactive-pop-gesture-custom-back-button/
     */
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak id <UIGestureRecognizerDelegate, UINavigationControllerDelegate> wself = self;
        self.interactivePopGestureRecognizer.delegate = wself;
//        self.delegate = wself;
    }
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            return [self.viewControllers count] > 1;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
