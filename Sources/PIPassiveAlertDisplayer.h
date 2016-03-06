//
//  PIPassiveAlertDisplayer.h
//  PIPassiveAlert
//
// Copyright (c) 2016 Prolific Interactive
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "PIPassiveAlert.h"
#import "PIPassiveAlertConfig.h"
#import "PIPassiveAlertOriginFactory.h"

#import <UIKit/UIKit.h>

@interface PIPassiveAlertDisplayer : NSObject

/**
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *  The passive alert will display from the top of the view controller's view.
 *
 *  @param message  The message to display in the passive alert.
 *  @param vc       The view controller the alert should be displayed in.
 *  @param delegate The delegate for the passive alert.
 */
+ (void)displayMessage:(NSString *)message
      inViewController:(UIViewController *)vc
              delegate:(id<PIPassiveAlertDelegate>)delegate;

/**
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *
 *  @param message  The message to display in the passive alert.
 *  @param vc       The view controller the alert should be displayed in.
 *  @param showType Defines where the passive alert should display from.
 *  @param autoHide YES if the passive alert should auto hide after presentation; otherwise, it will wait for manual dismissal.
 *  @param delegate The delegate for the passive alert.
 */
+ (void)displayMessage:(NSString *)message
      inViewController:(UIViewController *)vc
              showType:(PIPassiveAlertShowType)showType
        shouldAutoHide:(BOOL)shouldAutoHide
              delegate:(id<PIPassiveAlertDelegate>)delegate;

/**
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *
 *  @param message            The message to display in the passive alert.
 *  @param vc                 The view controller the alert should be displayed in.
 *  @param originYCalculation Block to calculate origin y.
 *  @param shouldAutHide      YES if the passive alert should auto hide after presentation; otherwise, it will wait for manual dismissal.
 *  @param delegate           The delegate for the passive alert.
 */
+ (void)displayMessage:(NSString *)message
      inViewController:(UIViewController *)vc
    originYCalculation:(PIPassiveAlertOriginYCalculation)originYCalculation
        shouldAutoHide:(BOOL)shouldAutHide
              delegate:(id<PIPassiveAlertDelegate>)delegate;

/**
 *  Closes the currently displaying alert. If no alert is displaying, nothing happens.
 *
 *  @param animated YES if the alert should close with an animation; otherwise NO.
 */
+ (void)closeCurrentAlertAnimated:(BOOL)animated;

/**
 *  Default config used to supply values when none provided.
 *
 *  @returns Config.
 */
+ (PIPassiveAlertConfig *)defaultConfig;

/**
 *  Factory used to calculate alert origin-Y values.
 *
 *  @returns Factory.
 */
+ (PIPassiveAlertOriginFactory *)originFactory;

@end
