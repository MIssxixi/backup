//
//  TXKeyboardHelper.m
//  TXKeyboardHelper
//
//  Created by yuchenzheng on 16/9/1.
//  Copyright © 2016年 yuchenzheng. All rights reserved.
//

#import "TXKeyboardHelper.h"
#import "TXKeyboardHandlerModel.h"
#import "UIView+TXHierarchy.h"
#import "UIWindow+TXHierarchy.h"

@interface TXKeyboardHelper ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)NSHashTable<UIViewController *> *disableViewControllerArray;
@property (nonatomic, strong)NSMutableArray<TXKeyboardHandlerModel *> *keyboardHandlerModelArray;
@property (nonatomic, assign)BOOL keyboardShowing;
@property (nonatomic, assign)BOOL isTextViewContentInsetChanged;
@property (nonatomic, assign)BOOL preventShowingBottomBlankSpace;

@property (nonatomic, strong)UIView *textFieldView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@property (nonatomic, weak)UIScrollView *lastScrollView;

@property (nonatomic, assign)CGRect topViewBeginRect;
@property (nonatomic, assign)CGSize keyboardSize;
@property (nonatomic, assign)UIEdgeInsets startingContentInsets;
@property (nonatomic, assign)UIEdgeInsets startingScrollIndicatorInsets;
@property (nonatomic, assign)CGPoint startingContentOffset;
@property (nonatomic, assign)UIEdgeInsets startingTextViewContentInsets;
@property (nonatomic, assign)UIEdgeInsets startingTextViewScrollIndicatorInsets;

@property (nonatomic, assign)CGFloat animationDuration;
@property (nonatomic, assign)NSInteger animationCurve;

@end

@implementation TXKeyboardHelper

#pragma mark - lifecycle
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[TXKeyboardHelper sharedInstance] setEnable:YES];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [self setupProperties];
        [self setupNotifications];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TXKeyboardHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - public method
- (void)setEnable:(BOOL)enable forViewController:(UIViewController *)viewController {
    if(!viewController) {
        return;
    }
    if(enable) {
        [self.disableViewControllerArray removeObject:viewController];
        return;
    }
    if([self.disableViewControllerArray containsObject:viewController]) {
        return;
    }
    [self.disableViewControllerArray addObject:viewController];
}

- (void)addHandler:(void(^)(NSNotification *notification))handler 
     keyboardEvent:(TXKeyboardEvent)keyboardEvent 
 forViewController:(UIViewController *)viewController {
    if(!handler || !viewController) {
        return;
    }
    TXKeyboardHandlerModel *model = [[TXKeyboardHandlerModel alloc] init];
    model.handler = handler;
    model.keyboardEvent = keyboardEvent;
    model.target = viewController;
    [self.keyboardHandlerModelArray addObject:model];
}

- (void)removeHandlerWithKeyboardEvent:(TXKeyboardEvent)keyboardEvent 
                     forViewController:(UIViewController *)viewController {
    NSMutableArray *array = [NSMutableArray array];
    for(TXKeyboardHandlerModel *model in self.keyboardHandlerModelArray) {
        if(!model) {
            continue;
        }
        if(!model.target || !model.handler) {
            [array addObject:model];
        } else if(model.target == viewController) {
            if(keyboardEvent == TXKeyboardEventNone) {
                [array addObject:model];
            } else if (keyboardEvent == model.keyboardEvent) {
                [array addObject:model];
            }
        }
    }
    [self.keyboardHandlerModelArray removeObjectsInArray:array];
}

- (void)removeHandlerForViewController:(UIViewController *)viewController {
    [self removeHandlerWithKeyboardEvent:TXKeyboardEventNone forViewController:viewController];
}

#pragma mark - setup
- (void)setupProperties {
    self.enable = YES;
    self.keyboardDistanceFromTextField = 10/[UIScreen mainScreen].scale;
    self.shouldResignOnTouchOutside = YES;
    self.preventShowingBottomBlankSpace = YES;
}

- (void)setupNotifications {
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // textfield
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    // textview
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

#pragma mark - event response
- (void)tapRecognized:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self resignFirstResponder];
    }
}

