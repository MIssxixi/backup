//
//  ViewController.m
//  ZYJSQLite
//
//  Created by yongjie_zou on 16/9/30.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "ZYJDB.h"
#import "sqlite3.h"
#import "StudentModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

static NSInteger const TotalCount = 10000;

@interface ItemView : UIView

@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *useTransactionLabel;
@property (nonatomic, strong) UISwitch *useTransactionSwitch;
@property (nonatomic, strong) UILabel *useGCDLabel;
@property (nonatomic, strong) UISwitch *useGCDSwitch;
@property (nonatomic, copy) void(^onButton)();

@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    CGFloat height = 20;
    self.progressLabel.frame = CGRectMake(0, 10, SCREEN_WIDTH / 2.0, height);
    self.timeLabel.frame = CGRectMake(0, 30, SCREEN_WIDTH / 2.0, height);
    self.button.frame = CGRectMake(SCREEN_WIDTH / 2.0, 25, SCREEN_WIDTH / 2.0, height);
    
    [self addSubview:self.progressLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.button];
}

- (void)tapButton
{
    if (self.onButton)
    {
        self.onButton();
    }
}

#pragma mark - get
- (UILabel *)progressLabel
{
    if (!_progressLabel)
    {
        _progressLabel = [UILabel new];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _progressLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)useTransactionLabel
{
    if (!_useTransactionLabel)
    {
        _useTransactionLabel = [UILabel new];
        _useTransactionLabel.textAlignment = NSTextAlignmentCenter;
        _useTransactionLabel.text = @"是否开启事务";
    }
    return _useTransactionLabel;
}

- (UISwitch *)useTransactionSwitch
{
    if (!_useTransactionSwitch)
    {
        _useTransactionSwitch = [UISwitch new];
    }
    return _useTransactionSwitch;
}

- (UILabel *)useGCDLabel
{
    if (!_useGCDLabel)
    {
        _useGCDLabel = [UILabel new];
        _useGCDLabel.textAlignment = NSTextAlignmentCenter;
        _useGCDLabel.text = @"是否采用GCD";
    }
    return _useGCDLabel;
}

- (UISwitch *)useGCDSwitch
{
    if (!_useGCDSwitch)
    {
        _useGCDSwitch = [UISwitch new];
    }
    return _useGCDSwitch;
}

@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray <StudentModel *> *studentsArray;
@property (nonatomic, strong) UILabel *dataLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
    [ZYJDB creatStudentTable];
}

- (void)setupSubviews
{
    CGRect frame1 = CGRectMake(0, 64, SCREEN_WIDTH, 70);
    CGRect frame2 = CGRectMake(0, 64 + 70, SCREEN_WIDTH, 70);
    ItemView *itemView1 = [self getInsertItemViewWithFrame:frame1 useTransaction:YES useGCD:NO title:@"开启事务插入10000条数据"];
    ItemView *itemView2 = [self getInsertItemViewWithFrame:frame2 useTransaction:NO useGCD:NO title:@"不开启事务插入10000条数据"];
    [self.view addSubview:itemView1];
    [self.view addSubview:itemView2];
    
    CGRect updateFrame1 = CGRectMake(0, 64 + 70 * 2, SCREEN_WIDTH, 70);
    CGRect updateFrame2 = CGRectMake(0, 64 + 70 * 3, SCREEN_WIDTH, 70);
    ItemView *updateView1 = [self getUpdateItemViewWithFrame:updateFrame1 useTransaction:YES useGCD:NO title:@"开启事务更新"];
    ItemView *updateView2 = [self getUpdateItemViewWithFrame:updateFrame2 useTransaction:NO useGCD:NO title:@"不开启事务更新"];
    [self.view addSubview:updateView1];
    [self.view addSubview:updateView2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 70 * 4, SCREEN_WIDTH / 2, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"当前操作数据：";
    self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 70 * 4 + 20, SCREEN_WIDTH, 20)];
    self.dataLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [self.view addSubview:self.dataLabel];
    
    CGRect insertUpdateFrame1 = CGRectMake(0, 64 + 70 * 4 + 20 *2, SCREEN_WIDTH, 70);
    CGRect insertUpdateFrame2 = CGRectMake(0, 64 + 70 * 5 + 20 *2, SCREEN_WIDTH, 70);
    ItemView *insertUpdateViwe1 = [self getInsertAndUpdateViewWithFrame:insertUpdateFrame1 useTransaction:YES useGCD:NO title:@"做线程管理总耗时(开启事务)"];
    ItemView *insertUpdateViwe2 = [self getInsertAndUpdateViewWithFrame:insertUpdateFrame2 useTransaction:YES useGCD:YES title:@"不做线程管理总耗时(开启事务)"];
    [self.view addSubview:insertUpdateViwe1];
    [self.view addSubview:insertUpdateViwe2];
}

- (void)updateTimeWithLabel:(NSTimer *)timer
{
    static CGFloat time = 0;
    static NSTimer *lastTimer = nil;
    if (lastTimer != timer)
    {
        time = 0;
        lastTimer = timer;
    }
    time += 0.01;
    UILabel *label = timer.userInfo;
    label.text = [NSString stringWithFormat:@"耗时：%.2fs", time];
}

