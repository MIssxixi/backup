//
//  ViewController.m
//  ZYJMutipleThread
//
//  Created by yongjie_zou on 16/8/26.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowTypeNormal,
    ShowTypeGCD,
    ShowTypeNSTread,
    ShowTypeNSOperation
};

static CGSize const ImageSize = {200, 200};

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, assign) ShowType showType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showType = ShowTypeNormal;
}

- (IBAction)tapNormal:(id)sender
{
    [self showImagePickerWithType:ShowTypeNormal];
}

- (IBAction)tapNSOperation:(id)sender
{
    [self showImagePickerWithType:ShowTypeNSOperation];
}

- (IBAction)tapNSTread:(id)sender
{
    [self showImagePickerWithType:ShowTypeNSTread];
}

- (IBAction)tapGCD:(id)sender
{
    [self showImagePickerWithType:ShowTypeGCD];
}

- (void)showImagePickerWithType:(ShowType)showType
{
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    self.showType = showType;
}

- (void)reloadImageView:(UIImage *)image
{
    switch (self.showType) {
        case ShowTypeNormal:
        {
            [self showImage:image];
            break;
        }
        case ShowTypeGCD:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showImage:image];
            });
            break;
        }
        case ShowTypeNSOperation:
        {
            NSOperationQueue *operatoinQueue = [[NSOperationQueue alloc] init];
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                [self showImage:image];
            }];
            [operatoinQueue addOperation:blockOperation];
            break;
        }
        case ShowTypeNSTread:
        {
            [NSThread detachNewThreadSelector:@selector(showImage:) toTarget:self withObject:image];
            break;
        }
        default:
            break;
    }
}

- (void)showImage:(UIImage *)image
{
    UIImage *newImage = [self compressImage:image toSize:ImageSize];
    if (ShowTypeNSTread == self.showType) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = newImage;
        });
    }
    else
    {
        self.imageView.image = newImage;
    }
}

- (UIImage *)compressImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self reloadImageView:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - get

- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}

@end
