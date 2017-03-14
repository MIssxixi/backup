//
//  UIWindow+TXHierarchy.h
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/2.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (TXHierarchy)

@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
