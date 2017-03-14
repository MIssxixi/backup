//
//  TETip.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/14.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TETip.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "TEConst.h"

static NSInteger const TETagTip = 718191;

@implementation TETip

+ (void)show:(NSString *)message {
    UIView *toView = [UIApplication sharedApplication].keyWindow;
    if (toView == nil) {
        toView = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *lastHud = (MBProgressHUD *)[toView viewWithTag:TETagTip];
    if (lastHud) {
        [lastHud hide:NO];
        [lastHud removeFromSuperview];
        lastHud = nil;
    }
    
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:toView];
    [toView addSubview:hud];
    //    hud.yOffset = -keyBoardHeight/2;
    hud.detailsLabelFont = TE_TIP_FONT;
    hud.detailsLabelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.tag = TETagTip;
    hud.yOffset = 0;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
    } completionBlock:^{
        [hud removeFromSuperview];
        hud = nil;
    }];
}

@end
