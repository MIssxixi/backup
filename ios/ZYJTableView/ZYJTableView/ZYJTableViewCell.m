//
//  ZYJTableViewCell.m
//  ZYJTableView
//
//  Created by yongjie_zou on 16/8/3.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ZYJTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSInteger const highLightFont = 15;
static NSInteger const sourceFont = 10;
static NSInteger const titleFont = 18;
static NSInteger const detailFont = 14;
static CGFloat const space20 = 20;
static CGFloat const topSpaceOfTitle = 10;
static CGFloat const bottomSpaceOfSource = 10;
static CGFloat const spaceBetweenTitleAndDetail = 5;
static CGFloat const spaceBetweenDetailAndSource = 5;
static CGFloat const spaceBetweenSupportAndComment = 12;
static CGFloat const maxWidthOfSupportAndComment = 80;
static CGFloat const widthOfIcon = 24;
static CGFloat const yOfThirdLine = 90;
static CGFloat const heightOfthirdLine = 20;
static CGFloat const highlightLabelWidth = 20;

@implementation ZYJTableViewCellModel

@end

@interface ZYJTableViewCell ()

@property (nonatomic, strong) UILabel *highlightLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, strong) UIButton *supportButton;
@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation ZYJTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.highlightLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.sourceLabel];
        [self.contentView addSubview:self.supportButton];
        [self.contentView addSubview:self.commentButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateWithModel:(ZYJTableViewCellModel *)model
{
    [self updateFrames:model];
    
    self.titleLabel.attributedText = [self atrributedStringWithTitle:model.titleString];
    self.detailLabel.text = model.detailString;
    self.sourceLabel.text = model.sourceString;
    [self.supportButton setTitle:[NSNumber numberWithInteger:model.supportCount].stringValue forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSNumber numberWithInteger:model.commentCount].stringValue forState:UIControlStateNormal];
}

#pragma mark - private method
- (NSAttributedString *)atrributedStringWithTitle:(NSString *)title
{
    if (!title) {
        return nil;
    }
    NSUInteger lenth = title.length;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
//    [attributedString addAttributes:@{
//                                      NSFontAttributeName:[UIFont systemFontOfSize:18],
//                                      NSForegroundColorAttributeName:[UIColor whiteColor],
//                                      NSBackgroundColorAttributeName:[UIColor orangeColor],
//                                      NSBaselineOffsetAttributeName:@2.5,
//                                      }
//                              range:NSMakeRange(0, 1)];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.firstLineHeadIndent = highlightLabelWidth;
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttributes:@{
                                      NSParagraphStyleAttributeName:paragraph,
                                      NSFontAttributeName:[UIFont systemFontOfSize:titleFont],
                                      NSForegroundColorAttributeName:[UIColor blackColor],
                                      NSStrokeWidthAttributeName:@-2,
                                      NSStrokeColorAttributeName:[UIColor blackColor]
                                      }
                              range:NSMakeRange(0, lenth)];
    return attributedString;
}

