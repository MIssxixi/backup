//
//  ViewController.m
//  Demo
//
//  Created by Mac_ZL on 16/7/28.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewDemoViewController.h"
#import "TableViewDemoController.h"
@interface ViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupView
{
    //添加Label
    [self setupLabel];
    //添加ImagView
    [self setUpImageView];
    //添加Button
    [self setupButton];
    //添加TextField
    [self setupTextField];
    //添加TextView
    [self setTextView];
    //添加ScrollView
    //[self setupScrollView];
    
}
- (void)setupLabel
{
    // 初始化
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    // 设置文字
    [label setText:@"This is a test text.This is a test text.This is a test text."];
    // 设置文字字体
    // 使用系统字体   "Helvetica Neue"
    [label setFont:[UIFont systemFontOfSize:42]];
    // 使用系统字体加粗
    //[label setFont:[UIFont boldSystemFontOfSize:20]];
    // 指定字体
    //查看已安装的字体集
//     NSLog(@"font is %@",[UIFont familyNames]);
//    [label setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    
    // 设置标签文字颜色
    [label setTextColor:[UIColor blueColor]];
    // 设置标签背景颜色
    [label setBackgroundColor:[UIColor clearColor]];
    // 设置标签文字对齐方式
    [label setTextAlignment:NSTextAlignmentCenter];
    
    // 设置标签文字自动折行方式
    [label setLineBreakMode:NSLineBreakByTruncatingMiddle];
    
    // 文本自动折行方式有以下几种：
    //    enum {
    //        NSLineBreakByWordWrapping = 0,  以单词为显示单位显示，后面部分省略不显示，默认
    //        NSLineBreakByCharWrapping,      以字符为显示单位显示，后面部分省略不显示
    //        NSLineBreakByClipping,          剪切与文本宽度相同的内容长度，后半部分被删除
    //        NSLineBreakByTruncatingHead,    开头省略，显示尾部文字内容
    //        NSLineBreakByTruncatingTail,    结尾省略，显示开头的文字内容
    //        NSLineBreakByTruncatingMiddle   中间省略，显示头尾的文字内容
    //    } NSLineBreakMode;
    
    // 设置标签文字行数，0表示多行 默认1
    [label setNumberOfLines:1];
    // 设置阴影颜色
    //[label setShadowColor:[UIColor blackColor]];
    // 设置阴影偏移量
    //[label setShadowOffset:CGSizeMake(-2, -2)];
    // 设置字体大小适应label宽度
//    [label setAdjustsFontSizeToFitWidth:YES];
    // 如果adjustsFontSizeToFitWidth属性设置为YES，这个属性就来控制文本基线的行为
    [label setBaselineAdjustment:UIBaselineAdjustmentNone];
    
    // 文本基线类型有以下几种：
    //    typedef enum {
    //        UIBaselineAdjustmentAlignBaselines,  文本最上端与中线对齐，默认
    //        UIBaselineAdjustmentAlignCenters,    文本中线与标签中线对齐
    //        UIBaselineAdjustmentNone,            文本最底端与标签中线对齐
    //    } UIBaselineAdjustment;
    
    //设置能否与用户进行交互
    //参考UIImageView的例子
    //[label setUserInteractionEnabled:YES];
    // 设置标签边框
    [label.layer setBorderColor:[UIColor grayColor].CGColor];
    // 设置边框粗细
    [label.layer setBorderWidth:2];
    [label.layer setCornerRadius:4];
    
    // 多行标签高度自适应
    // 设置标签字体属性
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"This is a test text.This is a test text.This is a test text."];
         [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 6)];
         [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 8)];
         [label setAttributedText:attStr];
    
    // 获取标签根据文本和字体自适应后的高度，此处CGSizeMake为最大外框大小
    //
    //    typedef NS_OPTIONS(NSInteger, NSStringDrawingOptions) {
    //        NSStringDrawingUsesLineFragmentOrigin = 1 << 0,绘制文本的时候指定的原点不是baseline origin，而是line fragement origin
    //        NSStringDrawingUsesFontLeading = 1 << 1,//计算行高使用行间距（字体高+行间距=行高）
    //        NSStringDrawingUsesDeviceMetrics = 1 << 3,//计算布局时使用图元文字,而不是印刷字体。
    //        NSStringDrawingTruncatesLastVisibleLine NS_ENUM_AVAILABLE(10_5, 6_0) = 1 << 5,//如果显示不完全，会截断，最后一行末尾显示...。如果没有指定NSStringDrawingUsesLineFragmentOrigin，这个选项会被忽略
    //
    //    }
    
    NSDictionary *labelAttr = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName,nil];
    //
    CGFloat labelHeight = [@"This is a test text.This is a test text.This is a test text." boundingRectWithSize:CGSizeMake(280, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:labelAttr context:nil].size.height;
    NSLog(@"labelHeight is %f",labelHeight);
    [self.view addSubview:label];
}

