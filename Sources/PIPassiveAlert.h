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
@class PIPassiveAlertConfig;

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

@end

/**
 *  The passive alert show-types.
 */
typedef NS_ENUM(NSInteger, PIPassiveAlertShowType) {
    /**
     *  Passive alerts with origin at the top of the window.
     */
    PIPassiveAlertShowTypeTop,
    
    /**
     *  Passive alerts with origin at the bottom of the window.
     */
    PIPassiveAlertShowTypeBottom,
    
    /**
     *  Passive alerts with origin at the navigationbar of the view.
     */
    PIPassiveAlertShowTypeNavigationBar,
    
    /**
     *  Passive alerts with custom origin.
     */
    PIPassiveAlertShowTypeCustomOrigin
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
 *  The nib used for UI of passive alert.
 */
@property (nonatomic, strong, readonly) UINib *nib;

/**
 *  The message of the passive alert.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 *  The height of the passive alert.
 */
@property (nonatomic, assign, readonly) CGFloat height;

/**
 *  The show type of the passive alert.
 */
@property (nonatomic, assign, readonly) PIPassiveAlertShowType showType;

/**
 *  Whether the passive alert should auto-hide.
 */
@property (nonatomic, assign, readonly) BOOL shouldAutoHide;

/**
 *  If auto-hiding, time after display before auto-hide occurs.
 */
@property (nonatomic, assign, readonly) CGFloat autoHideDelay;

/**
 *  Background color.
 */
@property (nonatomic, strong, readonly) UIColor *backgroundColor;

/**
 *  Text color.
 */
@property (nonatomic, strong, readonly) UIColor *textColor;

/**
 *  The font of the passive alert.
 */
@property (nonatomic, strong, readonly) UIFont *font;

/**
 *  The text alignment of the passive alert.
 */
@property (nonatomic, assign, readonly) NSTextAlignment textAlignment;

/**
 *  Creates new passive alert with the specified attributes.
 *
 *  @param message  The message to display.
 *  @param config   The config for the alert.
 *  @param delegate The delegate for the alert.
 */
- (instancetype)initWithMessage:(NSString *)message config:(PIPassiveAlertConfig *)config delegate:(id<PIPassiveAlertDelegate>)delegate;

/**
 *  Displays a passive alert with the specified message in the specified view controller.
 *
 *  @param vc       The view controller the alert should be displayed in.
 *  @param originY  The y-coordinate of the alert origin.
 */
- (void)showInViewController:(UIViewController *)vc originY:(CGFloat)originY;

/**
 *  Closes alert.
 *
 *  @param animated Whether closing of alert should be animated.
 */
- (void)closeAnimated:(BOOL)animted;

@end
