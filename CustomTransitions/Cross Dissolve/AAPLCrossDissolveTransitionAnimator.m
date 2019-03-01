/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A transition animator that performs a cross dissolve transition between
  two view controllers.
 摘要：
 一个过渡动画师，在两个视图控制器之间执行交叉溶解过渡。
 

 */

#import "AAPLCrossDissolveTransitionAnimator.h"

@implementation AAPLCrossDissolveTransitionAnimator

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.

/*
 // This is used for percent driven interactive transitions, as well as for
 // container controllers that have companion animations that might need to
 // synchronize with the main animation.
 //这用于百分比驱动的交互式转换，以及具有可能需要与主动画同步的伴随动画的容器控制器。
 
 UIKit调用此方法来获取动画的计时信息。
 您提供的值应与在animateTransition：方法中配置动画时使用的值相同。
 UIKit使用该值来同步可能涉及转换的其他对象的操作。
 例如，导航控制器使用该值将更改同步到导航栏。
 确定要返回的值时，假设在转换期间没有用户交互 - 即使您计划在运行时支持用户交互。
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}


//| ----------------------------------------------------------------------------
/*
 UIKit在呈现或关闭视图控制器时调用此方法。
 使用此方法配置与自定义转换关联的动画。
 您可以使用基于视图的动画或核心动画来配置动画。
 所有动画都必须在transitionContext的containerView属性指定的视图中进行。
 将正在呈现的视图（或在转换涉及解除视图控制器时显示）添加到容器视图的层次结构中，并设置要使该视图移动到位的任何动画。
 如果要在没有视图的情况下直接绘制到屏幕，请使用此方法来配置CADisplayLink对象。
 您可以从transitionContext的viewControllerForKey：方法检索转换中涉及的视图控制器。
 有关上下文对象提供的信息的更多信息，请参阅UIViewControllerContextTransitioning。
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *fromView;
    UIView *toView;
    
    // In iOS 8, the viewForKey: method was introduced to get views that the
    // animator manipulates.  This method should be preferred over accessing
    // the view of the fromViewController/toViewController directly.
    // It may return nil whenever the animator should not touch the view
    // (based on the presentation style of the incoming view controller).
    // It may also return a different view for the animator to animate.
    //
    // Imagine that you are implementing a presentation similar to form sheet.
    // In this case you would want to add some shadow or decoration around the
    // presented view controller's view. The animator will animate the
    // decoration view instead and the presented view controller's view will
    // be a child of the decoration view.
    /*
     //在iOS 8中，引入了viewForKey：方法来获取动画师操作的视图。
     此方法应优先于直接访问fromViewController / toViewController的视图。
     每当动画师不应该触摸视图时（基于传入视图控制器的呈现样式），它可以返回nil。
     它还可以返回动画制作者的不同视图。 想象一下，您正在实施类似于表单的演示文稿。
    //在这种情况下，您可能希望在呈现的视图控制器视图周围添加一些阴影或装饰。
     动画师将为装饰视图设置动画，并且呈现的视图控制器的视图将是装饰视图的子视图。
     */
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    
    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    
    // We are responsible for adding the incoming view to the containerView
    // for the presentation/dismissal.
    
    /*
     //我们负责将传入视图添加到容器视图
     //为了呈现/解除。
     */
    [containerView addSubview:toView];
    
    //拿到transitionDuration过渡时间
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    //设置动画
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.alpha = 0.0f;
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        // When we complete, tell the transition context
        // passing along the BOOL that indicates whether the transition,
        // finished or not.
        
        /*
         //当我们完成时，告诉传递BOOL的转换上下文，它指示转换是否完成。
         */
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