- (void)setUpImageView
{
    CGFloat originY = 150;
    //初始化
    //两种方式
    UIImageView *imgView;
//    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, originY, 45, 45)];
//    [imgView setImage:[UIImage imageNamed:@"loading_1.png"]];
    //
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_1"]];
    [imgView setFrame:CGRectMake(50, originY, imgView.frame.size.width, imgView.frame.size.height)];
    
    [self.view addSubview:imgView];
    
    //帧动画

    //设置后就隐藏image的属性
    [imgView setAnimationImages:[self imagesForAnimating:@"loading_"]];
    //设置动画的时间
    [imgView setAnimationDuration:1];
    //设置动画的重复次数
    [imgView setAnimationRepeatCount:10];
    //开启动画
    [imgView startAnimating];
    

    //设置能否与用户进行交互 默认NO
    //这个比较常用,但又容易忽视这个属性
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [bgImgView setFrame:CGRectMake(125, originY, bgImgView.frame.size.width, bgImgView.frame.size.height)];
    [bgImgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgImgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn setCenter:CGPointMake(bgImgView.frame.size.width/2, bgImgView.frame.size.height/2)];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:btn];
    
}
- (void)setupButton
{
    //初始化
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.frame.size.width/2-100, 280, 200, 40)];
    //setBackgroundImage 和 setImage的区别
    /**
     * setBackgroundImage顾名思义设置背景图片 setIamge是相当于设置icon
     * setBackgroundImage会根据btn 的 大小，平铺背景图片 setImage对图片的尺寸不做修改
     * 从视图层级来说，Button的title是在背景图片之上，跟image同层级，默认是image在左，title在右
     */
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn_orange_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ic_good_big_gray"] forState:UIControlStateNormal];
    
    //设置title
    [btn setTitle:@"演示Demo" forState:UIControlStateNormal];
    //设置属性字符串作为title
    //    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"登录"];
    //    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, 1)];
    //
    //    [btn setAttributedTitle:attStr forState:UIControlStateNormal];
    [btn setTitle:@"进入Demo" forState:UIControlStateHighlighted];
    //设置title的字体大小
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    //设置title的颜色
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //设置内容水平方向对齐方式
//    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //调整button的title的偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    //调整button的image的偏移
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    //规则：同坐标系上，两值相等，不移动；两值相加为零，移动|值|的距离
  
    //如何把图片和文字换一下位置？
    //用到了两个属性:titleEdgeInsets imageEdgeInsets
    [self rightAlignButtonImage:btn];
    //添加方法
    [btn addTarget:self action:@selector(demo2BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)rightAlignButtonImage:(UIButton *)btn
{
    //图片与标题的间隙
    CGFloat space = 5;
    //图片的宽度
    CGFloat imageWidth = CGRectGetWidth([btn imageRectForContentRect:btn.bounds]);
    //调整
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth - space/2, 0, imageWidth + space/2)];
    //title的宽度
    CGFloat titleWidth = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font].width;
    [btn setImageEdgeInsets: UIEdgeInsetsMake(0, titleWidth + space/2, 0, - titleWidth - space/2)];
    //这种通用的方法，我们可以在UIButton的Category中实现

}

