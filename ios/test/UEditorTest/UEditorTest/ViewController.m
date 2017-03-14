//
//  ViewController.m
//  UEditorTest
//
//  Created by yongjie_zou on 16/8/30.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"summernote" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    //这样返回路径为空，原因不明
    
    NSURL *filePath = [resourceBundle URLForResource:@"demo" withExtension:@"html" subdirectory:@"utf8-jsp/"];
    NSString *htmlString = [NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:filePath];
//    NSString *filePath = [bundlePath stringByAppendingPathComponent:@"utf8-jsp/demo.html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:filePath]];
//    [self.webView loadRequest:urlRequest];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:filePath]];

    
//    [self.webView stringByEvaluatingJavaScriptFromString:[self getJavascriptCode:@"ueditor.config.js"]];
//    [self.webView stringByEvaluatingJavaScriptFromString:[self getJavascriptCode:@"ueditor.all.js"]];
}

- (NSString *)getJavascriptCode:(NSString *)jsFile
{
    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:jsFile ofType:nil];
    NSURL *jsURL = [NSURL fileURLWithPath:jsFilePath];
    NSString *javascriptCode = [NSString stringWithContentsOfFile:jsURL.path encoding:NSUTF8StringEncoding error:nil];
    return javascriptCode;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
        NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];

//    NSLog(@"%@", html);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@, request:%@, navigationType:%ld", NSStringFromSelector(_cmd), request, navigationType);
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@, error:%@, ", NSStringFromSelector(_cmd), error);
 
}

@end