#pragma mark - keyboard notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    self.keyboardShowing = YES;
    [self notifyKeyboardWillShow:notification];
    if(![self currentViewControllerEnable]) {
        return;
    }
    if(self.textFieldView && CGRectEqualToRect(self.topViewBeginRect, CGRectZero)) {
        // 如果输入框开始编辑之后还未保存topViewBeginRect，则先保存rootViewController的view的frame
        [self saveRootViewControllerFrame];
    }
    
    // 获取键盘的动画
    self.animationCurve = [[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue];
    self.animationCurve = self.animationCurve<<16;
    
    // 获取键盘动画时间，当切换键盘时拿到的时间值为0，需要加此判断来获取动画时间值
    self.animationDuration = MAX(self.animationDuration, [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue]);
    
    // 获取位置、尺寸等信息
    CGRect endKeyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    // 获取键盘的位置、大小，不直接使用endKeyboardFrame是因为可能有外接键盘，直接使用endKeyboardFrame可能造成计算不准确
    CGRect intersectRect = CGRectIntersection(endKeyboardFrame, screenSize);
    if(CGRectIsNull(intersectRect)) {
        self.keyboardSize = CGSizeMake(screenSize.size.width, 0);
    } else {
        self.keyboardSize = intersectRect.size;
    }
    if([self shouldTextFieldAdjustFrame]) {
        [self adjustFrame];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification {
    if(![self currentViewControllerEnable]) {
        return;
    }
    UIViewController *rootViewController = [self rootViewController];
    if([self shouldTextFieldAdjustFrame] && 
       (rootViewController.modalPresentationStyle == UIModalPresentationFormSheet || 
        rootViewController.modalPresentationStyle == UIModalPresentationPageSheet)) {
           // 如果textFieldView的viewController是作为formSheet来展示的，则需要再次调用adjustFrame方法
           // 因为系统内部在键盘展示时会修改formSheet的frame
           [self adjustFrame];
       }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.keyboardShowing = NO;
    [self notifyKeyboardWillHide:notification];
    if(![self currentViewControllerEnable]) {
        return;
    }
    self.animationDuration = MAX(self.animationDuration, [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue]);
    if(self.lastScrollView) {
        [UIView animateWithDuration:self.animationDuration delay:0 options:self.animationCurve|UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.lastScrollView.contentInset = self.startingContentInsets;
            self.lastScrollView.scrollIndicatorInsets = self.startingScrollIndicatorInsets;
            UIScrollView *superscrollView = self.lastScrollView;
            do {
                CGSize contentSize = CGSizeMake(MAX(superscrollView.contentSize.width, CGRectGetWidth(superscrollView.frame)), MAX(superscrollView.contentSize.height, CGRectGetHeight(superscrollView.frame)));
                CGFloat minimumY = contentSize.height-CGRectGetHeight(superscrollView.frame);
                if (minimumY<superscrollView.contentOffset.y) {
                    superscrollView.contentOffset = CGPointMake(superscrollView.contentOffset.x, minimumY);
                }
            } while ((superscrollView = (UIScrollView*)[superscrollView superviewOfClassType:[UIScrollView class]]));
        } completion:nil];
    }
    if(!CGRectEqualToRect(self.topViewBeginRect, CGRectZero) && [self rootViewController]) {
        _topViewBeginRect.size = [self rootViewController].view.frame.size;
        [UIView animateWithDuration:self.animationDuration delay:0 options:self.animationCurve|UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[self rootViewController].view setFrame:self.topViewBeginRect];
        } completion:nil];
    }
    self.lastScrollView = nil;
    self.keyboardSize = CGSizeZero;
    self.startingContentInsets = UIEdgeInsetsZero;
    self.startingScrollIndicatorInsets = UIEdgeInsetsZero;
    self.startingContentOffset = CGPointZero;
}

- (void)keyboardDidHide:(NSNotification *)notification {
    self.topViewBeginRect = CGRectZero;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    [self notifyKeyboardWillChangeFrame:notification];
}

#pragma mark - textfieldview notifications
- (void)textFieldViewBeginEditing:(NSNotification *)notification {
    self.textFieldView = notification.object;
    if(![self currentViewControllerEnable]) {
        return;
    }
    [self.textFieldView.window addGestureRecognizer:self.tapGesture];
    if(CGRectEqualToRect(self.topViewBeginRect, CGRectZero)) {
        [self saveRootViewControllerFrame];
    }
    if([self shouldTextFieldAdjustFrame]) {
        // 如果键盘已经展示，此时需要调用adjustFrame
        [self adjustFrame];
    }
}

