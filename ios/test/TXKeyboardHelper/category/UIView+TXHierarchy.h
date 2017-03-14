//
//  UIView+TXHierarchy.h
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/2.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TXHierarchy)

/**
 *  视图层次中最顶层的视图控制器
 */
@property (nonatomic, strong, readonly)UIViewController *topMostController;

/**
 *  包含此视图的视图控制器
 */
@property (nonatomic, strong, readonly)UIViewController *viewController;

/**
 *  是否是alertView中的输入框
 */
@property (nonatomic, assign, readonly)BOOL isAlertViewTextField;

/**
 *  找到类型为classType的父视图
 *
 *  @param classType 
 *
 *  @return 
 */
- (UIView *)superviewOfClassType:(Class)classType;

@end
