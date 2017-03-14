//
//  NSString+Utils.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)te_trim;

- (BOOL)te_validateEmail;
- (BOOL)te_validatePassword;
- (BOOL)te_validateOnlyNumber;
- (BOOL)te_validateNickName;

@end
