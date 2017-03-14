//
//  TEUserModel.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Foundation/Foundation.h>

@interface TEUserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *autoToken;

@end
