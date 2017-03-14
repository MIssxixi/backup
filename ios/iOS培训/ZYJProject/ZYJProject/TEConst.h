//
//  ZYJConst.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+BJCKUtil.h"

@interface TEConst : NSObject

#define TE_SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define TE_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define TE_FONT(fontSize)          [UIFont systemFontOfSize:fontSize]
#define TE_COLOR(colorString)      [UIColor bjck_colorWithHexString:colorString]

#define TE_COLOR_WHITE             TE_COLOR(@"ffffff")
#define TE_TIP_FONT                TE_FONT(15)

@end
