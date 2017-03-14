//
//  UIButton+Ext.m
//  BJEducation_student
//
//  Created by Mac_ZL on 14-8-27.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UIButton+Ext.h"

#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

@implementation UIButton(UIButtonExt)

- (void)centerImageAndTitle:(float)spacing
{
    
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = self.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), 0.0, 0.0, - titleSize.width);
   
    

}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}
- (void)rightAlignButtonImage:(CGFloat) space
{
    //Right-align the button image
    
    CGFloat imageWidth = CGRectGetWidth([self imageRectForContentRect:self.bounds]);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space/2, 0, imageWidth + space/2);
    CGFloat titleWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + space/2, 0, - titleWidth - space/2);
}
- (void)titleBeforeImage:(CGFloat) space
{
    //[self setTitle]之后调用

    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width-space, 0, self.imageView.frame.size.width+space) ];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}
- (void)resetCenterImageAndTitle
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0.0, 0.0);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
}
- (float)buttonLength
{
    float width = 0.0;
    CGSize labsize = CGSizeZero;
    UIFont *font = self.titleLabel.font;
    NSString *strString = self.titleLabel.text;
    if (SYSTEM_VERSION < 7 ) {
        labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [strString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    width = labsize.width;
    return width;
}

- (float)buttonHeight
{
    float Height = 0.0;
    CGSize labsize = CGSizeZero;
    UIFont *font = self.titleLabel.font;
    NSString *strString = self.titleLabel.text;
    if (SYSTEM_VERSION < 7 ) {
        labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width,MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [strString boundingRectWithSize:CGSizeMake(self.frame.size.width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    Height = labsize.height;
    return Height;
}

- (float )buttonLength:(NSString *)strString{
    float width = 0.0;
    CGSize labsize = CGSizeZero;
    UIFont *font = self.titleLabel.font;
    if (SYSTEM_VERSION < 7) {
        labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [strString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    width = labsize.width;
    return width;
}

- (float )buttonLength:(NSString *)strString withFont:(UIFont *)font{
    float width = 0.0;
    CGSize labsize = CGSizeZero;
    if (SYSTEM_VERSION < 7.0) {
        labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [strString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    
    width = labsize.width;
    return width;
}

- (float)buttonHeight:(NSString *)strString withFont:(UIFont *)font
{
    float height = 0.0;
    CGSize labsize = CGSizeZero;
    if (SYSTEM_VERSION < 7 ) {
        labsize = [strString sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
    {
        labsize = [strString boundingRectWithSize:CGSizeMake(self.frame.size.width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }
    height = labsize.height;
    return height;
}

@end
