//
//  PIPassiveAlertAnimationConfig.h
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
 *  Data object representing configurable
 *  attributes of a passive alert animation.
 */
@interface PIPassiveAlertAnimationConfig : NSObject <NSCopying>

/**
 *  The total duration of the animations, measured in seconds. 
 *  If you specify a negative value or 0, the changes are made 
 *  without animating them.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  The amount of time (measured in seconds) to wait before 
 *  beginning the animations. Specify a value of 0 to begin 
 *  the animations immediately.
 */
@property (nonatomic, assign) NSTimeInterval delay;

/**
 *  The damping ratio for the spring animation as it approaches 
 *  its quiescent state. To smoothly decelerate the animation 
 *  without oscillation, use a value of 1. Employ a damping 
 *  ratio closer to zero to increase oscillation.
 */
@property (nonatomic, assign) CGFloat damping;

/**
 *  The initial spring velocity. For smooth start to the 
 *  animation, match this value to the view’s velocity as it 
 *  was prior to attachment.
 */
@property (nonatomic, assign) CGFloat initialVelocity;

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
+ (instancetype)mergeConfig:(PIPassiveAlertAnimationConfig *)firstConfig withSecondConfig:(PIPassiveAlertAnimationConfig *)secondConfig;

@end
