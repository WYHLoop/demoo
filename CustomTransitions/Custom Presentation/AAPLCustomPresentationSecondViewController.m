/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The second view controller for the Custom Presentation demo.
 */

#import "AAPLCustomPresentationSecondViewController.h"

//  NOTE: The third view controller is presented with a modalPresentationStyle
//        of UIModalPresentationOverFullScreen, rather than the default
//        UIModalPresentationFullScreen (configured in the storyboard).
//
//注：第三视图控制器呈现UIModalPresentationOverFullScreen的modalPresentationStyle，
//而不是默认UIModalPresentationFullScreen（在故事板中配置）。



//        When a fullscreen view controller is presented (the corresponding
//        presentation controller's -shouldRemovePresentersView returns YES),
//        the presentation controller temporarily relocates the
//        presenting view controller's view to the presentation controller's
//        containerView.  When the fullscreen view controller is dismissed,
//        the presentation controller places the presenting view controller's
//        view back in its previous superview.

/*
    当呈现全屏视图控制器（相应的演示控制器的-shouldRemovePresentersView返回YES）时，
 演示控制器暂时将呈现视图控制器的视图重定位到演示控制器的containerView。
 当全屏视图控制器被解除时，呈现控制器将呈现视图控制器的视图放回其先前的超视图中。
 
 */


//
//        The relocation of the presenting view controller's view poses a
//        problem in this example because only the presenting view controller's
//        view is relocated, not the intermediate view hierarchy we setup
//        to apply the rounded corner and shadow effect.  If you modify the
//        modalPresentationStyle of Third View Controller in the storyboard,
//        you may notice that during the presentation and dismissal animation
//        for Third View Controller, the rounded corner and shadow effect is
//        lost.
//

/*
    因为只有呈现视图控制器的观点是搬迁(放在新地方?)，而不是中间视图层次，
 我们设置应用圆角和阴影效果在这个例子中，呈现视图控制器的视图的搬迁带来了一个问题。
 如果在故事板中修改第三视图控制器的modalPresentationStyle，
 您可能会注意到在第三视图控制器的演示和解除动画期间，
 圆角和阴影效果将丢失。
 
 */

//        The workaround is to use the UIModalPresentationOverFullScreen
//        presentation style.  This presentation style is similar to
//        UIModalPresentationFullScreen but the presentation controller for
//        this presentation style overrides -shouldRemovePresentersView to
//        return NO, avoiding the above problem.


/*
    解决方法是使用uimodalpresentationoverscreen表示风格。
 这种表示风格类似于UIModalPresentationFullScreen，
 但是这种表示风格的表示控制器重写-shouldRemovePresentersView以返回NO，以避免上述问题。
 
 */

@interface AAPLCustomPresentationSecondViewController ()
@property (nonatomic, weak) IBOutlet UISlider *slider;
@end


@implementation AAPLCustomPresentationSecondViewController

//| ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
    // NOTE: View controllers presented with custom presentation controllers
    //       do not assume control of the status bar appearance by default
    //       (their -preferredStatusBarStyle and -prefersStatusBarHidden
    //       methods are not called).  You can override this behavior by
    //       setting the value of the presented view controller's
    //       modalPresentationCapturesStatusBarAppearance property to YES.
    /* self.modalPresentationCapturesStatusBarAppearance = YES; */
    
    /*
     //注意:带有自定义表示控制器的视图控制器默认情况下不承担状态栏外观的控制(不调用它们的-preferredStatusBarStyle和-prefersStatusBarHidden方法)。
     您可以通过将呈现的视图控制器的modalPresentationCapturesStatusBarAppearance属性的值设置为YES来覆盖此行为。
     self.modalPresentationCapturesStatusBarAppearance = YES;
     */
}


//| ----------------------------------------------------------------------------
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}


//| ----------------------------------------------------------------------------
//! Updates the receiver's preferredContentSize based on the verticalSizeClass
//! of the provided \a traitCollection.
//
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
    
    // To demonstrate how a presentation controller can dynamically respond
    // to changes to its presented view controller's preferredContentSize,
    // this view controller exposes a slider.  Dragging this slider updates
    // the preferredContentSize of this view controller in real time.
    //
    // Update the slider with appropriate min/max values and reset the
    // current value to reflect the changed preferredContentSize.
    
    /*
        为了演示表示控制器如何动态响应其所呈现的视图控制器的preferredContentSize的更改，这个视图控制器公开了一个滑块。
     拖动此滑块可实时更新视图控制器的preferredContentSize。
     
        使用适当的最小/最大值更新滑块，并重置当前值以反映已更改的preferredContentSize。
     */
    self.slider.maximumValue = self.preferredContentSize.height;
    self.slider.minimumValue = 110.f;
    self.slider.value = self.slider.maximumValue;
}


//| ----------------------------------------------------------------------------
- (IBAction)sliderValueChange:(UISlider*)sender
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, sender.value);
}

#pragma mark -
#pragma mark Unwind Actions

//| ----------------------------------------------------------------------------
//! Action for unwinding from the presented view controller (C).
//
- (IBAction)unwindToCustomPresentationSecondViewController:(UIStoryboardSegue *)sender
{ }

@end
