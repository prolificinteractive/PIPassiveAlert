//
//  PassiveAlertConfig.m
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

#import "PassiveAlertConfig.h"

@interface PassiveAlertConfig ()

@property (nonatomic, strong, readwrite) UINib *nib;
@property (nonatomic, assign, readwrite) PassiveAlertShowType showType;
@property (nonatomic, assign, readwrite) BOOL shouldAutoHide;
@property (nonatomic, assign, readwrite) CGFloat autoHideDelay;
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIColor *textColor;
@property (nonatomic, strong, readwrite) UIFont *font;
@property (nonatomic, assign, readwrite) NSTextAlignment textAlignment;

@end

@implementation PassiveAlertConfig

#pragma mark - Initialization

- (instancetype)initWithNib:(UINib *)nib showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide autoHideDelay:(CGFloat)autoHideDelay height:(CGFloat)height backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    self = [super init];
    
    if (self) {
        self.nib = nib;
        self.showType = showType;
        self.shouldAutoHide = shouldAutoHide;
        self.autoHideDelay = autoHideDelay;
        self.height = height;
        self.backgroundColor = backgroundColor;
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = textAlignment;
    }
    
    return self;
}

@end