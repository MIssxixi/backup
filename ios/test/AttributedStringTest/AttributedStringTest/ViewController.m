//
//  ViewController.m
//  AttributedStringTest
//
//  Created by yongjie_zou on 16/7/20.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSLog(@"%@", path);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/login?username=daka&pwd=123"];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", data);
    }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 400, 200)];
//        _label.adjustsFontSizeToFitWidth = YES;
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(0, 5);
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithString:@"testfl fisttirng"
                                                attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                             NSLigatureAttributeName:@1,
                                                             NSKernAttributeName:@5,
                                                             NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
                                                             NSStrikethroughColorAttributeName:[UIColor blueColor],
                                                             NSUnderlineStyleAttributeName:@(NSUnderlineStyleDouble|NSUnderlineByWord|NSUnderlinePatternDash|NSUnderlinePatternDot|NSUnderlinePatternDot),
                                                             NSStrokeColorAttributeName:[UIColor blackColor],
                                                             NSStrokeWidthAttributeName:@1,
                                                             NSShadowAttributeName:shadow,
                                                             NSTextEffectAttributeName:NSTextEffectLetterpressStyle
                                                             }
                                                ];
//        _label.text = @"test stringfa;sdfj;afjw;efj;";
        _label.attributedText =  attributedString;
    }
    return _label;
}

@end
