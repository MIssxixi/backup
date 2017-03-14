//
//  ScrollViewDemoViewController.m
//  Demo
//
//  Created by Mac_ZL on 16/8/1.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import "ScrollViewDemoViewController.h"

@interface ScrollViewDemoViewController ()<UIScrollViewDelegate>

@end

@implementation ScrollViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    //是否自动调整ScrollView的contentInset
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300)];
    [scrollView setDelegate:self];
    [scrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:scrollView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_tesla.jpg"]];
    [scrollView addSubview:imgView];

    //设置显示内容的大小
    //注意：contentSize的范围是以scrollView的位置为基准的。所以，如果内容视图的frame.origin不是(0,0)，则需要仔细计算，内容视图能被显示的范围
    [scrollView setContentSize:imgView.bounds.size];
    
    //contentInset
    //表示scrollView的内边距，也就是内容视图边缘和scrollView的边缘的留空距离，默认值是UIEdgeInsetsZero，也就是没间距。
    [scrollView setContentInset:UIEdgeInsetsMake(20, 50, 20, 50)];
    //contentOffset
    //描述了内容视图相对于scrollView窗口的位置(向上向左的偏移量)。默认值是CGPointZero，也就是(0,0)。当视图被拖动时，系统会不断修改该值。也可以通过setContentOffset:animated:方法让图片到达某个指定的位置。
    //是否有回弹效果
    [scrollView setBounces:YES];
    //垂直方向的回弹效果
    [scrollView setAlwaysBounceVertical:NO];
    //水平方向的回弹效果
    [scrollView setAlwaysBounceHorizontal:YES];
    //开启分页模式
    [scrollView setPagingEnabled:YES];
    //是否支持双击状态栏，回到顶部
    //注意：如果一个ViewController有多个scrollview，且都设置该属性yes,系统不知道该是哪个scrollview回到顶部，导致双击状态栏无响应
    //解决方案:设置当前可视的scrollview的属性为yes,其他的都设置为no
    [scrollView setScrollsToTop:YES];
    //指示条的样式
    //[scrollView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"content offset is %@",NSStringFromCGPoint(scrollView.contentOffset));
}
// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    NSLog(@"即将开始拖拽");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
{
    NSLog(@"即将结束拖拽");
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"结束拖拽");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"开始减速");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"结束减速");
}

@end
