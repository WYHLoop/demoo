/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The presented view controller for the Swipe demo.
 */

#import "AAPLSwipeSecondViewController.h"
#import "AAPLSwipeTransitionDelegate.h"

@interface AAPLSwipeSecondViewController ()
@end


@implementation AAPLSwipeSecondViewController


- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@ init",NSStringFromClass(self.class));
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%@ initWithCoder",NSStringFromClass(self.class));
    }
    return self;
}

//| ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad",NSStringFromClass(self.class));

    // This gesture recognizer could be defined in the storyboard but is
    // instead created in code for clarity.
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
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
//
- (IBAction)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        // "BackToFirstViewController" is the identifier of the unwind segue
        // back to AAPLSwipeFirstViewController.  Triggering it will dismiss
        // this view controller.
        [self performSegueWithIdentifier:@"BackToFirstViewController" sender:sender];
    }
}


//| ----------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToFirstViewController"])
    {
        // Check if we were presented with our custom transition delegate.
        // If we were, update the configuration of the
        // AAPLSwipeTransitionDelegate with the gesture recognizer and
        // targetEdge for this view controller.
        if ([self.transitioningDelegate isKindOfClass:AAPLSwipeTransitionDelegate.class])
        {
            AAPLSwipeTransitionDelegate *transitionDelegate = self.transitioningDelegate;
            
            // If this will be an interactive presentation, pass the gesture
            // recognizer along to our AAPLSwipeTransitionDelegate instance
            // so it can return the necessary
            // <UIViewControllerInteractiveTransitioning> for the presentation.
            if ([sender isKindOfClass:UIGestureRecognizer.class])
                transitionDelegate.gestureRecognizer = sender;
            else
                transitionDelegate.gestureRecognizer = nil;
            
            // Set the edge of the screen to dismiss this view controller
            // from.  This will match the edge we configured the
            // UIScreenEdgePanGestureRecognizer with previously.
            //
            // NOTE: We can not retrieve the value of our gesture recognizer's
            //       configured edges because prior to iOS 8.3
            //       UIScreenEdgePanGestureRecognizer would always return
            //       UIRectEdgeNone when querying its edges property.
            transitionDelegate.targetEdge = UIRectEdgeLeft;
        }
    }
}

@end
