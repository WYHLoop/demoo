/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The initial view controller for the Cross Dissolve demo.
 摘要:
 交叉溶解演示的初始视图控制器。
 */

#import "AAPLCrossDissolveFirstViewController.h"
#import "AAPLCrossDissolveTransitionAnimator.h"

@interface AAPLCrossDissolveFirstViewController() <UIViewControllerTransitioningDelegate>
@end


@implementation AAPLCrossDissolveFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad",NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear",NSStringFromClass(self.class));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear",NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear",NSStringFromClass(self.class));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear",NSStringFromClass(self.class));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%@ viewDidLayoutSubviews",NSStringFromClass(self.class));
}





//| ----------------------------------------------------------------------------

/**
 按钮点击方法
 获取storyboard的 第二个视图
 1.设置跳转类型 modalPresentationStyle 模式展示风格
 2.设置过渡代理 vtransitioningDelegate
 3.模态跳转

 @param sender <#sender description#>
 */
- (IBAction)presentWithCustomTransitionAction:(id)sender
{
    // For the sake of example, this demo implements the presentation and
    // dismissal logic completely in code.  Take a look at the later demos
    // to learn how to integrate custom transitions with segues.
    UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    // Setting the modalPresentationStyle to FullScreen enables the
    // <ContextTransitioning> to provide more accurate initial and final frames
    // of the participating view controllers
    // 将modalPresentationStyle设置为FullScreen使<ContextTransitioning>能够提供更准确的参与视图控制器的初始和最终帧
    /*
        定义在以模态方式呈现时将用于此视图控制器的过渡样式。
        在要显示的视图控制器上设置此属性，而不是演示者。
        默认为UIModalTransitionStyleCoverVertical。
     */
    secondViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // The transitioning delegate can supply a custom animation controller
    // that will be used to animate the incoming view controller.
    secondViewController.transitioningDelegate = self;
    
    [self presentViewController:secondViewController animated:YES completion:NULL];
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//

/**
 1. 系统在呈现的视图控制器的transitioningDelegate上调用此方法，以检索用于动画显示传入视图控制器的动画对象。
 2. 你的实现应该是返回一个符合UIViewControllerAnimatedTransitioning协议的对象,如果应使用默认的演示动画，则为nil。
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //苹果交叉溶解过渡动画
    return [AAPLCrossDissolveTransitionAnimator new];
    
}

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//

/**
 1. 系统在呈现的视图控制器的transitioningDelegate上调用此方法，以检索用于动画解除所呈现的视图控制器动画的动画对象。(解除..)
 2. 您的实现应返回符合UIViewControllerAnimatedTransitioning协议的对象，如果应使用默认解除动画，则返回nil。
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //苹果交叉溶解过渡动画
    return [AAPLCrossDissolveTransitionAnimator new];
}

@end