- (void)textFieldViewEndEditing:(NSNotification *)notification {
    [self.textFieldView.window removeGestureRecognizer:self.tapGesture];
    if(self.isTextViewContentInsetChanged == YES &&
       [self.textFieldView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView*)self.textFieldView;
        [UIView animateWithDuration:self.animationDuration delay:0 options:self.animationCurve|UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.isTextViewContentInsetChanged = NO;
            textView.contentInset = self.startingTextViewContentInsets;
            textView.scrollIndicatorInsets = self.startingTextViewScrollIndicatorInsets;
        } completion:nil];
    }
    self.textFieldView = nil;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return !([[touch view] isKindOfClass:[UIControl class]] || [[touch view] isKindOfClass:[UINavigationBar class]]);
}

#pragma mark - private method
- (BOOL)resignFirstResponder {
    if (self.textFieldView) {
        BOOL isResignFirstResponder = [self.textFieldView resignFirstResponder];
        if (!isResignFirstResponder) {
            [self.textFieldView becomeFirstResponder];
        }
        return isResignFirstResponder;
    }
    return NO;
}

- (UIWindow *)keyWindow {
    if(self.textFieldView.window) {
        return self.textFieldView.window;
    }
    return [[UIApplication sharedApplication] keyWindow];
}

- (UIViewController *)rootViewController {
    UIViewController *rootViewController = [self.textFieldView topMostController];
    if(!rootViewController) {
        rootViewController = [[self keyWindow] topMostController];
    }
    return rootViewController;
}

- (void)saveRootViewControllerFrame {
    UIViewController *rootViewController = [self rootViewController];
    self.topViewBeginRect = rootViewController.view.frame;
}

- (BOOL)shouldTextFieldAdjustFrame {
    return self.textFieldView && self.keyboardShowing && !self.textFieldView.isAlertViewTextField;
}

- (void)setRootViewFrame:(CGRect)frame {
    UIViewController *controller = [self rootViewController];
    frame.size = controller.view.frame.size;
    [UIView animateWithDuration:self.animationDuration delay:0 options:(self.animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [controller.view setFrame:frame];
    } completion:nil];
}

