//
//  TELoginView.m
//  ZYJProject
//
//  Created by yongjie_zou on 16/10/13.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "TELoginView.h"
#import "Masonry.h"
#import "UIColor+BJCKUtil.h"
#import "UIView+Borders.h"
#import "UIImage+Utils.h"
#import "TEConst.h"
#import "TETip.h"
#import "TEUserModel.h"
#import "NSString+Utils.h"

static NSString * const TELoginAccountString = @"请输入帐号";
static NSString * const TELoginPasswordString = @"请输入密码";
static NSString * const TELoginByJoinCodeString = @"参加码登录";
static NSString * const TELoginJoinCodeString = @"请输入参加码";
static NSString * const TELoginNickString = @"请输入昵称";
static NSString * const TELoginByAccountString = @"企业用户登录";
static NSString * const TELoginString = @"登录";
static NSString * const TEForgetPasswordString = @"忘记密码";
static NSString * const TERegisterString = @"注册帐号";


static NSString * const TEAccountIconName = @"te_avatar";
static NSString * const TEPasswordIconName = @"te_login_password";
static NSString * const TEJoinCodeIconName = @"te_join_number";
static NSString * const TENickIconName = @"te_avatar";
static NSString * const TEBaijiaIconName = @"te_baijiayun";
static NSString * const TEBackgroundIconName = @"te_login_background";

@interface TELoginView ()

//默认企业用户登陆
@property (nonatomic, assign) BOOL isBusinessAccount;
@property (nonatomic, strong) TEUserModel *userModel;

@property (nonatomic, strong) UIImageView *backgroudImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *accountImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;
@property (nonatomic, strong) UIView *divideForgetAndRegiterView;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *loginTypeButton;
@property (nonatomic, strong) UIImageView *baijiaImageView;

@end

@implementation TELoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        self.isBusinessAccount = YES;
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.backgroudImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.accountTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgetPasswordButton];
    [self addSubview:self.divideForgetAndRegiterView];
    [self addSubview:self.registerButton];
    [self addSubview:self.loginTypeButton];
    [self addSubview:self.baijiaImageView];
    
    WS(weakSelf)
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).mas_offset(150);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(23);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(280, 50));
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountTextField.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(280, 50));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTextField.mas_bottom).mas_offset(57);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(280, 50));
    }];

    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginButton.mas_bottom).mas_offset(9);
        make.left.equalTo(weakSelf.loginButton);
        make.size.mas_equalTo(CGSizeMake(56, 14));
    }];

    [self.divideForgetAndRegiterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakSelf.forgetPasswordButton);
        make.left.equalTo(weakSelf.forgetPasswordButton.mas_right).mas_offset(9);
        make.width.mas_equalTo(1);
    }];

    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.forgetPasswordButton);
        make.left.equalTo(weakSelf.divideForgetAndRegiterView.mas_right).mas_offset(9);
        make.size.equalTo(weakSelf.forgetPasswordButton);
    }];
    
    [self.loginTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakSelf.forgetPasswordButton);
        make.right.equalTo(weakSelf.loginButton);
    }];
    
    [self.baijiaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).mas_offset(-37);
        make.centerX.equalTo(weakSelf);
    }];
}

#pragma mark - private method
- (NSAttributedString *)attibutedString:(NSString *)string color:(UIColor *)color font:(UIFont *)font{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string
                                                                           attributes:@{
                                                                                        NSFontAttributeName : font,
                                                                                        NSForegroundColorAttributeName : color
                                                                                        }];
    return attributedString;
}

#pragma mark - action
- (void)onloginButton:(id)sender{
    if (self.loginCallback) {
        BOOL isLegal = YES;
        NSString *account = self.accountTextField.text;
        NSString *password = self.passwordTextField.text;
        do {
            if ((![account te_trim].length || ![password te_trim])){
                isLegal = NO;
                break;
            }
            
            if (self.isBusinessAccount) {
                if (![account te_validateEmail]){
                    isLegal = NO;
                    break;
                }
                else if (![password te_validatePassword]){
                    isLegal = NO;
                    break;
                }
            } else {
                if (![account te_validateOnlyNumber]) {
                    isLegal = NO;
                    break;
                } else if (![password te_validatePassword]) {
                    isLegal = NO;
                    break;
                }
            }
        } while (0);
        self.loginCallback(self.userModel, isLegal);
    }
}

- (void)onForgetButton:(id)sender{
    [TETip show:@"点击“忘记密码”"];
}

- (void)onRegisterButton:(id)sender{
    [TETip show:@"点击“注册帐号”"];
}

- (void)onLoginTypeButton:(id)sender{
    self.isBusinessAccount = !self.isBusinessAccount;
}

#pragma mark - get set
- (TEUserModel *)userModel{
    if (!_userModel) {
        _userModel = [[TEUserModel alloc] init];
    }
    _userModel.account = self.accountTextField.text;
    _userModel.password = self.passwordTextField.text;
    return _userModel;
}

- (UIImageView *)backgroudImageView{
    if (!_backgroudImageView){
        _backgroudImageView = [[UIImageView alloc] init];
        _backgroudImageView.image = [UIImage imageNamed:TEBackgroundIconName];
    }
    return _backgroudImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"BDZYJT--GB1-0" size:58];
        _titleLabel.textColor = TE_COLOR(@"ffffff");
        _titleLabel.text = @"百家直播";
    }
    return _titleLabel;
}

