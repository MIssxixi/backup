//
//  ViewController.m
//  GestureRecognizerTest
//
//  Created by yongjie_zou on 2017/2/18.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *notRecognizeView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notRecognizeView = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    self.notRecognizeView.backgroundColor = [UIColor redColor];
    self.notRecognizeView.text = @"not recognize view";
    self.notRecognizeView.userInteractionEnabled = YES;
    [self.view addSubview:self.notRecognizeView];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.button.backgroundColor = [UIColor purpleColor];
    [self.button setTitle:@"button" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenPanAction:)];
    screenEdgePanGestureRecognizer.edges = UIRectEdgeRight;
//    screenEdgePanGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:screenEdgePanGestureRecognizer];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    NSLog(@"tap%@", NSStringFromCGPoint(location));
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    NSLog(@"pan");
}

- (void)screenPanAction:(UIScreenEdgePanGestureRecognizer *)sender {
    NSLog(@"screen pan");
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch view] == self.notRecognizeView){
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]
//        && [[otherGestureRecognizer view] isDescendantOfView:[gestureRecognizer view]]){
//        return YES;
//    }
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"touches began");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    NSLog(@"touches moved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    NSLog(@"touches ended");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    NSLog(@"touches cancelled");
}

@end
