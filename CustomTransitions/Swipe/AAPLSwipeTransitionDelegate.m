/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The transition delegate for the Swipe demo.  Vends instances of 
  AAPLSwipeTransitionAnimator and optionally 
  AAPLSwipeTransitionInteractionController.
 */

#import "AAPLSwipeTransitionDelegate.h"
#import "AAPLSwipeTransitionAnimator.h"
#import "AAPLSwipeTransitionInteractionController.h"

@implementation AAPLSwipeTransitionDelegate

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//

/*
    系统在呈现的视图控制器的transitioningDelegate上调用此方法，以检索用于动画显示传入视图控制器的动画对象。
    您的实现应返回符合UIViewControllerAnimatedTransitioning协议的对象，如果应使用默认的演示动画，则返回nil。
 */

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[AAPLSwipeTransitionAnimator alloc] initWithTargetEdge:self.targetEdge];
}


//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[AAPLSwipeTransitionAnimator alloc] initWithTargetEdge:self.targetEdge];
}


//| ----------------------------------------------------------------------------
//  If a <UIViewControllerAnimatedTransitioning> was returned from
//  -animationControllerForPresentedController:presentingController:sourceController:,
//  the system calls this method to retrieve the interaction controller for the
//  presentation transition.  Your implementation is expected to return an
//  object that conforms to the UIViewControllerInteractiveTransitioning
//  protocol, or nil if the transition should not be interactive.
//

/*
 如果从中返回<UIViewControllerAnimatedTransitioning>
 -animationControllerForPresentedController：presentingController：sourceController :,
 系统调用此方法来检索演示文稿转换的交互控制器。
 您的实现应返回符合UIViewControllerInteractiveTransitioning协议的对象，如果转换不应该是交互式，则返回nil。
 */

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    // You must not return an interaction controller from this method unless
    // the transition will be interactive.
    if (self.gestureRecognizer)
        return [[AAPLSwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}


//| ----------------------------------------------------------------------------
//  If a <UIViewControllerAnimatedTransitioning> was returned from
//  -animationControllerForDismissedController:,
//  the system calls this method to retrieve the interaction controller for the
//  dismissal transition.  Your implementation is expected to return an
//  object that conforms to the UIViewControllerInteractiveTransitioning
//  protocol, or nil if the transition should not be interactive.
//
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    // You must not return an interaction controller from this method unless
    // the transition will be interactive.
    if (self.gestureRecognizer)
        return [[AAPLSwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}

@end
