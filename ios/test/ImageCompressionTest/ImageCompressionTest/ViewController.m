//
//  ViewController.m
//  ImageCompressionTest
//
//  Created by yongjie_zou on 16/8/9.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
}

- (void)setupButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"pick image" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 100, 100, 100);
    [button addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pickImage
{
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - pickDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
   //如果不是异步执行，会报错
//    Communications error: <OS_xpc_error: <error: 0x19bdacaf0> { count = 1, contents =
//        "XPCErrorDescription" => <string: 0x19bdace50> { length = 22, contents = "Connection interrupted" }
//    }>
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *tempImage = image;
        CGFloat i = 1;
        while (i > 0.1) {
            NSData *data = UIImageJPEGRepresentation(image, i);
            NSData *tempData = UIImageJPEGRepresentation(tempImage, i);
            tempImage = [UIImage imageWithData:tempData];
            i = i - 0.1;
            
            NSLog(@"data length:%ld", data.length);
            NSLog(@"tempData length:%ld\n", tempData.length);
        }
    });
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
