//
//  TELoginView.h
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TEUserModel;

@interface TELoginView : UIView

@property (nonatomic, strong, readonly) TEUserModel *userModel;
@property (nonatomic, copy) void (^loginCallback)(TEUserModel *userModel, BOOL isLegal);

@end
