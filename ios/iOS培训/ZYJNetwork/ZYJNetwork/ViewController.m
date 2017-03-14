//
//  ViewController.m
//  ZYJNetwork
//
//  Created by yongjie_zou on 16/9/23.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ZYJNetwork.h"
#import "ZYJRequest.h"
#import "AFNetworking.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ITEM_HEIGHT (([UIScreen mainScreen].bounds.size.height - 64) / 2.0)

@interface ItemView : UIView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, copy) void(^tapButton)();

- (void)setupSubviews;

@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)setupSubviews
{
    self.button.frame = CGRectMake(SCREEN_WIDTH / 8.0, 0, SCREEN_WIDTH / 4.0, 20);
    self.detailView.frame = CGRectMake(0, 25, SCREEN_WIDTH / 2.0, ITEM_HEIGHT / 2.0 - 25);
    [self addSubview:self.button];
    [self addSubview:self.detailView];
}

- (void)onButton
{
    if (self.tapButton)
    {
        self.tapButton();
    }
}

#pragma mark - get
- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIView *)detailView
{
    if (!_detailView)
    {
        _detailView = [UIView new];
    }
    return _detailView;
}

@end

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) ZYJRequest *downloadRequest;
@property (nonatomic, assign) BOOL downloadFinished;
@property (nonatomic, strong) UITextView *uploadRespondTextView;
@property (nonatomic, copy) NSString *imageUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    __weak typeof(self) weakself = self;
    
    //get方法
    ItemView *getItemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH / 2.0, ITEM_HEIGHT)];
    [self.view addSubview:getItemView];
    __block UITextView *getTextView = [UITextView new];
    getTextView.editable = NO;
    getItemView.detailView = getTextView;
    [getItemView.button setTitle:@"get方法" forState:UIControlStateNormal];
    [getItemView setupSubviews];
    NSDictionary *getParams = @{
                             @"question" : @"21996010",
                             @"answer" : @"67603075"
                             };
    [getItemView setTapButton:^{
        [[ZYJNetwork sharedInstance] get:@"http://www.zhihu.com/" parameters:getParams resultBack:^(NSURLRequest * _Nonnull request, NSData * __nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            getTextView.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }];
    }];
    
    //post方法
    ItemView *postItemView = [[ItemView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, 64, SCREEN_WIDTH / 2.0, ITEM_HEIGHT)];
    [self.view addSubview:postItemView];
    __block UITextView *postTextView = [UITextView new];
    postTextView.editable = NO;
    postItemView.detailView = postTextView;
    [postItemView.button setTitle:@"post方法" forState:UIControlStateNormal];
    [postItemView setupSubviews];
    NSDictionary *postParams = @{
                                 @"mobile" : @"13554400686",
                                 @"password" : @"111111nn",
                                 @"version" : @"1.6.1"
                                 };
    [postItemView setTapButton:^{
        [[ZYJNetwork sharedInstance] post:@"http://test-tianxiao100-m.ctest.baijiahulian.com/app/tx/doLogin.do" parameters:postParams resultBack:^(NSURLRequest * _Nonnull request, NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            postTextView.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }];
    }];
    
    //download方法
    ItemView *downloadItemView = [[ItemView alloc] initWithFrame:CGRectMake(0, ITEM_HEIGHT, SCREEN_WIDTH / 2.0, ITEM_HEIGHT)];
    [self.view addSubview:downloadItemView];
    __block UIImageView *downloadImageView = [UIImageView new];
    downloadItemView.detailView = downloadImageView;
    [downloadItemView.button setTitle:@"download方法" forState:UIControlStateNormal];
    [downloadItemView setupSubviews];
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    downloadButton.userInteractionEnabled = NO;
    [downloadButton addTarget:self action:@selector(onDownloadPauseResumeButton:) forControlEvents:UIControlEventTouchUpInside];
    downloadButton.frame = CGRectMake(SCREEN_WIDTH / 8.0, ITEM_HEIGHT / 2.0 + 20, SCREEN_WIDTH / 4.0, 20);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 16.0, ITEM_HEIGHT / 2.0 + 40, SCREEN_WIDTH / 2.0, 20)];
    label.text = @"下载进度：0.00%";
    [downloadItemView addSubview:downloadButton];
    [downloadItemView addSubview:label];
    self.imageUrl = @"http://test-img.gsxservice.com/779233_ms0gpdh2.jpg";
    [downloadItemView setTapButton:^{
        [downloadButton setTitle:@"暂停" forState:UIControlStateNormal];
        downloadImageView.image = nil;
        NSString *path = NSTemporaryDirectory();
        NSString *imageName = [NSString stringWithFormat:@"/temp%lf.jpg", [[NSDate date] timeIntervalSince1970]];
        path = [path stringByAppendingPathComponent:imageName];
        weakself.downloadRequest = [[ZYJNetwork sharedInstance] download:weakself.imageUrl parameters:nil fileDownPath:path progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpected) {
            downloadButton.userInteractionEnabled = YES;
            weakself.downloadFinished = totalBytesExpected == totalBytesWritten;
            label.text = [NSString stringWithFormat:@"下载进度：%.2f%%", 100.0 * totalBytesWritten / totalBytesExpected];
            } resultBack:^(NSURLRequest * _Nonnull request, NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                downloadImageView.image = [UIImage imageNamed:path];
            }];
    }];
    
    //upload方法
    ItemView *uploadItemView = [[ItemView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, ITEM_HEIGHT, SCREEN_WIDTH / 2.0, ITEM_HEIGHT)];
    [self.view addSubview:uploadItemView];
    self.uploadRespondTextView = [UITextView new];
    self.uploadRespondTextView.editable = NO;
    self.uploadRespondTextView.text = @"上传后的照片可以直接从通过”download方法“查看";
    uploadItemView.detailView = self.uploadRespondTextView;
    [uploadItemView.button setTitle:@"upload方法" forState:UIControlStateNormal];
    [uploadItemView setupSubviews];
    [uploadItemView setTapButton:^{
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = weakself;
        [weakself presentViewController:pickerController animated:YES completion:nil];
    }];
}