- (UITextField *)accountTextField{
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.backgroundColor = [UIColor bjck_colorWithHexString:@"ffffff" alpha:0.4];
        _accountTextField.font = TE_FONT(16);
        _accountTextField.leftView = self.accountImageView;
        _accountTextField.leftViewMode = UITextFieldViewModeAlways;
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_accountTextField te_addBottomBorderWithHeight:1 color:[UIColor bjck_colorWithHexString:@"ffffff" alpha:0.8] leftOffset:10 rightOffset:0 andBottomOffset:0];
    }
    return _accountTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField){
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor bjck_colorWithHexString:@"ffffff" alpha:0.4];
        _passwordTextField.font = TE_FONT(16);
        _passwordTextField.leftView = self.passwordImageView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIImageView *)accountImageView{
    if (!_accountImageView) {
        _accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 50)];
        _accountImageView.contentMode = UIViewContentModeCenter;
    }
    return _accountImageView;
}

- (UIImageView *)passwordImageView{
    if (!_passwordImageView) {
        _passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 50)];
        _passwordImageView.contentMode = UIViewContentModeCenter;
    }
    return _passwordImageView;
}

- (UIButton *)loginButton{
    if (!_loginButton){
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:TELoginString forState:UIControlStateNormal];
        [_loginButton setTitleColor:TE_COLOR(@"ffffff") forState:UIControlStateNormal];
        _loginButton.titleLabel.font = TE_FONT(16);
        _loginButton.layer.cornerRadius = 2;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton setBackgroundImage:[UIImage te_imageWithColor:TE_COLOR(@"1694ff") size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(onloginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)forgetPasswordButton{
    if (!_forgetPasswordButton){
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_forgetPasswordButton setTitle:TEForgetPasswordString forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:TE_COLOR(@"ffffff") forState:UIControlStateNormal];
        _forgetPasswordButton.titleLabel.font = TE_FONT(14);
        [_forgetPasswordButton addTarget:self action:@selector(onForgetButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
}

- (UIButton *)registerButton{
    if (!_registerButton){
        _registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerButton setTitle:TERegisterString forState:UIControlStateNormal];
        [_registerButton setTitleColor:TE_COLOR(@"ffffff") forState:UIControlStateNormal];
        _registerButton.titleLabel.font = TE_FONT(14);
        [_registerButton addTarget:self action:@selector(onRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIView *)divideForgetAndRegiterView{
    if (!_divideForgetAndRegiterView) {
        _divideForgetAndRegiterView = [[UIView alloc] init];
        _divideForgetAndRegiterView.backgroundColor = TE_COLOR_WHITE;
    }
    return _divideForgetAndRegiterView;
}

- (UIButton *)loginTypeButton{
    if (!_loginTypeButton){
        _loginTypeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginTypeButton setTitleColor:TE_COLOR(@"ffffff") forState:UIControlStateNormal];
        _loginTypeButton.titleLabel.font = TE_FONT(14);
        [_loginTypeButton addTarget:self action:@selector(onLoginTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginTypeButton;
}

- (UIImageView *)baijiaImageView{
    if (!_baijiaImageView){
        _baijiaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TEBaijiaIconName]];
    }
    return _baijiaImageView;
}

- (void)setIsBusinessAccount:(BOOL)isBusinessAccount{
    _isBusinessAccount = isBusinessAccount;
    if (isBusinessAccount) {
        self.accountImageView.image = [UIImage imageNamed:TEAccountIconName];
        self.passwordImageView.image = [UIImage imageNamed:TEPasswordIconName];
        self.accountTextField.attributedPlaceholder = [self attibutedString:TELoginAccountString color:TE_COLOR(@"ffffff") font:TE_FONT(16)];
        self.passwordTextField.attributedPlaceholder = [self attibutedString:TELoginPasswordString color:TE_COLOR(@"ffffff") font:TE_FONT(16)];
        self.accountTextField.text = @"";
        self.passwordTextField.text = @"";
        self.accountTextField.keyboardType = UIKeyboardTypeAlphabet;
        self.passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
        self.forgetPasswordButton.hidden = NO;
        self.divideForgetAndRegiterView.hidden = NO;
        self.registerButton.hidden = NO;
        [self.loginTypeButton setTitle:TELoginByJoinCodeString forState:UIControlStateNormal];
    }
    else{
        self.accountImageView.image = [UIImage imageNamed:TEJoinCodeIconName];
        self.passwordImageView.image = [UIImage imageNamed:TENickIconName];
        self.accountTextField.attributedPlaceholder = [self attibutedString:TELoginJoinCodeString color:TE_COLOR(@"ffffff") font:TE_FONT(16)];
        self.passwordTextField.attributedPlaceholder = [self attibutedString:TELoginNickString color:TE_COLOR(@"ffffff") font:TE_FONT(16)];
        self.accountTextField.text = @"";
        self.passwordTextField.text = @"";
        self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
        self.forgetPasswordButton.hidden = YES;
        self.divideForgetAndRegiterView.hidden = YES;
        self.registerButton.hidden = YES;
        [self.loginTypeButton setTitle:TELoginByAccountString forState:UIControlStateNormal];
    }
}

@end
