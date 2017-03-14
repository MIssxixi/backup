//
//  TEMyLiveViewCell.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TEMyLiveViewCell.h"
#import "TEConst.h"
#import "Masonry.h"
#import "UIView+Borders.h"

@interface TEMyLiveViewCell ()

@property (nonatomic, strong) UILabel *classNameLabel;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation TEMyLiveViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    self.backgroundColor = TE_COLOR(@"f0f0f0");
    self.contentView.backgroundColor = TE_COLOR(@"ffffff");
    self.contentView.layer.cornerRadius = 4;
    self.contentView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.classNameLabel];
    [self.contentView addSubview:self.enterButton];
    [self.contentView addSubview:self.editButton];
    [self.contentView addSubview:self.deleteButton];
    [self.contentView addSubview:self.shareButton];
    
    [self.contentView te_addBottomBorderWithHeight:1 / [UIScreen mainScreen].scale color:TE_COLOR(@"6d6d6e") leftOffset:0 rightOffset:0 andBottomOffset:43];
    
    WS(weakSelf)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).mas_offset(14);
        make.left.equalTo(weakSelf.contentView).mas_offset(14);
    }];
    
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).mas_offset(-14);
        make.centerY.equalTo(weakSelf.classNameLabel);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).mas_offset(5);
        make.bottom.equalTo(weakSelf.contentView).mas_offset(-14);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.centerY.equalTo(weakSelf.editButton);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.editButton);
        make.right.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
}

- (void)setData:(TELiveClassModel *)model{
    self.classNameLabel.text = model.name;
}

#pragma mark - get
- (UILabel *)classNameLabel{
    if (!_classNameLabel){
        _classNameLabel = [[UILabel alloc] init];
        _classNameLabel.font = TE_FONT(16);
        _classNameLabel.textColor = TE_COLOR(@"3d3d3d");
    }
    return _classNameLabel;
}

- (UIButton *)enterButton{
    if (!_enterButton){
        _enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_enterButton setTitleColor:TE_COLOR(@"1694ff") forState:UIControlStateNormal];
        _enterButton.titleLabel.font = TE_FONT(16);
        [_enterButton setTitle:@"进入教室" forState:UIControlStateNormal];
    }
    return _enterButton;
}

- (UIButton *)editButton{
    if (!_editButton){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitleColor:TE_COLOR(@"6d6d6e") forState:UIControlStateNormal];
        _editButton.titleLabel.font = TE_FONT(16);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"te_edite"] forState:UIControlStateNormal];
        _editButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _editButton;
}

- (UIButton *)deleteButton{
    if (!_deleteButton){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitleColor:TE_COLOR(@"6d6d6e") forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = TE_FONT(16);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"te_delete"] forState:UIControlStateNormal];
        _deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _deleteButton;
}

- (UIButton *)shareButton{
    if (!_shareButton){
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setTitleColor:TE_COLOR(@"6d6d6e") forState:UIControlStateNormal];
        _shareButton.titleLabel.font = TE_FONT(16);
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"te_share"] forState:UIControlStateNormal];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _shareButton;
}

@end
