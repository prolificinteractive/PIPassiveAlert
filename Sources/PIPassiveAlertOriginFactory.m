//
//  PIPassiveAlertOriginFactory.m
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

#import "PIPassiveAlertOriginFactory.h"

@implementation PIPassiveAlertOriginFactory

#pragma mark - Class methods

+ (instancetype)factory {
    return [[PIPassiveAlertOriginFactory alloc] init];
}

#pragma mark - Instance methods

- (PIPassiveAlertOriginYCalculation)topOriginYCalculation {
    PIPassiveAlertOriginYCalculation originYCalculation = ^CGFloat(CGFloat alertHeight, CGSize containingViewSize) {
        return 0.f;
    };
    
    return originYCalculation;
}

- (PIPassiveAlertOriginYCalculation)bottomOriginYCalculation {
    PIPassiveAlertOriginYCalculation originYCalculation = ^CGFloat(CGFloat alertHeight, CGSize containingViewSize) {
        return containingViewSize.height - alertHeight;
    };
    
    return originYCalculation;
}

- (PIPassiveAlertOriginYCalculation)navBarOriginYCalculationForViewController:(UIViewController *)vc {
    PIPassiveAlertOriginYCalculation originYCalculation = ^CGFloat(CGFloat alertHeight, CGSize containingViewSize) {
        return (vc.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    };
    
    return originYCalculation;
}

- (PIPassiveAlertOriginYCalculation)statusBarOriginYCalculation {
    PIPassiveAlertOriginYCalculation originYCalculation = ^CGFloat(CGFloat alertHeight, CGSize containingViewSize) {
        return [[UIApplication sharedApplication] statusBarFrame].size.height;
    };
    
    return originYCalculation;
}

@end
