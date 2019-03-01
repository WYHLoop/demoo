/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The initial view controller for the Custom Presentation demo.
 */

#import "AAPLCustomPresentationFirstViewController.h"
#import "AAPLCustomPresentationController.h"

@implementation AAPLCustomPresentationFirstViewController

#pragma mark -
#pragma mark Presentation

//| ----------------------------------------------------------------------------
- (IBAction)buttonAction:(UIButton*)sender
{
    
    //获取到storyboadrd 里面的页面 SsecondView
    UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    // For presentations which will use a custom presentation controller,
    // it is possible for that presentation controller to also be the
    // transitioningDelegate.  This avoids introducing another object
    // or implementing <UIViewControllerTransitioningDelegate> in the
    // source view controller.
    //
    // transitioningDelegate does not hold a strong reference to its
    // destination object.  To prevent presentationController from being
    // released prior to calling -presentViewController:animated:completion:
    // the NS_VALID_UNTIL_END_OF_SCOPE attribute is appended to the declaration.
    //
    //局部变量防止优化时,被牵制释放掉
    AAPLCustomPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
   
    //此方法是表示控制器的指定初始化器。必须从为表示控制器子类定义的任何自定义初始化方法中调用它。
//    presentedViewController
//    以模态方式呈现视图控制器。 准备要展示出来的控制器
//    presentingViewController
//    其内容表示转换起点的视图控制器。 准备要进行的转换动画的控制器
    presentationController = [[AAPLCustomPresentationController alloc] initWithPresentedViewController:secondViewController presentingViewController:self];
    
    //提供转换动画器、交互控制器和自定义表示控制器对象的委托对象。
    secondViewController.transitioningDelegate = presentationController;
    
    [self presentViewController:secondViewController animated:YES completion:NULL];
}

@end
