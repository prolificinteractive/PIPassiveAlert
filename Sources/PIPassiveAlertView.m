//
//  PIPassiveAlertView.m
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

#import "PIPassiveAlertView.h"

@interface PIPassiveAlertView ()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLabelLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clostButtonContainerWidthConstraint;

@end

@implementation PIPassiveAlertView

#pragma mark - Class

#pragma mark Class methods

+ (instancetype)alertViewWithNib:(UINib *)nib message:(NSString *)message backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment height:(CGFloat)height closeButtonImage:(UIImage *)closeButtonImage closeButtonWidth:(CGFloat)closeButtonWidth delegate:(id<PIPassiveAlertViewDelegate>)delegate {
    PIPassiveAlertView *alertView = [[nib instantiateWithOwner:self options:nil] firstObject];
    
    NSAssert([alertView isKindOfClass:[PIPassiveAlertView class]], @"Nib must contain view of type %@", [[PIPassiveAlertView class] description]);
    
    alertView.clipsToBounds = YES;
    alertView.messageLabel.text = message;
    alertView.backgroundColor = backgroundColor;
    alertView.messageLabel.textColor = textColor;
    alertView.messageLabel.font = font;
    alertView.messageLabel.textAlignment = textAlignment;
    alertView.clostButtonContainerWidthConstraint.constant = closeButtonWidth;
    alertView.delegate = delegate;
    
    if (height) {
        alertView.frame = CGRectMake(alertView.frame.origin.x, alertView.frame.origin.y, alertView.frame.size.width, height);
    }
    
    if (closeButtonImage) {
        [alertView.closeButton setImage:closeButtonImage forState:UIControlStateNormal];
        
        if (textAlignment == NSTextAlignmentLeft) {
            alertView.messageLabelLeadingConstraint.constant = alertView.clostButtonContainerWidthConstraint.constant;
        }
    } else {
        alertView.closeButton.hidden = true;
    }
    
    return alertView;
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    return self;
}

#pragma mark - Instance methods

#pragma mark Private instance methods

- (IBAction)didReceiveTap:(UITapGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView: self];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertViewDidReceiveTap:atPoint:)]) {
            [self.delegate passiveAlertViewDidReceiveTap:self atPoint:touchPoint];
        }
    }
}

- (IBAction)didReceiveTapToCloseButton:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertViewDidReceiveClose:)]) {
            [self.delegate passiveAlertViewDidReceiveClose:self];
        }
    }
}

@end
