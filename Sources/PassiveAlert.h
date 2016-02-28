//
//  PassiveAlert.h
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

#import <UIKit/UIKit.h>

@class PassiveAlert;
@class PassiveAlertView;

/**
 *  Defines methods for receiving notifications from a passive alert.
 */
@protocol PassiveAlertDelegate <NSObject>

@optional

/**
 *  Indicates that the passive alert received a tap.
 *
 *  @param passiveAlert The passive alert that received the tap.
 */
- (void)passiveAlertDidReceiveTapAction:(PassiveAlert *)passiveAlert;

/**
 *  Indicates that the passiev alert received a close action.
 *
 *  @param passiveAlert The passive alert that received the close action.
 */
- (void)passiveAlertDidReceiveCloseAction:(PassiveAlert *)passiveAlert;

@end

/**
 *  Passive alert.
 */
@interface PassiveAlert : NSObject

/**
 *  The delegate of the passive alert.
 */
@property (nonatomic, weak) id<PassiveAlertDelegate> delegate;

/**
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *  The passive alert will display from the top of the view controller's view.
 *
 *  @param message  The message to display in the passive alert.
 *  @param vc       The view controller the alert should be displayed in.
 *  @param delegate The delegate for the passive alert.
 */
+ (void)showMessage:(NSString *)message
   inViewController:(UIViewController *)vc
           delegate:(id<PassiveAlertDelegate>)delegate;

/**
 *  Creates and displays a passive alert with the specified message in the root window of the application.
 *
 *  @param message        The message to display.
 *  @param delegate       The delegate for the passive alert.
 */
+ (void)showWindowMessage:(NSString *)message
                 delegate:(id<PassiveAlertDelegate>)delegate;

/**
 *  Closes the currently displaying alert. If no alert is displaying, nothing happens.
 *
 *  @param animated YES if the alert should close with an animation; otherwise NO.
 */
+ (void)closeCurrentAlertAnimated:(BOOL)animated;

@end