- (void)adjustFrame {
    if(!self.textFieldView) {
        return;
    }
    UIWindow *keyWindow = [self keyWindow];
    UIViewController *rootController = [self rootViewController];
    CGRect textFieldViewRect = [[self.textFieldView superview] convertRect:self.textFieldView.frame toView:keyWindow];
    CGRect rootViewRect = [[rootController view] frame];
    CGFloat keyboardDistanceFromTextField = self.keyboardDistanceFromTextField;
    CGSize keyboardSize = self.keyboardSize;
    keyboardSize.height += keyboardDistanceFromTextField;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat topLayoutGuide = CGRectGetHeight(statusBarFrame);
    CGFloat move = MIN(CGRectGetMinY(textFieldViewRect) - (topLayoutGuide + 5), CGRectGetMaxY(textFieldViewRect) - (CGRectGetHeight(keyWindow.frame) - keyboardSize.height));
    UIScrollView *superScrollView = nil;
    UIScrollView *superView = (UIScrollView*)[self.textFieldView superviewOfClassType:[UIScrollView class]];
    
    // 在textFieldView的视图栈上找到是UIScrollView且可以滚动的父视图
    while (superView) {
        if(superView.isScrollEnabled) {
            superScrollView = superView;
            break;
        }
        superView = (UIScrollView*)[superView superviewOfClassType:[UIScrollView class]];
    }
    
    // 第一步 如果上一次处理过scrollView，则现在需要重置上一次处理的scrollView的状态，防止产生干扰
    // 如果之前对上一个UIScrollView做过处理，则首先需要重置上一个UIScrollView的状态
    if(self.lastScrollView) {
        if(!superView) {
            // 如果superView为空，说明当前操作的视图栈中没有可滚动的ScrollView，则需要重置上一个ScrollView的状态
            [UIView animateWithDuration:self.animationDuration delay:0 options:(self.animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                self.lastScrollView.contentInset = self.startingContentInsets;
                self.lastScrollView.scrollIndicatorInsets = self.startingScrollIndicatorInsets;
            } completion:nil];
            self.startingContentInsets = UIEdgeInsetsZero;
            self.startingScrollIndicatorInsets = UIEdgeInsetsZero;
            self.startingContentOffset = CGPointZero;
            self.lastScrollView = nil;
        } else if (superView != self.lastScrollView) {
            // 如果superView和上一个ScrollView不同，则需要重置上一个ScrollView的状态，然后记录当前这个superView的状态，后面会对这个superView做处理
            [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                self.lastScrollView.contentInset = self.startingContentInsets;
                self.lastScrollView.scrollIndicatorInsets = self.startingScrollIndicatorInsets;
            } completion:nil];
            self.lastScrollView = superScrollView;
            self.startingContentInsets = superScrollView.contentInset;
            self.startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
            self.startingContentOffset = superScrollView.contentOffset;
        }
    } else if (superScrollView) {
        // 如果当前的superView和ScrollView是同一个视图，则直接赋值，记录当前的状态即可，不需要重置状态，后面会对superView做处理
        self.lastScrollView = superScrollView;
        self.startingContentInsets = superScrollView.contentInset;
        self.startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
        self.startingContentOffset = superScrollView.contentOffset;
    }
    
    // 第二步  如果当前的textfieldView的视图栈中有可滚动的ScrollView，则对这个ScrollView进行处理，处理内容主要是
    // 修改contentInsets,contentOffset,ScrollIndicatorInsets
    if(self.lastScrollView) {
        UIView *lastView = self.textFieldView;
        UIScrollView *superScrollView = self.lastScrollView;
        // 计算ScrollView需要滚动的距离，滚动这些距离才能让textFieldView不被遮挡
        while (superScrollView && (move > 0 
                                   ? (move > (-superScrollView.contentOffset.y-superScrollView.contentInset.top)) 
                                   : superScrollView.contentOffset.y>0)) {
            CGRect lastViewRect = [[lastView superview] convertRect:lastView.frame toView:superScrollView];
            CGFloat shouldOffsetY = superScrollView.contentOffset.y - MIN(superScrollView.contentOffset.y,-move);
            // 此处做判断，防止滚动过多导致视图的顶部超出页面可见范围
            shouldOffsetY = MIN(shouldOffsetY, lastViewRect.origin.y);
            if ([_textFieldView isKindOfClass:[UITextView class]] 
                && [superScrollView superviewOfClassType:[UIScrollView class]] == nil 
                && (shouldOffsetY >= 0)) {
                CGFloat maintainTopLayout = 0;
                maintainTopLayout = CGRectGetMaxY(_textFieldView.viewController.navigationController.navigationBar.frame);
                maintainTopLayout+= 10;
                CGRect currentTextFieldViewRect = [[self.textFieldView superview] convertRect:self.textFieldView.frame toView:keyWindow];
                CGFloat expectedFixDistance = CGRectGetMinY(currentTextFieldViewRect) - maintainTopLayout;
                shouldOffsetY = MIN(shouldOffsetY, superScrollView.contentOffset.y + expectedFixDistance);
                move = 0;
            } else {
                move -= (shouldOffsetY-superScrollView.contentOffset.y);
            }
            [UIView animateWithDuration:self.animationDuration delay:0 options:(self.animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                superScrollView.contentOffset = CGPointMake(superScrollView.contentOffset.x, shouldOffsetY);
            } completion:nil];
            lastView = superScrollView;
            superScrollView = (UIScrollView*)[lastView superviewOfClassType:[UIScrollView class]];
        }
        
        CGRect lastScrollViewRect = [[self.lastScrollView superview] convertRect:self.lastScrollView.frame toView:keyWindow];
        CGFloat bottom = keyboardSize.height - keyboardDistanceFromTextField - (CGRectGetHeight(keyWindow.frame) - CGRectGetMaxY(lastScrollViewRect));
        UIEdgeInsets movedInsets = self.lastScrollView.contentInset;
        movedInsets.bottom = MAX(self.startingContentInsets.bottom, bottom);
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            self.lastScrollView.contentInset = movedInsets;
            UIEdgeInsets newInset = self.lastScrollView.scrollIndicatorInsets;
            newInset.bottom = movedInsets.bottom;
            self.lastScrollView.scrollIndicatorInsets = newInset;
        } completion:nil];
    }
    
    // 特殊处理，如果textFieldView是UITextView，则需要设置textFieldView的contentInsets等内容
    if ([self.textFieldView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView*)self.textFieldView;
        CGFloat textViewHeight = MIN(CGRectGetHeight(self.textFieldView.frame), (CGRectGetHeight(keyWindow.frame) - keyboardSize.height - (topLayoutGuide)));
        if (self.textFieldView.frame.size.height - textView.contentInset.bottom > textViewHeight) {
            [UIView animateWithDuration:self.animationDuration delay:0 options:(self.animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                if (!self.isTextViewContentInsetChanged){
                    self.startingTextViewContentInsets = textView.contentInset;
                    self.startingTextViewScrollIndicatorInsets = textView.scrollIndicatorInsets;
                }
                UIEdgeInsets newContentInset = textView.contentInset;
                newContentInset.bottom = self.textFieldView.frame.size.height - textViewHeight;
                textView.contentInset = newContentInset;
                textView.scrollIndicatorInsets = newContentInset;
                self.isTextViewContentInsetChanged = YES;
            } completion:NULL];
        }
    }
    
    if ([rootController modalPresentationStyle] == UIModalPresentationFormSheet ||
        [rootController modalPresentationStyle] == UIModalPresentationPageSheet) {
        if (move>=0) {
            rootViewRect.origin.y -= move;
            if (self.preventShowingBottomBlankSpace) {
                CGFloat minimumY = (CGRectGetHeight(keyWindow.frame) - rootViewRect.size.height - topLayoutGuide)/2 - (keyboardSize.height - keyboardDistanceFromTextField);
                rootViewRect.origin.y = MAX(rootViewRect.origin.y, minimumY);
            }
            [self setRootViewFrame:rootViewRect];
        } else {
            CGFloat disturbDistance = CGRectGetMinY(rootViewRect) - CGRectGetMinY(self.topViewBeginRect);
            if(disturbDistance<0) {
                rootViewRect.origin.y -= MAX(move, disturbDistance);
                [self setRootViewFrame:rootViewRect];
            }
        }
    } else {
        if (move >= 0) {
            rootViewRect.origin.y -= move;
            if (self.preventShowingBottomBlankSpace) {
                rootViewRect.origin.y = MAX(rootViewRect.origin.y, MIN(0, -keyboardSize.height+keyboardDistanceFromTextField));
            }
            [self setRootViewFrame:rootViewRect];
        } else {
            CGFloat disturbDistance = CGRectGetMinY(rootViewRect)-CGRectGetMinY(self.topViewBeginRect);
            if(disturbDistance < 0) {
                rootViewRect.origin.y -= MAX(move, disturbDistance);
                [self setRootViewFrame:rootViewRect];
            }
        }
    }
}

