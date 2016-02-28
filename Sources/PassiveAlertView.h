//
//  PassiveAlertView.h
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

/**
 *  The passive alert view show-types.
 */
typedef NS_ENUM(NSInteger, PassiveAlertViewShowType) {
    /**
     *  Top.
     */
    PassiveAlertViewShowTypeTop,
    /**
     *  Bottom.
     */
    PassiveAlertViewShowTypeBottom,
    /**
     *  Navigation bar.
     */
    PassiveAlertViewShowTypeNavigationBar,
    /**
     *  Custom origin.
     */
    PassiveAlertViewShowTypeCustomOrigin
};

/**
 *  Passive alert view.
 */
@interface PassiveAlertView : UIView

/**
 *  The show type of the passive alert view.
 */
@property (nonatomic, assign) PassiveAlertViewShowType showType;

/**
 *  Creates alert view for provided attributes.
 *
 *  @param nib             Nib for alert view.
 *  @param message         Message for alert view.
 *  @param showType        Show type for alert view.
 *  @param backgroundColor Background color type for alert view.
 *  @param textColor       Text color for alert view.
 *  @param font            Font for alert view.
 *  @param textAlightment  Text alignment for alert view.
 *  @param Height          Height for alert view.
 *
 *  @returns New alert view.
 */
+ (instancetype)alertViewWithNib:(UINib *)nib message:(NSString *)message showType:(PassiveAlertViewShowType)showType backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment height:(CGFloat)height;

@end
