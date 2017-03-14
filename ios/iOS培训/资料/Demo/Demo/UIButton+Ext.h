//
//  UIButton+Ext.h
//  BJEducation_student
//
//  Created by Mac_ZL on 14-8-27.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton(UIButtonExt)
- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;
- (void)resetCenterImageAndTitle;
- (void)rightAlignButtonImage:(CGFloat) space;

- (void)titleBeforeImage:(CGFloat) space;

- (float)buttonLength;
- (float)buttonHeight;
- (float )buttonLength:(NSString *)strString withFont:(UIFont *)font;
- (float)buttonHeight:(NSString *)strString withFont:(UIFont *)font;
@end
