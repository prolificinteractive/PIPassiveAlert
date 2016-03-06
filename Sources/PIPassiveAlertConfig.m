//
//  PIPassiveAlertConfig.m
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

#import "PIPassiveAlertConfig.h"

@implementation PIPassiveAlertConfig

#pragma mark - Class methods

+ (instancetype)config {
    return [[PIPassiveAlertConfig alloc] init];
}

+ (PIPassiveAlertConfig *)mergeConfig:(PIPassiveAlertConfig *)firstConfig withSecondConfig:(PIPassiveAlertConfig *)secondConfig {
    PIPassiveAlertConfig *firstCopy = [firstConfig copy];
    PIPassiveAlertConfig *secondCopy = [secondConfig copy];
    
    if (secondCopy.nib) {
        firstCopy.nib = secondCopy.nib;
    }
    
    if (secondCopy.side) {
        firstCopy.side = secondCopy.side;
    }
    
    if (secondCopy.shouldAutoHide) {
        firstCopy.shouldAutoHide = secondCopy.shouldAutoHide;
    }
    
    if (secondCopy.autoHideDelay) {
        firstCopy.autoHideDelay = secondCopy.autoHideDelay;
    }
    
    if (secondCopy.height) {
        firstCopy.height = secondCopy.height;
    }
    
    if (secondCopy.backgroundColor) {
        firstCopy.backgroundColor = secondCopy.backgroundColor;
    }
    
    if (secondCopy.textColor) {
        firstCopy.textColor = secondCopy.textColor;
    }
    
    if (secondCopy.font) {
        firstCopy.font = secondCopy.font;
    }
    
    if (secondCopy.textAlignment) {
        firstCopy.textAlignment = secondCopy.textAlignment;
    }
    
    return firstCopy;
}

#pragma mark - Protocol conformance

#pragma mark <NSCopying>

- (id)copyWithZone:(NSZone *)zone
{
    PIPassiveAlertConfig *copy = [[PIPassiveAlertConfig allocWithZone: zone] init];
    
    copy.nib = self.nib;
    copy.side = self.side;
    copy.shouldAutoHide = self.shouldAutoHide;
    copy.autoHideDelay = self.autoHideDelay;
    copy.height = self.height;
    copy.backgroundColor = [self.backgroundColor copy];
    copy.textColor = [self.textColor copy];
    copy.font = [self.font copy];
    copy.textAlignment = self.textAlignment;
    
    return copy;
}

@end
