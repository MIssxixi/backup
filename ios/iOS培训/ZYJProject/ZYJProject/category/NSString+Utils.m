//
//  NSString+Utils.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)te_trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)te_validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)te_validatePassword{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)te_validateOnlyNumber{
//    NSString *string = @"@\"^[0-9]*\"";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
//    
//    return [predicate evaluateWithObject:self];
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

- (BOOL)te_validateNickName{
    NSString *string = @"^[\\u4e00-\\u9fa5]{4,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
    
    return [predicate evaluateWithObject:self];
}

@end