#pragma mark - action
- (void)onDownloadPauseResumeButton:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]] && !self.downloadFinished)
    {
        UIButton *button = sender;
        if ([button.currentTitle isEqualToString:@"暂停"])
        {
            [self.downloadRequest pause];
            [button setTitle:@"开始" forState:UIControlStateNormal];
        }
        else
        {
            [self.downloadRequest resume];
            [button setTitle:@"暂停" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark - network


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tianxiao.jpg"];
    [data writeToFile:path atomically:YES];
    NSString *url = @"http://test-erp-m.ctest.baijiahulian.com/storage/upload.json?auth_token=DYAnenhqd2RuaSc_ODs3PjIoaXooQHR7cnIyKXpoc3spQSltOlR1OVhRbio0Kmtpe2tpbG1ofnxue2hybStDd351djYsa39-cixEeH92djctf4Nqbmx-bmxvcGqBf3F-a3VwLkZ6gXh4OS-BhWxucHB8gnuBbHdyMEhCRIs";
    self.uploadRespondTextView.text = @"正在上传图片...";
    [[ZYJNetwork sharedInstance] upload:url parameters:nil formData:data fromPath:path  progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpected) {
        
    } resultBack:^(NSURLRequest * _Nonnull request, NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSRange rangeStart = [dataString rangeOfString:@"http://"];
        NSRange rangeEnd = [dataString rangeOfString:@".jpg"];
        NSRange range = NSMakeRange(63, rangeEnd.location - rangeStart.location + 4);
        weakself.imageUrl = [dataString substringWithRange:range];
        
        weakself.uploadRespondTextView.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
}

@end