- (void)showAlert
{
    //iOS7以下使用
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点击提示" message:@"button is pressed" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alertView show];
}
- (void)showActionSheet
{
    //iOS7以下使用
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"点击提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:@"知道了", nil];
    [actionSheet showInView:self.view];
}
- (void)showAlertController:(UIAlertControllerStyle)style
{
    //iOS8 + 推荐使用
    //初始化 UIAlertController
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"点击提示" message:@"button is Pressed!" preferredStyle:style];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Ok");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupTextField
{
    //初始化
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 350, 200, 30)];
    //设置边框样式
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    //设置placeholder
    [textField setPlaceholder:@"请输入手机号"];
    //设置字体颜色
    [textField setTextColor:[UIColor grayColor]];
    //设置字体
    [textField setFont:[UIFont systemFontOfSize:14]];
    //设置键盘类型
    [textField setKeyboardType:UIKeyboardTypeDefault];
    //设置键盘的返回类型
    [textField setReturnKeyType:UIReturnKeySearch];
    //设置对齐方式
    [textField setTextAlignment:NSTextAlignmentCenter];
    //是否密文输入
    [textField setSecureTextEntry:YES];
    //自定义键盘
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,300)];
//    [textField setInputView:customView];
    //设置左右视图
    //左右视图，可以是任意的View，通常一般会放图片，按钮
    //右视图通常都是默认的系统清除键
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"ic_good_big"] forState:UIControlStateNormal];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightView setBackgroundColor:[UIColor redColor]];
    
    [textField setLeftView:leftBtn];
    [textField setRightView:rightView];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    //设置delegate
    [textField setDelegate:self];
    [self.view addSubview:textField];
}
- (void)setTextView
{
    //与UITextField的区别：
    //textField是单行，textView支持多行
    //textFiedl支持placeholder,textView不支持，需要自己实现
    //delegate基本都一样，不同的是textView 按下return键，没有单独的delegate,需要自己实现
    //初始化
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 320, 300, 100)];
    [textView setDelegate:self];
    [textView setBackgroundColor:[UIColor grayColor]];
    //是否滚动
    [textView setScrollEnabled:YES];

    [self.view addSubview:textView];
    
    //如何处理键盘遮挡的问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    
}

#pragma mark - Fun
- (void)btnPressed:(UIButton *)sender
{
    NSLog(@"button is Pressed");
//    [self showActionSheet];
    [self showAlertController:UIAlertControllerStyleActionSheet];
}
- (void)demoBtnPressed:(UIButton *)sender
{
    ScrollViewDemoViewController *demoVC = [[ScrollViewDemoViewController alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}
- (void)demo2BtnPressed:(UIButton *)sender
{
    TableViewDemoController *demoVC = [[TableViewDemoController alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}

#pragma mark - Inter
- (NSArray *)imagesForAnimating:(NSString *)name
{
    NSInteger numberOfFramesInAnimation = 7;
    NSMutableArray *retVal = [NSMutableArray array];
    
    for(int i = 0; i < numberOfFramesInAnimation; i++)
    {
        [retVal addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",name, i+1]]];
    }
    return retVal;
}
- (void)keyBoardWillShow:(NSNotification *)notification {
    //获取键盘高度
    NSValue *value = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView animateWithDuration:.4 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= keyboardSize.height;
        self.view.frame = viewFrame;
    }];

}

- (void)keyBoardWillHidden:(NSNotification *)notification {
    //获取键盘高度
    NSValue *value = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [UIView animateWithDuration:.4
                     animations:^{
                         CGRect viewFrame = self.view.frame;
                         viewFrame.origin.y += keyboardSize.height;
                         self.view.frame = viewFrame;
                     }];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        NSLog(@"Alertview:Ok");
    }
    else
    {
        NSLog(@"Alertview:Cancle");
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alertview did dismiss");
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alertview will dismiss");
}
#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        NSLog(@"ActionSheet:Ok");
    }
    else
    {
        NSLog(@"ActionSheet:Cancle");
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"ActionSheet did dismiss");
}
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"ActionSheet will dismiss");
}

#pragma mark - UITextField Delegate
//是否进入编辑模式 默认返回YES，进入编辑模式。NO不进入编辑模式
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    NSLog(@"textField should begin editing");
    return YES;
}
//进入编辑模式
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    NSLog(@"textField did begin editing");
}
//是否退出编辑模式 默认返回YES，退出编辑模式。NO不退出编辑模式
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    NSLog(@"textfield should end editing");
    return YES;
}
//退出编辑模式
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    NSLog(@"textfield did end editing");
}
//当输入任何字符时，代理调用该方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSLog(@"rang is %@ replacementString is %@",NSStringFromRange(range),string);
    //例子：可以做输入长度限制
    if (range.location>=11)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
    return YES;
}
//点击清除按钮是否清除
- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    return YES;
}
//点击键盘上Return按钮时候调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    //取消第一响应
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
