//
//  ViewController.m
//  ZYJAutoLayout
//
//  Created by yongjie_zou on 16/8/19.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ExpressionView.h"

@interface ViewController ()

@property (nonatomic, assign) NSUInteger onePageCount;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) ExpressionView *expressionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
}

- (void)setupButton
{
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
    }];
}

- (void)touchUpButtonInside
{
    self.button.selected = !self.button.selected;
    if (self.button.selected) {
        [self showExpression];
    }
    else
    {
        [self hideExpression];
    }
}

- (void)showExpression
{
    [self.view addSubview:self.expressionView];
    
    [self.expressionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(222);
    }];
}

- (void)hideExpression
{
    [self.expressionView removeFromSuperview];
    [self.segmentedControl removeFromSuperview];
}

#pragma mark - get
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        self.onePageCount = 8;
        
    }
    return _label;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"显示表情" forState:UIControlStateNormal];
        [_button setTitle:@"收起表情" forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(touchUpButtonInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (ExpressionView *)expressionView
{
    if (!_expressionView) {
        _expressionView = [[ExpressionView alloc] init];
    }
    return _expressionView;
}

@end
