//
//  UIView+TXHierarchy.m
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/2.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import "UIView+TXHierarchy.h"

@implementation UIView (TXHierarchy)

- (UIViewController *)viewController {
    id nextResponder = self;
    do {
        nextResponder = [nextResponder nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            break;
        }
    } while (nextResponder);
    return nextResponder;
}

- (UIViewController *)topMostController {
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    UIViewController *topController = self.window.rootViewController;
    if(topController) {
        [controllersHierarchy addObject:topController];
    }
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    id matchController = [self viewController];
    while (matchController && ![controllersHierarchy containsObject:matchController]) {
        do {
            matchController = [matchController nextResponder];
        } while (matchController && ![matchController isKindOfClass:[UIViewController class]]);
    }
    return matchController;
}

- (UIView *)superviewOfClassType:(Class)classType {
    UIView *superview = self.superview;
    Class UITableViewCellScrollViewClass = NSClassFromString(@"UITableViewCellScrollView");
    Class UITableViewWrapperViewClass = NSClassFromString(@"UITableViewWrapperView");
    Class UIQueuingScrollViewClass = NSClassFromString(@"_UIQueuingScrollView");
    while (superview) {
        if([superview isKindOfClass:classType] 
           && ![superview isKindOfClass:UITableViewCellScrollViewClass]
           && ![superview isKindOfClass:UITableViewWrapperViewClass]
           && ![superview isKindOfClass:UIQueuingScrollViewClass]) {
            break;
        }
        superview = superview.superview;
    }
    return superview;
}

- (BOOL)isAlertViewTextField {
    Class UIAlertSheetTextFieldClass = NSClassFromString(@"UIAlertSheetTextField");
    Class UIAlertSheetTextFieldClass_iOS8 = NSClassFromString(@"_UIAlertControllerTextField");
    return ([self isKindOfClass:UIAlertSheetTextFieldClass] || [self isKindOfClass:UIAlertSheetTextFieldClass_iOS8]);
}

@end