- (ItemView *)getInsertItemViewWithFrame:(CGRect)frame useTransaction:(BOOL)useTransaction useGCD:(BOOL)userGCD title:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    ItemView *insertItemView = [[ItemView alloc] initWithFrame:frame];
    insertItemView.progressLabel.text = @"插入进度：0.00%";
    insertItemView.timeLabel.text = @"耗时：0s";
    [insertItemView.button setTitle:title forState:UIControlStateNormal];
    __weak typeof(insertItemView) weakItemView = insertItemView;
    [insertItemView setOnButton:^{
        [ZYJDB deleteStudents];
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:weakSelf selector:@selector(updateTimeWithLabel:) userInfo:weakItemView.timeLabel repeats:YES];
        [ZYJDB insertStudents:weakSelf.studentsArray progress:^(CGFloat progress, StudentModel *student) {
            weakItemView.progressLabel.text = [NSString stringWithFormat:@"插入进度：%.2f%%", progress];
            weakSelf.dataLabel.text = [NSString stringWithFormat:@"学生id：%ld, 学生姓名：%@", student.studentId, student.name];
            if (progress > 99.99)
            {
                [timer invalidate];
                timer = nil;
            }
        } useTransaction:useTransaction useGCD:userGCD];
    }];
    return insertItemView;
}

- (ItemView *)getUpdateItemViewWithFrame:(CGRect)frame useTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD title:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    ItemView *updateItemView = [[ItemView alloc] initWithFrame:frame];
    updateItemView.progressLabel.text = @"更新进度：0.00%";
    updateItemView.timeLabel.text = @"耗时：0s";
    [updateItemView.button setTitle:title forState:UIControlStateNormal];
    __weak typeof(updateItemView) weakItemView = updateItemView;
    [updateItemView setOnButton:^{
        NSArray <StudentModel *> *storedStudents = [ZYJDB getAllStudents];
        for (StudentModel *student in storedStudents)
        {
            student.studentId += 1;
        }
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:weakSelf selector:@selector(updateTimeWithLabel:) userInfo:weakItemView.timeLabel repeats:YES];
        [ZYJDB updateStudents:storedStudents progress:^(CGFloat progress, StudentModel *student) {
            weakItemView.progressLabel.text = [NSString stringWithFormat:@"更新进度：%.2f%%", progress];
            weakSelf.dataLabel.text = [NSString stringWithFormat:@"学生id：%ld, 学生姓名：%@", student.studentId, student.name];
            if (progress > 99.99)
            {
                [timer invalidate];
                timer = nil;
                [ZYJDB insertStudents:@[[storedStudents lastObject]] progress:^(CGFloat progress, StudentModel *student){
                    
                } useTransaction:useTransaction useGCD:useGCD];
            }
        } userTransaction:useTransaction useGCD:useGCD];
    }];
    return updateItemView;
}

- (ItemView *)getInsertAndUpdateViewWithFrame:(CGRect)frame useTransaction:(BOOL)useTransaction useGCD:(BOOL)useGCD title:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    ItemView *itemView = [[ItemView alloc] initWithFrame:frame];
    itemView.timeLabel.text = @"耗时：0s";
    [itemView.button setTitle:title forState:UIControlStateNormal];
    __weak typeof(itemView) weakItemView = itemView;
    [itemView setOnButton:^{
        [ZYJDB deleteStudents];
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:weakSelf selector:@selector(updateTimeWithLabel:) userInfo:weakItemView.timeLabel repeats:YES];
        [ZYJDB insertStudents:weakSelf.studentsArray progress:^(CGFloat progress, StudentModel *student) {
            weakItemView.progressLabel.text = [NSString stringWithFormat:@"插入进度：%.2f%%", progress];
            weakSelf.dataLabel.text = [NSString stringWithFormat:@"学生id：%ld, 学生姓名：%@", student.studentId, student.name];
            if (progress > 99.99)
            {
                NSArray <StudentModel *> *storedStudents = [ZYJDB getAllStudents];
                for (StudentModel *student in storedStudents)
                {
                    student.studentId += 1;
                }
                [ZYJDB updateStudents:storedStudents progress:^(CGFloat progress, StudentModel *student) {
                    weakItemView.progressLabel.text = [NSString stringWithFormat:@"更新进度：%.2f%%", progress];
                    weakSelf.dataLabel.text = [NSString stringWithFormat:@"学生id：%ld, 学生姓名：%@", student.studentId, student.name];
                    if (progress > 99.99)
                    {
                        [timer invalidate];
                        timer = nil;
                        [ZYJDB insertStudents:@[[storedStudents lastObject]] progress:^(CGFloat progress, StudentModel *student){
                            
                        } useTransaction:useTransaction useGCD:useGCD];
                    }
                } userTransaction:useTransaction useGCD:useGCD];
            }
        } useTransaction:useTransaction useGCD:useGCD];
    }];
    return itemView;
}

#pragma mark - get
- (NSMutableArray <StudentModel *> *)studentsArray
{
    if (!_studentsArray)
    {
        _studentsArray = [NSMutableArray array];
        NSInteger index = 0;
        for (; index < TotalCount; index++)
        {
            StudentModel *student = [StudentModel new];
            student.studentId = index + 1;
            student.name = [NSString stringWithFormat:@"学生姓名%ld", student.studentId];
            [_studentsArray addObject:student];
        }
    }
    return _studentsArray;
}

@end
