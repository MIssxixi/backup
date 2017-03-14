//
//  AdvertisementAnimateView.m
//  AdvertisementAnimateTest
//
//  Created by yongjie_zou on 16/9/5.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "AdvertisementAnimateView.h"
#import "PureLayout.h"

CGFloat const adHeight = 44;

@interface AdvertisementAnimateView ()

@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSLayoutConstraint *toSuperTop;
@property (nonatomic, strong) NSLayoutConstraint *toAdBottom;

@end

@implementation AdvertisementAnimateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)setupViews
{
    [self addSubview:self.adView];
    [self addSubview:self.contentView];
    
    self.adView.hidden = YES;
    [self.adView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.adView autoSetDimension:ALDimensionHeight toSize:adHeight];
    
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [UIView autoSetPriority:998 forConstraints:^{
        self.toAdBottom = [self.contentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.adView withOffset:10];
    }];
    [UIView autoSetPriority:999 forConstraints:^{
        self.toSuperTop = [self.contentView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
    }];
}

- (void)showAnimatedView:(BOOL)isShow
{
//    [self layoutIfNeeded];
    if (isShow) {
        self.toAdBottom.priority = 999;
        self.toSuperTop.priority = 998;
    }
    else
    {
        self.toAdBottom.priority = 998;
        self.toSuperTop.priority = 999;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
    self.adView.hidden = !isShow;
}

#pragma get
- (UIView *)adView
{
    if (!_adView) {
        _adView = [UIView newAutoLayoutView];
        _adView.backgroundColor = [UIColor redColor];
    }
    return _adView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView newAutoLayoutView];
        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}

@end
