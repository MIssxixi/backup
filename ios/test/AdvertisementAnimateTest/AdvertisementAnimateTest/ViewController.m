//
//  ViewController.m
//  AdvertisementAnimateTest
//
//  Created by yongjie_zou on 16/9/5.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "AdvertisementAnimateView.h"
#import "PureLayout.h"

@interface ViewController ()

@property (nonatomic, strong) AdvertisementAnimateView *advertisementAnimateView;
@property (nonatomic, strong) UISwitch *adSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupViews];
}

- (void)setupViews
{
    [self.view addSubview:self.advertisementAnimateView];
    [self.view addSubview:self.adSwitch];
    
    [self.advertisementAnimateView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 100, 0)];
    [self.adSwitch autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.adSwitch autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
}

- (void)onSwitch
{
    [self.advertisementAnimateView showAnimatedView:self.adSwitch.on];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (AdvertisementAnimateView *)advertisementAnimateView
{
    if (!_advertisementAnimateView) {
        _advertisementAnimateView = [AdvertisementAnimateView newAutoLayoutView];
    }
    return _advertisementAnimateView;
}

- (UISwitch *)adSwitch
{
    if (!_adSwitch) {
        _adSwitch = [UISwitch newAutoLayoutView];
        [_adSwitch addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventValueChanged];
    }
    return _adSwitch;
}
@end
