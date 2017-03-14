//
//  ViewController.m
//  CodePartTest
//
//  Created by yongjie_zou on 16/10/21.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setNavigationBarGradientBackgroundColor:(BOOL)isGradientColor{
    if (isGradientColor) {
        [self.navigationController.navigationBar setBackgroundImage:[self gradientColorImageWithSize:CGSizeMake(TX_SCREEN_WIDTH, 10)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:TX_CO_WHITE];
        NSDictionary *attr = @{NSForegroundColorAttributeName:TX_CO_WHITE, NSFontAttributeName:TX_FT_MAX};
        [self.navigationController.navigationBar setTitleTextAttributes:attr];
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage tx_imageWithColor:TX_CO_WHITE size:CGSizeMake(TX_SCREEN_WIDTH, 10)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:TX_CO_BLUEMAJ];
        NSDictionary *attr = @{NSForegroundColorAttributeName:TX_CO_BSIX, NSFontAttributeName:TX_FT_MAX};
        [self.navigationController.navigationBar setTitleTextAttributes:attr];
    }
    

- (UIImage *)gradientColorImageWithSize:(CGSize)imgSize {
    NSMutableArray *ar = @[(id)[UIColor bjck_colorWithHexString:@"40d1f5"].CGColor,
                           (id)[UIColor bjck_colorWithHexString:@"048ff5"].CGColor
                           ];
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace((CGColorRef)ar[1]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    start = CGPointMake(0.0, 0.0);
    end = CGPointMake(imgSize.width, 0.0);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
