//
//  TELiveClassModel.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TELiveClassModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) long long timestamp;

@end
