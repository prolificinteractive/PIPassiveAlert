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
@class PassiveAlertConfig;

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
- (void)passiveAlertDidReceiveTap:(PassiveAlert *)passiveAlert;

/**
 *  Nib used for UI of passive alert.
 *
 *  @returns Nib.
 */
- (UINib *)passiveAlertNib;

/**
 *  Auto-hide delay to be used for passive alert.
 *
 *  @returns Auto-hide delay.
 */
- (CGFloat)passiveAlertAutoHideDelay;

/**
 *  Height to be used for passive alert.
 *
 *  @returns Height.
 */
- (CGFloat)passiveAlertHeight;

/**
 *  Background color to be used for passive alert.
 *
 *  @returns Color.
 */
- (UIColor *)passiveAlertBackgroundColor;

/**
 *  Text color to be used for passive alert.
 *
 *  @returns Color.
 */
- (UIColor *)passiveAlertTextColor;

/**
 *  Font to be used for passive alert.
 *
 *  @returns Font.
 */
- (UIFont *)passiveAlertFont;

/**
 *  Text alignment to be used for passive alert.
 *
 *  @returns Text alignment.
 */
- (NSTextAlignment)passiveAlertTextAlignment;

@end

/**
 *  The passive alert show-types.
 */
typedef NS_ENUM(NSInteger, PassiveAlertShowType) {
    /**
     *  Passive alerts with origin at the top of the window.
     */
    PassiveAlertShowTypeTop,
    
    /**
     *  Passive alerts with origin at the bottom of the window.
     */
    PassiveAlertShowTypeBottom,
    
    /**
     *  Passive alerts with origin at the navigationbar of the view.
     */
    PassiveAlertShowTypeNavigationBar,
    
    /**
     *  Passive alerts with custom origin.
     */
    PassiveAlertShowTypeCustomOrigin
};

/**
 *  Passive alert.
 */
@interface PassiveAlert : NSObject

/**
 *  The delegate of the passive alert.
 */
@property (nonatomic, weak) id<PassiveAlertDelegate> delegate;

/**
 *  The nib used for UI of passive alert.
 */
@property (nonatomic, strong) UINib *nib;

/**
 *  The message of the passive alert.
 */
@property (nonatomic, copy) NSString *message;

/**
 *  The height of the passive alert.
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  The show type of the passive alert.
 */
@property (nonatomic, assign) PassiveAlertShowType showType;

/**
 *  Whether the passive alert should auto-hide.
 */
@property (nonatomic, assign) BOOL shouldAutoHide;

/**
 *  If auto-hiding, time after display before auto-hide occurs.
 */
@property (nonatomic, assign) CGFloat autoHideDelay;

/**
 *  Background color.
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  Text color.
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  The font of the passive alert.
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  The text alignment of the passive alert.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

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
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *  The passive alert will display from the top of the view controller's view.
 *
 *  @param message  The message to display in the passive alert.
 *  @param vc       The view controller the alert should be displayed in.
 *  @param showType Defines where the passive alert should display from.
 *  @param autoHide YES if the passive alert should auto hide after presentation; otherwise, it will wait for manual dismissal.
 *  @param delegate The delegate for the passive alert.
 */
+ (void)showMessage:(NSString *)message inViewController:(UIViewController *)vc showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PassiveAlertDelegate>)delegate;

/**
 *  Creates and displays a passive alert with the specified message in the specified view controller.
 *  The passive alert will display from the top of the view controller's view.
 *
 *  @param message  The message to display in the passive alert.
 *  @param vc       The view controller the alert should be displayed in.
 *  @param originY  The y-coordinate of the alert origin.
 *  @param autoHide YES if the passive alert should auto hide after presentation; otherwise, it will wait for manual dismissal.
 *  @param delegate The delegate for the passive alert.
 */
+ (void)showMessage:(NSString *)message inViewController:(UIViewController *)vc originY:(CGFloat)originY shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PassiveAlertDelegate>)delegate;

/**
 *  Closes the currently displaying alert. If no alert is displaying, nothing happens.
 *
 *  @param animated YES if the alert should close with an animation; otherwise NO.
 */
+ (void)closeCurrentAlertAnimated:(BOOL)animated;

/**
 *  Default auto-hide delay used for passive alert if none provided.
 *
 *  @returns Auto-hide delay.
 */
+ (CGFloat)defaultAutoHideDelay;

/**
 *  Default config used to supply values when none provided.
 *
 *  @returns Config.
 */
+ (PassiveAlertConfig *)defaultConfig;

/**
 *  Creates new passive alert with the specified attributes.
 *
 *  @param message  The message to display.
 *  @param config   The config for the alert.
 *  @param delegate The delegate for the alert.
 */
- (instancetype)initWithMessage:(NSString *)message config:(PassiveAlertConfig *)config delegate:(id<PassiveAlertDelegate>)delegate;

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
