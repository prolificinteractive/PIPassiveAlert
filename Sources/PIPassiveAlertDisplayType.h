//
//  PIPassiveAlertDisplayType.h
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

#import <Foundation/Foundation.h>

@class PIPassiveAlertConfig;

/**
 *  Function calculating origin-Y given an alert config and containing frame.
 */
typedef CGFloat (^PIPassiveAlertDisplayOriginYCalculation)(PIPassiveAlertConfig *alertConfig, CGSize containingViewSize);

/**
 *  Passive alert orientation.
 */
typedef NS_ENUM(NSInteger, PIPassiveAlertDisplayOrientation) {
    /**
     *  From top.
     */
    PIPassiveAlertDisplayOrientationFromTop,
    
    /**
     *  From bottom.
     */
    PIPassiveAlertDisplayOrientationFromBottom
};

/**
 *  Data object representing configurable
 *  attributes of a passive alert display.
 */
@interface PIPassiveAlertDisplayType : NSObject

/**
 *  Orientation.
 */
@property (nonatomic, assign, readonly) PIPassiveAlertDisplayOrientation orientation;

/**
 *  Block calculating origin Y for alert.
 */
@property (nonatomic, strong, readonly) PIPassiveAlertDisplayOriginYCalculation originYCalculation;

/**
 *  Creates new display type with the specified attributes.
 *
 *  @param orientation        The orientation.
 *  @param originYCalculation Function calculating origin-Y.
 */
- (instancetype)initWithOrientation:(PIPassiveAlertDisplayOrientation)orientation originYCalculation:(PIPassiveAlertDisplayOriginYCalculation)originYCalculation;

@end
