//
//  TELoginViewController.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TELoginViewController.h"
#import "TELoginView.h"
#import "TEConst.h"
#import "Masonry.h"
#import "TEUserManager.h"
#import "TEMyLiveViewController.h"
#import "TEService.h"
#import "TEUserModel.h"

static NSString * const TEUserAccountKey = @"TEUserAccountKey";

@interface TELoginViewController ()

@property (nonatomic, strong) TEUserModel *userModel;
@property (nonatomic, strong) TELoginView *loginView;

@end

@implementation TELoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
    
    WS(weakSelf)
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - network
- (void)login{
    WS(weakSelf)
    [[TEService shareInstance] login:self.userModel callback:^(id response, NSString *errorMessage) {
//        weakSelf.userModel = response;
        weakSelf.userModel = weakSelf.loginView.userModel;
        [[TEUserManager shareInstance] setUserAccount:weakSelf.userModel];
        TEMyLiveViewController *liveViewController = [[TEMyLiveViewController alloc] init];
        [weakSelf.navigationController pushViewController:liveViewController animated:YES];
        [weakSelf.view removeFromSuperview];
    }];
}

#pragma mark - get
- (TELoginView *)loginView{
    if (!_loginView){
        _loginView = [TELoginView new];
        WS(weakSelf)
        [_loginView setLoginCallback:^(TEUserModel *model, BOOL isLegal) {
            if (isLegal) {
                weakSelf.userModel = model;
                [weakSelf login];
            }
        }];
    }
    return _loginView;
}

@end
