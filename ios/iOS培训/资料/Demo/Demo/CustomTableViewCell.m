//
//  CustomTableViewCell.m
//  Demo
//
//  Created by Mac_ZL on 16/8/2.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell()

@property (nonatomic,strong) UIImageView *bgImagView;
@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation CustomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.bgImagView];
        
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImage *image = [UIImage imageNamed:self.imgName];
    
    [self.bgImagView setImage:image];
    //图片居中
    [self.bgImagView setFrame:CGRectMake(self.contentView.frame.size.width/2-image.size.width/2, 20, image.size.width, image.size.height)];
    //设置label
    [self.titleLabel setText:self.title];
    //
    [self.titleLabel setFrame:CGRectMake(0, self.bgImagView.frame.origin.y+self.bgImagView.frame.size.height+10, self.contentView.frame.size.width, 16)];
    
}
#pragma mark - Setter & Getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
- (UIImage *)bgImagView
{
    if (!_bgImagView)
    {
        _bgImagView = [[UIImageView alloc] init];
    }
    return _bgImagView;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    //setNeedsDisplay和setNeedsLayout的区别
    //两个方法都是异步执行的。而setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到  UIGraphicsGetCurrentContext，就可以绘画了。而setNeedsLayout会默认调用layoutSubViews
    //综上所诉，setNeedsDisplay方便绘图，而layoutSubViews方便出来数据。
    [self setNeedsLayout];
}
- (void)setImgName:(NSString *)imgName
{
    _imgName = imgName;
    [self setNeedsLayout];
}
//动态的计算行高
+ (CGFloat)heightForCell:(NSInteger )row
{
    CGFloat height = 70;
    if (row %2 == 0)
    {
        height = 80;
    }
    return height;
}
@end
