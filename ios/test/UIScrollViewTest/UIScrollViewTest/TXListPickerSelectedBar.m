//
//  TXListPickerSelectedBar.m
//  Pods
//
//  Created by yongjie_zou on 2016/11/7.
//
//

#import "TXListPickerSelectedBar.h"
#import "Masonry.h"

@interface TXListPickerSelectedBar ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation TXListPickerSelectedBar

- (void)layoutSubviews
{
    [self.scrollView addSubview:self.contentView];
    [self addSubview:self.scrollView];
    
    __weak typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.with.height.equalTo(weakSelf);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
    }];
}

#pragma mark - get
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (NSMutableArray *)contentArray
{
    if (!_contentArray)
    {
        _contentArray = [NSMutableArray new];
    }
    return _contentArray;
}

@end
