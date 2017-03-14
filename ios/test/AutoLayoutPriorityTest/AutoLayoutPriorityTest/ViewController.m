//
//  ViewController.m
//  AutoLayoutPriorityTest
//
//  Created by yongjie_zou on 16/9/3.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"

@interface TestView : UIView

@end

@implementation TestView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.frame = CGRectMake(0, 0, 375, 50);
}

@end

/**
 *  TestLabel
 */
@interface TestLabel : UILabel

@end

@implementation TestLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

@end

@interface ViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UISwitch *prioritySwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabel];
}

- (void)setupLabel
{
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.contentView addSubview:self.greenView];
    [self.greenView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.greenView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.greenView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.greenView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10];
    [self.greenView autoSetDimension:ALDimensionHeight toSize:200];
    [self.greenView setNeedsDisplay];
    
    [self.view addSubview:self.prioritySwitch];
    [self.prioritySwitch autoCenterInSuperview];
    __block NSLayoutConstraint *widthConstraint;
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        widthConstraint = [self.titleLabel autoSetDimension:ALDimensionWidth toSize:375];
    }];
//    widthConstraint.priority = UILayoutPriorityRequired;
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
}

- (void)tapSwitch
{
    if (self.prioritySwitch.on) {
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.titleLabel autoSetDimension:ALDimensionWidth toSize:375];
//        }];
        self.titleLabel.text = @"打开了";
    }
    else
    {
        
//        [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
            [self.titleLabel autoSetDimension:ALDimensionWidth toSize:200];
//        }];
        self.titleLabel.text = @"关闭了";
    }
}

- (UIView *)contentView
{
    if (!_contentView) {
//        _contentView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 375, 100)];
        _contentView = [TestView newAutoLayoutView];
        _contentView.backgroundColor = [UIColor grayColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[TestLabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"test layout before display";
    }
    return _titleLabel;
}

- (UIView *)greenView
{
    if (!_greenView) {
        _greenView = [UIView newAutoLayoutView];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (UISwitch *)prioritySwitch
{
    if (!_prioritySwitch) {
        _prioritySwitch = [UISwitch newAutoLayoutView];
        _prioritySwitch.on = YES;
        [_prioritySwitch addTarget:self action:@selector(tapSwitch) forControlEvents:UIControlEventValueChanged];
    }
    return _prioritySwitch;
}

@end
