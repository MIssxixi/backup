//
//  UIView+Borders.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "UIView+Borders.h"
#import "Masonry.h"
#import "TEConst.h"

@implementation UIView (Borders)

- (void)te_addBottomBorderWithHeight:(CGFloat)height color:(UIColor *)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset{
    UIView *borderView = [UIView new];
    [self addSubview:borderView];
    
    WS(weakSelf)
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).mas_offset(leftOffset);
        make.bottom.equalTo(weakSelf).mas_offset(-bottomOffset);
        make.right.equalTo(weakSelf).mas_offset(rightOffset);
        make.height.mas_equalTo(height);
    }];
    borderView.backgroundColor = color;
}

@end
