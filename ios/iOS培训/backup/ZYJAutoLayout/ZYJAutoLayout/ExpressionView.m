//
//  ExpressionView.m
//  ZYJAutoLayout
//
//  Created by yongjie_zou on 16/8/19.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ExpressionView.h"
#import <Masonry.h>

typedef struct {
    char const *const key, *const name, *const image;
} LPEmoticonInfo;

static const LPEmoticonInfo LP_EMOTICON_INFO[] = {
    { .key = "[wx]", .name = "微笑", .image = "expression_11" },
    { .key = "[hk]", .name = "好困", .image = "expression_12" },
    { .key = "[dy]", .name = "得意", .image = "expression_13" },
    { .key = "[pz]", .name = "撇嘴", .image = "expression_14" },
    { .key = "[hx]", .name = "憨笑", .image = "expression_21" },
    { .key = "[dk]", .name = "大哭", .image = "expression_22" },
    { .key = "[tp]", .name = "调皮", .image = "expression_23" },
    { .key = "[yw]", .name = "疑问", .image = "expression_24" },
    { .key = "[jy]", .name = "惊讶", .image = "expression_31" },
    { .key = "[lh]", .name = "厉害", .image = "expression_32" },
    { .key = "[cb]", .name = "崇拜", .image = "expression_33" },
    { .key = "[fz]", .name = "奋战", .image = "expression_34" },
    { .key = "[yu]", .name =  "晕" , .image = "expression_41" },
    { .key = "[se]", .name =  "色" , .image = "expression_42" },
    { .key = "[wy]", .name = "无语", .image = "expression_43" },
    { .key = "[sh]", .name =  "衰" , .image = "expression_44" } };

static NSUInteger const ImageCount = sizeof(LP_EMOTICON_INFO)/sizeof(LPEmoticonInfo);
static NSUInteger const OnePageCount = 8;
static CGFloat const ViewHeight = 222;
static CGSize const ImageSize = {76, 76};
static CGFloat const pageControlViewRadius = 8;
static CGFloat const pageControlViewSpace = 16;

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface ExpressionView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) NSMutableArray <UIImageView *> *imageViewArray;
@property (nonatomic, copy) NSMutableArray <UILabel *> *nameLabelArray;
@property (nonatomic, copy) NSMutableArray <UIView *> *pageControlViewArray;

@end

@implementation ExpressionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self inital];
        [self setupListener];
        
        [self setupContentview];
        [self setupImageView];
        [self setuppageControlView];
    }
    return self;
}

- (void)inital
{
    self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * ((ImageCount + 3) / OnePageCount), ViewHeight);
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setupListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(id)sender
{
    [self updatepageControlViewLeftConstraint:self.contentOffset.x];
}

- (void)setupContentview
{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.equalTo(self).multipliedBy((ImageCount + 3) / OnePageCount);
    }];
}

- (void)setupImageView
{
//    CGFloat xHalfSpace = [UIScreen mainScreen].bounds.size.width / 8.0 - ImageSize.width / 2.0;
    NSUInteger imageViewIndex = 0;
    for (; imageViewIndex < ImageCount;) {
        NSUInteger onePageNumber = 0;
        for (; onePageNumber < OnePageCount && imageViewIndex < ImageCount; onePageNumber++) {
            UIImageView *imageView = self.imageViewArray[imageViewIndex];
            [self.contentView addSubview:imageView];
//            CGFloat leftInset = xHalfSpace
//                                + (ImageSize.width + 2 * xHalfSpace) * (onePageNumber % 4)
//                                + [UIScreen mainScreen].bounds.size.width * (imageViewIndex / OnePageCount);
            CGFloat topInset = 8 + (ImageSize.height + 26) * (onePageNumber / 4);
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(ImageSize);
                //不能适应屏幕旋转
//                make.left.mas_equalTo(leftInset);
                //能适应屏幕旋转
                make.left.equalTo(self.contentView.mas_right).multipliedBy((1 / 8.0) * (0.5 + onePageNumber % 4) + 0.5 * (imageViewIndex / OnePageCount)).offset(-(ImageSize.width / 2.0));
                make.top.mas_equalTo(topInset);
            }];
            
            //表情名称
            UILabel *label = self.nameLabelArray[imageViewIndex];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imageView);
                make.top.equalTo(imageView.mas_bottom).offset(6);
            }];
            
            imageViewIndex++;
        }
    }
}

