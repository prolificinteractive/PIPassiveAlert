//
//  PIPassiveAlertConfig.h
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

#import <UIKit/UIKit.h>

/**
 *  Data object representing configurable
 *  attributes of a passive alert.
 */
@interface PIPassiveAlertConfig : NSObject <NSCopying>

/**
 *  Nib.
 */
@property (nonatomic, strong) UINib *nib;

/**
 *  Side.
 */
@property (nonatomic, assign) PIPassiveAlertConstraintSide side;

/**
 *  Should auto-hide.
 */
@property (nonatomic, assign) BOOL shouldAutoHide;

/**
 *  Auto-hide delay.
 */
@property (nonatomic, assign) CGFloat autoHideDelay;

/**
 *  Height.
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  Background color.
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  Text color.
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  Font.
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  Text alignment.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 *  Creates new config.
 *
 *  @returns New config.
 */
+ (instancetype)config;

/**
 *  Merges first config with second config. If both contain values,
 *  second config value takes precedence.
 *
 *  @parameter firstConfig:  First config.
 *  @parameter secondConfig: Second config.
 *
 *  @returns New config.
 */
+ (instancetype)mergeConfig:(PIPassiveAlertConfig *)firstConfig withSecondConfig:(PIPassiveAlertConfig *)secondConfig;

@end
