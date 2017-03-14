//
//  ViewController.m
//  PngJpgTest
//
//  Created by yongjie_zou on 16/8/12.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//png转化为jpg，透明的地方会变为白色
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupImageView];
    [self setupTransparentView];
}

- (void)setupImageView
{
//    UIImage *pngImage = [UIImage animatedImageNamed:@"arrow" duration:1];
    UIImage *pngImage = [UIImage animatedResizableImageNamed:@"arrow" capInsets:UIEdgeInsetsMake(-10, 0, 0, 0) duration:1];
    NSData *data= UIImageJPEGRepresentation(pngImage, 1);
//    UIImage *tempImage = [UIImage imageWithData:data];
//    NSData *tempData = UIImageJPEGRepresentation(tempImage, 0);
//    while (tempData.length != data.length) {
//        data = tempData;
//        tempImage = [UIImage imageWithData:tempData];
//        tempData = UIImageJPEGRepresentation(tempImage, 0);
//    }
    NSString *filePath = [self getFilePath:@"wettw.jpg"];
    [data writeToFile:filePath atomically:YES];
    UIImage *jpgImage = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *pngImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    pngImageView.image = pngImage;
    UIImageView *jpgImageView = [[UIImageView alloc] initWithImage:jpgImage];
    jpgImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:pngImageView];
    [self.view addSubview:jpgImageView];
    [self changeImageView:pngImageView toCenter:CGPointMake(100, 100)];
    [self changeImageView:jpgImageView toCenter:CGPointMake(100, 200)];
}

- (void)setupTransparentView
{
    UIView *transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 36)];
//    transparentView.alpha = 0;
    transparentView.backgroundColor = [UIColor blueColor];
    UIImage *image = [self imageWithView:transparentView];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSString *filePath = [self getFilePath:@"image.jpg"];
    [data writeToFile:filePath atomically:YES];
    UIImage *fileImage = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIImageView *fileImageView = [[UIImageView alloc] initWithImage:fileImage];
//    fileImageView.alpha = 0.5;
    [self.view addSubview:imageView];
    [self.view addSubview:fileImageView];
    [self changeImageView:imageView toCenter:CGPointMake(100, 300)];
    [self changeImageView:fileImageView toCenter:CGPointMake(100, 400)];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 1);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (NSString *)getFilePath:(NSString *)fileName
{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:fileName];
}

- (void)changeImageView:(UIImageView *)imageView toCenter:(CGPoint)point
{
    if (![imageView isKindOfClass:[UIView class]]) {
        return;
    }
    CGRect rect = imageView.frame;
    rect.origin.x = point.x;
    rect.origin.y = point.y;
    imageView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
