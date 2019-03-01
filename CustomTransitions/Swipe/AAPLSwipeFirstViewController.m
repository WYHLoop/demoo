/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The initial view controller for the Swipe demo.
 */

#import "AAPLSwipeFirstViewController.h"
#import "AAPLSwipeTransitionDelegate.h"

@interface AAPLSwipeFirstViewController ()
@property (nonatomic, strong) AAPLSwipeTransitionDelegate *customTransitionDelegate;
@end


@implementation AAPLSwipeFirstViewController

//| ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad",NSStringFromClass(self.class));

    
    // This gesture recognizer could be defined in the storyboard but is
    // instead created in code for clarity.
    // 这个手势识别器可以在故事板中定义，但是可以在代码中清晰地创建。
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
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
//! Action method for the interactiveTransitionRecognizer.
//  交互式转换识别器的动作方法。
//
// 手势
- (IBAction)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
        [self performSegueWithIdentifier:@"CustomTransition" sender:sender];
    
    // Remaining cases are handled by the
    // AAPLSwipeTransitionInteractionController.
}


//| ----------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CustomTransition"])
    {
        UIViewController *destinationViewController = segue.destinationViewController;
        
        // Unlike in the Cross Dissolve demo, we use a separate object as the
        // transition delegate rather then (our)self.  This promotes
        // 'separation of concerns' as AAPLSwipeTransitionDelegate will
        // handle pairing the correct animation controller and interaction
        // controller for the presentation.
        
        /*
         与交叉溶解演示不同，我们使用一个单独的对象作为转换委托，而不是(我们的)自我。
         这促进了“关注点分离”，因为AAPLSwipeTransitionDelegate将为表示处理匹配正确的动画控制器和交互控制器。
        */
        
        AAPLSwipeTransitionDelegate *transitionDelegate = self.customTransitionDelegate;
        
        // If this will be an interactive presentation, pass the gesture
        // recognizer along to our AAPLSwipeTransitionDelegate instance
        // so it can return the necessary
        // <UIViewControllerInteractiveTransitioning> for the presentation.
        
        /*
         如果这是一个交互式的表示，将手势识别器传递给我们的AAPLSwipeTransitionDelegate实例，这样它就可以为表示返回必需的< uiviewcontrollerinteractivetransiating >。
         */
        if ([sender isKindOfClass:UIGestureRecognizer.class])
            transitionDelegate.gestureRecognizer = sender;
        else
            transitionDelegate.gestureRecognizer = nil;
        
        // Set the edge of the screen to present the incoming view controller
        // from.  This will match the edge we configured the
        // UIScreenEdgePanGestureRecognizer with previously.
        //
        // NOTE: We can not retrieve the value of our gesture recognizer's
        //       configured edges because prior to iOS 8.3
        //       UIScreenEdgePanGestureRecognizer would always return
        //       UIRectEdgeNone when querying its edges property.
        
        /*
         设置屏幕的边缘以显示传入的视图控制器。
         这将与我们之前配置UIScreenEdgePanGestureRecognizer的边匹配。
         
         注意:我们无法检索手势识别器配置边的值，因为在iOS 8.3之前，uiscreenedgepangenedesturerecognizer在查询其边属性时总是返回UIRectEdgeNone。
         */
        transitionDelegate.targetEdge = UIRectEdgeRight;
        
        // Note that the view controller does not hold a strong reference to
        // its transitioningDelegate.  If you instantiate a separate object
        // to be the transitioningDelegate, ensure that you hold a strong
        // reference to that object.
        
        /*
         请注意，视图控制器没有对其transitioningDelegate的强引用。
         如果将实例化单独的对象作为transitioningDelegate，请确保持有对该对象的强引用。
         */
        
        destinationViewController.transitioningDelegate = transitionDelegate;
        
        // Setting the modalPresentationStyle to FullScreen enables the
        // <ContextTransitioning> to provide more accurate initial and final
        // frames of the participating view controllers.
        
        /*
         将modalPresentationStyle设置为全屏，使< contexttransiations >能够提供参与视图控制器的更精确的初始帧和最终帧。
         */
        destinationViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
}


//| ----------------------------------------------------------------------------
//  Custom implementation of the getter for the customTransitionDelegate
//  property.  Lazily creates an instance of AAPLSwipeTransitionDelegate.
//
- (AAPLSwipeTransitionDelegate *)customTransitionDelegate
{
    if (_customTransitionDelegate == nil)
        _customTransitionDelegate = [[AAPLSwipeTransitionDelegate alloc] init];
    
    return _customTransitionDelegate;
}

#pragma mark -
#pragma mark Unwind Actions

//| ----------------------------------------------------------------------------
//! Action for unwinding from AAPLSwipeSecondViewController.
//
- (IBAction)unwindToSwipeFirstViewController:(UIStoryboardSegue *)sender
{ }

@end
