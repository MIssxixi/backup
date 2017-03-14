//
//  TXKeyboardHelper.h
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/1.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TXKeyboardHelperConstants.h"

CF_ASSUME_NONNULL_BEGIN

@interface TXKeyboardHelper : NSObject

/**
 *  键盘到输入框相对位置的距离，默认距离输入框10px
 */
@property (nonatomic, assign)CGFloat keyboardDistanceFromTextField; 

/**
 *  全局设置，设置TXKeyboardHelper是否可用，默认为YES，可用
 */
@property (nonatomic, assign)BOOL enable;

/**
 *  设置点击输入框外部是否resignFirstResponder，默认为YES，点击外部失去焦点
 */
@property (nonatomic, assign)BOOL shouldResignOnTouchOutside;

+ (instancetype)sharedInstance;

/**
 *  设置对于某个视图及其子视图是否允许TXKeyboardManager来管理
 *
 *  @param enable 
 *  @param viewController   
 */
- (void)setEnable:(BOOL)enable forViewController:(UIViewController *)viewController;

/**
 *  键盘出现、隐藏或改变大小时，提供回调方法，让外界可以进行处理
 *
 *  @param handler       
 *  @param keyboardEvent 
 *  @param viewController     
 */
- (void)addHandler:(void(^)(NSNotification *notification))handler 
     keyboardEvent:(TXKeyboardEvent)keyboardEvent 
 forViewController:(UIViewController *)viewController;

/**
 *  移除对于键盘事件的处理
 *
 *  @param keyboardEvent 
 *  @param viewController     
 */
- (void)removeHandlerWithKeyboardEvent:(TXKeyboardEvent)keyboardEvent 
                     forViewController:(UIViewController *)viewController;

/**
 *  移除对于键盘事件的处理
 *
 *  @param viewController 
 */
- (void)removeHandlerForViewController:(UIViewController *)viewController;

/**
 *  需要使用sharedInstance获取实例
 *
 *  @return 
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  需要使用sharedInstance获取实例
 *
 *  @return 
 */
+ (instancetype)new NS_UNAVAILABLE;

@end

CF_ASSUME_NONNULL_END
