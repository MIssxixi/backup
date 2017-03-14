//
//  ViewController.m
//  UIButtonTest
//
//  Created by yongjie_zou on 16/10/20.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextView *guideBottomTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 100, 40)];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"ghao" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor blueColor] size:CGSizeMake(100, 40)] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor redColor] size:CGSizeMake(100, 40)] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guideBottomTextView];
}

- (UITextView *)guideBottomTextView
{
    if (!_guideBottomTextView)
    {
        _guideBottomTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, 200, 40)];
        _guideBottomTextView.backgroundColor = [UIColor clearColor];
        _guideBottomTextView.scrollEnabled = NO;
        _guideBottomTextView.selectable = NO;
//        _guideBottomTextView.editable = NO;
        _guideBottomTextView.textContainer.lineFragmentPadding = 0;
        _guideBottomTextView.textContainerInset = UIEdgeInsetsZero;
        _guideBottomTextView.delegate = self;
        NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithString:@"还没有微信公众号？"
                                                                                              attributes:@{
                                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:16],
                                                                                                           NSForegroundColorAttributeName : [UIColor grayColor]
                                                                                                           }];
        NSAttributedString *registerAttributedString = [[NSAttributedString alloc] initWithString:@"立即注册"
                                                                                       attributes:@{
                                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:16],
                                                                                                    NSLinkAttributeName : @"register"
                                                                                                    }];
        [mAttributedString appendAttributedString:registerAttributedString];
        _guideBottomTextView.linkTextAttributes = @{
                                                    NSForegroundColorAttributeName : [UIColor blueColor],
                                                    NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
                                                    };
        _guideBottomTextView.attributedText = mAttributedString;
    }
    return _guideBottomTextView;
}

- (void)action:(id)sender{
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
