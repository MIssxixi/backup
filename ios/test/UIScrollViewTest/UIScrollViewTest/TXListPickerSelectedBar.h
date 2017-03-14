//
//  TXListPickerSelectedBar.h
//  Pods
//
//  Created by yongjie_zou on 2016/11/7.
//
//

#import <UIKit/UIKit.h>

@interface TXListPickerSelectedBar : UIView

@property (nonatomic, copy) void(^didRemoveItem)(id item, NSIndexPath index);

- (void)addImage:(UIImage *)image;
- (void)addTitle:(NSString *)title;

@end
