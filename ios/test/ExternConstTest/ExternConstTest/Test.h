//
//  Test.h
//  ExternConstTest
//
//  Created by yongjie_zou on 16/7/18.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Test_h
#define Test_h

/**
 *  使用const在任意文件中定义 ，外部都能访问。并且编译时会进行类型检查。
 */

/**
 *  会报重复定义的错误
 */
//const NSString *constStringFromH;
//
//const NSString * constPointerFromH;

FOUNDATION_EXTERN NSString *const externConstString;

#endif /* Test_h */

@interface TraceObj : NSObject

+ (void)helloWorld;

@end