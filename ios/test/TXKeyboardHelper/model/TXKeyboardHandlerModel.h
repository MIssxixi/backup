//
//  TXKeyboardHandlerModel.h
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/1.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXKeyboardHelperConstants.h"

@interface TXKeyboardHandlerModel : NSObject

@property (nonatomic, copy)void (^handler)(NSNotification *notification);
@property (nonatomic, assign)TXKeyboardEvent keyboardEvent;
@property (nonatomic, weak)id target;

@end
