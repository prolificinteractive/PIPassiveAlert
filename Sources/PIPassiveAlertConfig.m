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

@interface PIPassiveAlertConfig ()

@end

@implementation PIPassiveAlertConfig

#pragma mark - Class methods

+ (instancetype)config {
    return [[PIPassiveAlertConfig alloc] init];
}

+ (PIPassiveAlertConfig *)mergeConfig:(PIPassiveAlertConfig *)firstConfig withSecondConfig:(PIPassiveAlertConfig *)secondConfig {
    PIPassiveAlertConfig *config = [firstConfig copy];
    
    if (secondConfig.nib) {
        config.nib = [secondConfig.nib copy];
    }
    
    if (secondConfig.showType) {
        config.showType = secondConfig.showType;
    }
    
    if (secondConfig.shouldAutoHide) {
        config.shouldAutoHide = secondConfig.shouldAutoHide;
    }
    
    if (secondConfig.autoHideDelay) {
        config.autoHideDelay = secondConfig.autoHideDelay;
    }
    
    if (secondConfig.height) {
        config.height = secondConfig.height;
    }
    
    if (secondConfig.backgroundColor) {
        config.backgroundColor = [secondConfig.backgroundColor copy];
    }
    
    if (secondConfig.textColor) {
        config.textColor = [secondConfig.textColor copy];
    }
    
    if (secondConfig.font) {
        config.font = [secondConfig.font copy];
    }
    
    if (secondConfig.textAlignment) {
        config.textAlignment = secondConfig.textAlignment;
    }
    
    return config;
}

#pragma mark - Protocol conformance

#pragma mark <NSCopying>

- (id)copyWithZone:(NSZone *)zone
{
    PIPassiveAlertConfig *copy = [[PIPassiveAlertConfig allocWithZone: zone] init];
    
    copy.nib = self.nib;
    copy.showType = self.showType;
    copy.shouldAutoHide = self.shouldAutoHide;
    copy.autoHideDelay = self.autoHideDelay;
    copy.height = self.height;
    copy.backgroundColor = self.backgroundColor;
    copy.textColor = self.textColor;
    copy.font = self.font;
    copy.textAlignment = self.textAlignment;
    
    return copy;
}

@end
