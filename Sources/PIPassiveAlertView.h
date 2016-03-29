//
//  PIPassiveAlertView.h
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

@class PIPassiveAlertView;

/**
 *  Defines methods for receiving notifications from a passive alert view.
 */
@protocol PIPassiveAlertViewDelegate <NSObject>

/**
 *  Indicates that the passive alert view received a tap action. Will not be
 *  called if tap is made in close button while close button is active.
 *
 *  @param passiveAlert The passive alert that received the tap action.
 *  @param touchPoint   The point at which the alert was touch in terms of the alert.
 */
- (void)passiveAlertViewDidReceiveTap:(PIPassiveAlertView *)alertView atPoint:(CGPoint)touchPoint;

/**
 *  Indicates that the passive alert view received a close action.
 *
 *  @param passiveAlert The passive alert that received the close action.
 */
- (void)passiveAlertViewDidReceiveClose:(PIPassiveAlertView *)alertView;

@end

/**
 *  Passive alert view.
 */
@interface PIPassiveAlertView : UIView

/**
 *  The delegate of the passive alert view.
 */
@property (nonatomic, weak) id<PIPassiveAlertViewDelegate> delegate;

/**
 *  Creates alert view for provided attributes.
 *
 *  @param nib                 Nib for alert view.
 *  @param message             Message for alert view.
 *  @param backgroundColor     Background color type for alert view.
 *  @param font                Font for alert view.
 *  @param textColor           Text color for alert view.
 *  @param textAlightment      Text alignment for alert view.
 *  @param height              Height for alert view.
 *  @param closeButtonImage    Close button image.
 *  @param closeButtonWidth    Close button width.
 *  @param delegate            The delegate for the alert view.
 *
 *  @returns New alert view.
 */
+ (instancetype)alertViewWithNib:(UINib *)nib message:(NSString *)message backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment height:(CGFloat)height closeButtonImage:(UIImage *)closeButtonImage closeButtonWidth:(CGFloat)closeButtonWidth delegate:(id<PIPassiveAlertViewDelegate>)delegate;

@end