- (void)updateFrames:(ZYJTableViewCellModel *)model
{
    CGFloat titltHeight = [model.titleString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * space20 - highlightLabelWidth, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                     attributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:titleFont],
                                  NSForegroundColorAttributeName:[UIColor blackColor],
                                  NSStrokeWidthAttributeName:@-2,
                                  NSStrokeColorAttributeName:[UIColor blackColor],
                                  }
                        context:nil].size.height;
    CGFloat oneRowHeightOftitle = [@"test" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * space20 - highlightLabelWidth, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                              attributes:@{
                                                                           NSFontAttributeName:[UIFont systemFontOfSize:titleFont],
                                                                           NSStrokeWidthAttributeName:@-2,
                                                                           }
                                                       context:nil].size.height;
    
    CGFloat detailHeight = [model.detailString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * space20 - highlightLabelWidth, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                     attributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:detailFont],
                                  }
                        context:nil].size.height;
    CGFloat oneRowHeightOfDetail = [@"test" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * space20 - highlightLabelWidth, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                     attributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:detailFont],
                                  }
                        context:nil].size.height;
    
    CGFloat oneRowHeightOfSource = [@"test" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2 * space20 - highlightLabelWidth, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                     attributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:sourceFont],
                                  }
                        context:nil].size.height;
    
    CGFloat titleLabelHeight = 0;
    CGFloat detailLabelHeight = 0;
    
    if (titltHeight > oneRowHeightOftitle) {
        self.titleLabel.numberOfLines = 2;
        self.detailLabel.numberOfLines = 1;
        titleLabelHeight = 2 * oneRowHeightOftitle;
        detailLabelHeight = oneRowHeightOfDetail;
    }
    else
    {
        self.titleLabel.numberOfLines = 1;
        self.detailLabel.numberOfLines = 2;
        titleLabelHeight = oneRowHeightOftitle;
        if (detailHeight > oneRowHeightOfDetail) {
            detailLabelHeight = 2 *oneRowHeightOfDetail;
        }
        else
        {
            detailLabelHeight = oneRowHeightOfDetail;
        }
    }
    self.highlightLabel.frame = CGRectMake(space20, topSpaceOfTitle + 1, highlightLabelWidth, oneRowHeightOftitle - 2);
    self.titleLabel.frame = CGRectMake(space20, topSpaceOfTitle, SCREEN_WIDTH - 2 * space20, titleLabelHeight);
    self.detailLabel.frame = CGRectMake(space20, topSpaceOfTitle + titleLabelHeight + spaceBetweenTitleAndDetail, SCREEN_WIDTH - 2 * space20, detailLabelHeight);
    CGFloat yOfSourceLabel = topSpaceOfTitle + titleLabelHeight + spaceBetweenTitleAndDetail + detailLabelHeight + spaceBetweenDetailAndSource;
    self.sourceLabel.frame = CGRectMake(space20, yOfSourceLabel, SCREEN_WIDTH - 2 * maxWidthOfSupportAndComment - 2 * space20, oneRowHeightOfSource);
    
    //根据赞数和评论数调整button宽度
    CGFloat supportTitleWidth = [[NSNumber numberWithInteger:model.supportCount].stringValue boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:sourceFont]} context:nil].size.width;
    CGFloat commendTitleWidth = [[NSNumber numberWithInteger:model.commentCount].stringValue boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:sourceFont]} context:nil].size.width;
    CGFloat supportWidth = supportTitleWidth + widthOfIcon;
    CGFloat commendWidth = commendTitleWidth + widthOfIcon;
    supportWidth = supportWidth > maxWidthOfSupportAndComment ? maxWidthOfSupportAndComment : supportWidth;
    commendWidth = commendWidth > maxWidthOfSupportAndComment ? maxWidthOfSupportAndComment : commendWidth;
    
    self.commentButton.frame = CGRectMake(SCREEN_WIDTH - space20 - commendWidth, yOfSourceLabel, commendWidth, oneRowHeightOfSource);
    self.supportButton.frame = CGRectMake(SCREEN_WIDTH - space20 - commendWidth - spaceBetweenSupportAndComment -supportWidth, yOfSourceLabel, supportWidth, oneRowHeightOfSource);
    
    self.height = self.sourceLabel.frame.origin.y + self.sourceLabel.frame.size.height + bottomSpaceOfSource;
}

#pragma mark - get
- (UILabel *)highlightLabel
{
    if (!_highlightLabel) {
        _highlightLabel = [[UILabel alloc] init];
        _highlightLabel.textColor = [UIColor whiteColor];
        _highlightLabel.font = [UIFont systemFontOfSize:highLightFont];
        _highlightLabel.textAlignment = NSTextAlignmentCenter;
        _highlightLabel.text = @"精";
        _highlightLabel.backgroundColor = [UIColor orangeColor];
        _highlightLabel.layer.cornerRadius = 4;
        _highlightLabel.layer.masksToBounds = YES;
    }
    return _highlightLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:detailFont];
        _detailLabel.textColor = [UIColor grayColor];
    }
    return _detailLabel;
}

- (UILabel *)sourceLabel
{
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(space20, yOfThirdLine, SCREEN_WIDTH - 2 * maxWidthOfSupportAndComment, heightOfthirdLine)];
        _sourceLabel.font = [UIFont systemFontOfSize:sourceFont];
        _sourceLabel.textColor = [UIColor grayColor];
    }
    return _sourceLabel;
}

- (UIButton *)supportButton
{
    if (!_supportButton) {
        _supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_supportButton setImage:[UIImage imageNamed:@"support.PNG"] forState:UIControlStateNormal];
        _supportButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _supportButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _supportButton.titleLabel.font = [UIFont systemFontOfSize:sourceFont];
        [_supportButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _supportButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        _commentButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:sourceFont];
        [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _commentButton;
}

#pragma mark - class method
+ (CGFloat)heightWithModel:(ZYJTableViewCellModel *)model
{
    ZYJTableViewCell *cell = [[ZYJTableViewCell alloc] init];
    [cell updateFrames:model];
    return cell.height;
}

@end
