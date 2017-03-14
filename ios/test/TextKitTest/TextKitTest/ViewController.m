//
//  ViewController.m
//  TextKitTest
//
//  Created by yongjie_zou on 16/8/26.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];

    
//    [self setupTextView];
    [self setup];
}

- (void)setupTextView
{
    // 富文本技术：
    // 1.图文混排
    // 2.随意修改文字样式
    //    self.textView.text = @"哈哈4365746875";
    //    self.textView.textColor = [UIColor blueColor];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"哈哈123456"];
    // 设置“哈哈”为蓝色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    
    // 设置“456”为红色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(6, 2)];
    [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(6, 2)];
    
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"student"];
    attach.bounds = CGRectMake(0, 0, attach.image.size.width, attach.image.size.height);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    
    [string appendAttributedString:attachString];
    
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"789"]];
    
//    self.textView.attributedText = string;
//    self.textView.textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50, 50)]];
    NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:string];
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [storage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(200, 100)];
    [layoutManager addTextContainer:textContainer];
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
    [self.view addSubview:self.textView];
    /**
     iOS 6之前：CoreText,纯C语言,极其蛋疼
     iOS 6开始：NSAttributedString,简单易用
     iOS 7开始：TextKit,功能强大,简单易用
     */
}

- (void)setup
{
    [super viewDidLoad];
    
    // 装载内容的容器
    NSTextStorage *storage = [NSTextStorage new];
    [storage replaceCharactersInRange:NSMakeRange(0, 0)
                           withString:
     @"未选择的路-弗罗斯特\n\n黄色的树林里分出两条路，\n可惜我不能同时去涉足，\n我在那路口久久伫立，\n我向着一条路极目望去，\n直到它消失在丛林深处。\n但我却选了另外一条路，\n它荒草萋萋，十分幽寂，\n显得更诱人、更美丽，\n虽然在这两条小路上，\n都很少留下旅人的足迹，\n虽然那天清晨落叶满地，\n两条路都未经脚印污染。\n啊，留下一条路等改日再见！\n但我知道路径延绵无尽头，\n恐怕我难以再回返。\n也许多少年后在某个地方，\n我将轻声叹息把往事回顾，\n一片树林里分出两条路，\n而我选了人迹更少的一条，\n从此决定了我一生的道路。"];
    
    // 给内容容器添加布局(可以添加多个)
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [storage addLayoutManager:layoutManager];
    
    // 带有内容和布局的容器
    NSTextContainer *textContainer = [NSTextContainer new];
    [layoutManager addTextContainer:textContainer];
    
    // 给TextView添加带有内容和布局的容器
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 400)
                                               textContainer:textContainer];
    textView.layer.borderWidth = 1;
    textView.scrollEnabled = NO;
    textView.editable      = NO;
    [self.view addSubview:textView];
}

@end
