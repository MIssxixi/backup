//
//  TXKeyboardHelperConstants.h
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/1.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  键盘事件
 */
typedef NS_ENUM(NSInteger, TXKeyboardEvent) {
    /**
     *  未知事件
     */
    TXKeyboardEventNone,
    /**
     *  键盘将要显示
     */
    TXKeyboardEventWillShow,
    /**
     *  键盘将要隐藏
     */
    TXKeyboardEventWillDismiss,
    /**
     *  键盘位置、大小发生变化
     */
    TXKeyboardEventChangeFrame,
};
