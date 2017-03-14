//
//  ExpressionViewController.m
//  ZYJAutoLayout
//
//  Created by yongjie_zou on 16/8/19.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ExpressionViewController.h"
#import "ExpressionCollectionViewLayout.h"
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

static NSString *const CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface ExpressionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray <NSString *> *imageNameArray;

@end

@implementation ExpressionViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40);
    }
    return self;
}

- (instancetype)initWithViewFrame:(CGRect)rect
{
    if (self = [self init]) {
        self.view.frame = rect;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
//    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld", sizeof(LPEmoticonInfo));
    NSLog(@"%ld", sizeof(LP_EMOTICON_INFO));
    NSLog(@"%ld", sizeof(LP_EMOTICON_INFO)/sizeof(LPEmoticonInfo));
//    return sizeof(LP_EMOTICON_INFO)/sizeof(LPEmoticonInfo);
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    cell.contentView.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma mark - get
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        ExpressionCollectionViewLayout *layout = [[ExpressionCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor redColor];
    }
    return _collectionView;
}

- (NSArray <NSString *> *)imageNameArray
{
    if (!_imageNameArray) {
        _imageNameArray = [NSArray new];
    }
    return _imageNameArray;
}

@end
