//
//  ViewController.m
//  TextViewTest
//
//  Created by yongjie_zou on 2016/11/29.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    __weak typeof(&*self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    self.textView.text = @"test";
    self.textView.scrollEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor redColor];
    if (indexPath.row == 6) {
        [cell.contentView addSubview:self.textView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 30;
    }
    return 100;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    endFrame = [self.view convertRect:endFrame fromView:nil];
    CGFloat offset = self.view.bounds.size.height - endFrame.origin.y;
    
    [UIView animateKeyframesWithDuration:duration delay:0.0f options:(curve | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-offset);
        }];
        [self.view layoutIfNeeded];//强制绘制
    } completion:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.dragging) {
        [self.textView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
