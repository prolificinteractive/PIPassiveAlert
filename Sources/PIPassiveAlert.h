//
//  PIPassiveAlert.h
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

@class PIPassiveAlert;
@class PIPassiveAlertAnimationConfig;
@class PIPassiveAlertConfig;

/**
 *  Block calculating origin-Y given an alert config and containing size.
 */
typedef CGFloat (^PIPassiveAlertOriginYCalculation)(PIPassiveAlertConfig *alertConfig, CGSize containingViewSize);

/**
 *  Defines methods for receiving notifications from a passive alert.
 */
@protocol PIPassiveAlertDelegate <NSObject>

@optional

/**
 *  Indicates that the passive alert received a tap.
 *
 *  @param passiveAlert The passive alert that received the tap.
 */
- (void)passiveAlertDidReceiveTap:(PIPassiveAlert *)passiveAlert;

/**
 *  Config to be used for passive alert.
 *
 *  @returns Config.
 */
- (PIPassiveAlertConfig *)passiveAlertConfig;

/**
 *  Animation config to be used for passive alert.
 *
 *  @returns Config.
 */
- (PIPassiveAlertAnimationConfig *)passiveAlertAnimationConfig;

@end

/**
 *  Where the alert is constrained to.
 */
typedef NS_ENUM(NSInteger, PIPassiveAlertConstraintSide) {
    /**
     *  Constrained to top of view.
     */
    PIPassiveAlertConstraintSideTop,
    
    /**
     *  Constrained to bottom of view.
     */
    PIPassiveAlertConstraintSideBottom,
    
    /**
     *  Constrained to where origin-Y sits.
     */
    PIPassiveAlertConstraintSideOrigin
};

/**
 *  Passive alert.
 */
@interface PIPassiveAlert : NSObject

/**
 *  The delegate of the passive alert.
 */
@property (nonatomic, weak, readonly) id<PIPassiveAlertDelegate> delegate;

/**
 *  The message of the passive alert.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 *  The config for the passive alert.
 */
@property (nonatomic, strong, readonly) PIPassiveAlertConfig *config;

/**
 *  The animation config for the passive alert.
 */
@property (nonatomic, strong, readonly) PIPassiveAlertAnimationConfig *animationConfig;

/**
 *  Creates new passive alert with the specified attributes.
 *
 *  @param message         The message to display.
 *  @param config          The config for the alert.
 *  @param animationConfig The animation config for the alert.
 *  @param delegate        The delegate for the alert.
 */
- (instancetype)initWithMessage:(NSString *)message config:(PIPassiveAlertConfig *)config animationConfig:(PIPassiveAlertAnimationConfig *)animationConfig delegate:(id<PIPassiveAlertDelegate>)delegate;

/**
 *  Displays a passive alert with the specified message in the specified view controller.
 *
 *  @param View                The view the alert should be displayed in.
 *  @param originYCalculation  Block to calculate origin Y.
 */
- (void)showInView:(UIView *)view originYCalculation:(PIPassiveAlertOriginYCalculation)originYCalculation;

/**
 *  Closes alert.
 *
 *  @param animated Whether closing of alert should be animated.
 */
- (void)closeAnimated:(BOOL)animted;

@end