- (BOOL)currentViewControllerEnable {
    if(!self.enable) {
        return NO;
    }
    UIViewController *viewController = [self.textFieldView viewController];
    if(!viewController) {
        // 如果viewController为空，说明当前的textFieldView可能未被赋值，先返回YES让其布局
        return YES;
    }
    if([self.disableViewControllerArray containsObject:viewController]) {
        return NO;
    }
    return YES;
}

#pragma mark - notify method
- (void)notifyKeyboardWillShow:(NSNotification *)notification {
    [self notifyKeyboardHandlerWithNotification:notification event:TXKeyboardEventWillShow];
}

- (void)notifyKeyboardWillHide:(NSNotification *)notification {
    [self notifyKeyboardHandlerWithNotification:notification event:TXKeyboardEventWillDismiss];
}

- (void)notifyKeyboardWillChangeFrame:(NSNotification *)notification {
    [self notifyKeyboardHandlerWithNotification:notification event:TXKeyboardEventChangeFrame];
}

- (void)notifyKeyboardHandlerWithNotification:(NSNotification *)notification event:(TXKeyboardEvent)keyboardEvent {
    UIViewController *viewController = [self.textFieldView viewController];
    for(TXKeyboardHandlerModel *model in self.keyboardHandlerModelArray) {
        if(model.target == viewController && model.keyboardEvent == keyboardEvent && model.handler) {
            model.handler(notification);
            return;
        }
    }
}

#pragma mark - getter
- (NSHashTable <UIViewController *> *)disableViewControllerArray {
    if(!_disableViewControllerArray) {
        _disableViewControllerArray = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _disableViewControllerArray;
}

- (NSMutableArray <TXKeyboardHandlerModel *> *)keyboardHandlerModelArray {
    if(!_keyboardHandlerModelArray) {
        _keyboardHandlerModelArray = [[NSMutableArray alloc] init];
    }
    return _keyboardHandlerModelArray;
}

- (UITapGestureRecognizer *)tapGesture {
    if(!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
        _tapGesture.cancelsTouchesInView = NO;
        _tapGesture.delegate = self;
        _tapGesture.enabled = self.shouldResignOnTouchOutside;
    }
    return _tapGesture;
}

#pragma mark - setter
- (void)setShouldResignOnTouchOutside:(BOOL)shouldResignOnTouchOutside {
    _shouldResignOnTouchOutside = shouldResignOnTouchOutside;
    self.tapGesture.enabled = shouldResignOnTouchOutside;
}

@end
