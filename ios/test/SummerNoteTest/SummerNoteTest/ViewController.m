//
//  ViewController.m
//  SummerNoteTest
//
//  Created by yongjie_zou on 16/9/7.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"summernote" ofType:@"bundle"];
        NSBundle *summernoteBundle = [NSBundle bundleWithPath:bundlePath];
#if 1
        NSString *filePath = [summernoteBundle pathForResource:@"summernote" ofType:@"html"];
#else
        NSString *filePath = [bundlePath stringByAppendingPathComponent:@"summernote.html"];
#endif
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePath]];
    }
    return _webView;
}

@end
