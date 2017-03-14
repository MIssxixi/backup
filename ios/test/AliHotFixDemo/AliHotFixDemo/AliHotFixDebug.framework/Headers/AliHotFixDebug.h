//
//  AliHotFixDebug.h
//
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * HotFix 调试工具。
 */
@interface AliHotFixDebug : NSObject

/**
 * 在指定的 ViewController 上显示 HotFix 调试界面。
 */
+ (void)showDebug:(UIViewController *)parentViewController;


/**
 * Hotfix 本地调试 'Patch' 接口
 */
+ (void)runPatch:(NSString *)patchDirectory;

@end
