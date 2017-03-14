//
//  UIImage+Utils.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)te_imageWithColor:(UIColor *)color size:(CGSize)imgSize{
    CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _img;
}

@end
