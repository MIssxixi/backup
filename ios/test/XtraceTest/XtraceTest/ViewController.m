//
//  ViewController.m
//  XtraceTest
//
//  Created by yongjie_zou on 16/7/18.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import "TestInitView.h"
#import "Xtrace.h"
#import "NSObject+Category.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *string1;
@property (nonatomic, unsafe_unretained) NSString *string2;
//@property (nonatomic, )

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [Xtrace includeMethods:@"^init"];
    [Xtrace useColor:XTRACE_RED forSelector:@selector(init)];
//    [Xtrace traceClass:[TestInitView class]];
    TestInitView *testInitView = [[TestInitView alloc] initWithName];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 400, 400)];
    label.text = @"asdfasa";
    [self.view addSubview:label];
    
//    [Xtrace traceClass:[NSArray class]];
    NSArray *array = [[NSArray alloc] initWithObjects:@"a", nil];
//    NSLog(@"%p", &array);
//    NSLog(@"%@", [array componentsJoinedByString:@"a"]);
    NSArray *arrayb= @[@1, @"a", @3];
    NSLog(@"%lu,%lu", sizeof(&array), sizeof(&arrayb));
    NSLog(@"%d",[array isEqualToArray:@[@"a"]]);
//    NSLog(@"%p", &arrayb);
//    NSLog(@"%@", [arrayb componentsJoinedByString:@"a"]);
//    NSLog(@"%@", [arrayb firstObjectCommonWithArray:array]);
//    NSLog(@"%@", [arrayb descriptionWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@""]]);
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    
    __unsafe_unretained NSString *a;
    a = nil;
    self.string1 = [NSString stringWithFormat:@"%@", @"string1"];
    self.string1 = [self.string1 stringByAppendingString:@"a"];
    self.string1 = @"str";
    NSLog(@"%p", self.string1);
    self.string1 = [self.string1 stringByAppendingString:@"ing1"];
    NSLog(@"%p", self.string1);
    self.string2 = self.string1;
    NSLog(@"%p", self.string2);
    self.string1 = nil;
    NSLog(@"%@", self.string2);
    
    NSString *str = [[NSString alloc] init];
    str.categoryString = @"fasdfj";
    NSLog(@"%@", str.categoryString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)injected{
    [self viewDidLoad];
}

@end
