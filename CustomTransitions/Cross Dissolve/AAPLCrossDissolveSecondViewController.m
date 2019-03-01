/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The presented view controller for the Cross Dissolve demo.
 */

#import "AAPLCrossDissolveSecondViewController.h"

@implementation AAPLCrossDissolveSecondViewController

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
- (IBAction)dismissAction:(id)sender
{
    // For the sake of example, this demo implements the presentation and
    // dismissal logic completely in code.  Take a look at the later demos
    // to learn how to integrate custom transitions with segues.
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
