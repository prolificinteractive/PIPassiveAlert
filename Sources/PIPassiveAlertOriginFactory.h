//
//  PIPassiveAlertOriginFactory.h
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
 *  Factory for common origin-Y calculation blocks.
 */
@interface PIPassiveAlertOriginFactory : NSObject

/**
 *  Creates a new instance of origin factory.
 *
 *  @returns New instance.
 */
+ (instancetype)factory;

/**
 *  Block that calculates bottom origin-Y.
 *
 *  @returns Block.
 */
- (PIPassiveAlertOriginYCalculation)bottomOriginYCalculation;

/**
 *  Block that calculates for origin-Y at nav bar bottom.
 *
 *  @returns Block.
 */
- (PIPassiveAlertOriginYCalculation)navBarOriginYCalculationForViewController:(UIViewController *)vc;

/**
 *  Block that simply returns the value provided for origin-Y.
 *
 *  @param value: Value of origin-Y.
 *
 *  @returns Block.
 */
- (PIPassiveAlertOriginYCalculation)staticValueOriginYCalculationWithValue:(CGFloat)value;

/**
 *  Block that calculates for origin-Y at status bar bottom.
 *
 *  @returns Block.
 */
- (PIPassiveAlertOriginYCalculation)statusBarOriginYCalculation;

/**
 *  Block that calculates top origin-Y.
 *
 *  @returns Block.
 */
- (PIPassiveAlertOriginYCalculation)topOriginYCalculation;

@end