- (void)setuppageControlView
{
    NSUInteger pageCount = (ImageCount - 1) / OnePageCount + 1;
    NSUInteger pageIndex = 0;
    for (; pageIndex < pageCount; pageIndex++) {
        UIView *view = self.pageControlViewArray[pageIndex];
        [self addSubview:view];
    }
    
    [self updatepageControlViewLeftConstraint:0];
}

- (void)updatepageControlViewLeftConstraint:(CGFloat)leftOffset
{
    NSUInteger pageCount = (ImageCount - 1) / OnePageCount + 1;
    CGFloat leftInset = (ScreenWidth - pageCount * pageControlViewRadius - (pageCount - 1) * pageControlViewSpace) / 2.0;
    NSUInteger pageIndex = 0;
    for (; pageIndex < pageCount; pageIndex++) {
        UIView *view = self.pageControlViewArray[pageIndex];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftInset + (pageControlViewRadius + pageControlViewSpace) * pageIndex + leftOffset);
            make.top.mas_equalTo(self).offset(ViewHeight - pageControlViewRadius - 10);
            //由于UIScrollView特性，设置bottom效果不正确
//            make.bottom.mas_equalTo(self).offset(10);
            make.width.height.mas_equalTo(pageControlViewRadius);
        }];
//        [view setNeedsLayout];
//        [view layoutIfNeeded];
    }
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    
    //保证pageControlView位置不变。有没有更好的方法？？？
    CGFloat xOffset = sender.contentOffset.x;
    [self updatepageControlViewLeftConstraint:xOffset];       //不用判断xOffset大小。特别xOffset为负数，也应该更新约束
    
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((xOffset - pageWidth / 2) / pageWidth) + 1;
    for (UIView *view in self.pageControlViewArray) {
        view.backgroundColor = [UIColor grayColor];
    }
    self.pageControlViewArray[currentPage].backgroundColor = [UIColor redColor];
}

#pragma mark - get
- (NSMutableArray <UIImageView *> *)imageViewArray
{
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc] initWithCapacity:ImageCount];
        NSUInteger imageViewIndex = 0;
        for (; imageViewIndex < ImageCount; imageViewIndex++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%s",LP_EMOTICON_INFO[imageViewIndex].image]];
            [_imageViewArray addObject:[[UIImageView alloc] initWithImage:image]];
        }
    }
    return _imageViewArray;
}

- (NSMutableArray <UILabel *> *)nameLabelArray
{
    if (!_nameLabelArray) {
        _nameLabelArray = [[NSMutableArray alloc] initWithCapacity:ImageCount];
        NSUInteger imageViewIndex = 0;
        for (; imageViewIndex < ImageCount; imageViewIndex++) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
//            label.text = [NSString stringWithFormat:@"%s",LP_EMOTICON_INFO[imageViewIndex].name];
            label.text = [NSString stringWithUTF8String:LP_EMOTICON_INFO[imageViewIndex].name];
            [_nameLabelArray addObject:label];
        }
    }
    return _nameLabelArray;
}

- (NSMutableArray <UIView *> *)pageControlViewArray
{
    if (!_pageControlViewArray) {
        NSUInteger pageCount = (ImageCount - 1) / OnePageCount + 1;
        _pageControlViewArray = [[NSMutableArray alloc] initWithCapacity:pageCount];
        NSUInteger pageIndex = 0;
        for (; pageIndex < pageCount; pageIndex++) {
            UIView *view = [[UIView alloc] init];
            view.layer.cornerRadius = pageControlViewRadius / 2.0;
            view.backgroundColor = [UIColor grayColor];
            [_pageControlViewArray addObject:view];
        }
        _pageControlViewArray[0].backgroundColor = [UIColor redColor];
    }
    return _pageControlViewArray;
}

- (UIView *)contentView
{
    if(!_contentView){
        _contentView = [[UIView alloc] init];
        _contentView.layer.borderWidth = 2;
        _contentView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _contentView;
}

@end
