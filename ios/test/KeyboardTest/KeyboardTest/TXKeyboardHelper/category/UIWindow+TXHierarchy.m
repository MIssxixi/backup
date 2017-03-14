//
//  UIWindow+TXHierarchy.m
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/2.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import "UIWindow+TXHierarchy.h"

@implementation UIWindow (TXHierarchy)

- (UIViewController *)topMostController {
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
    }
    return topController;
}

- (UIViewController *)currentViewController {
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    return currentViewController;
}

@end
