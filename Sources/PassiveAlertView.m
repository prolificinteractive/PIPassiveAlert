//
//  PassiveAlertView.m
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

#import "PassiveAlert.h"
#import "PassiveAlertView.h"

#pragma mark - Constants

static NSString *const kPIPassiveAlertDefaultNibName = @"PIPassiveAlertView";

@interface PassiveAlertView ()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) UIView *supportingBackgroundView;

@end

@implementation PassiveAlertView

#pragma mark - Class

#pragma mark Class methods

+ (instancetype)alertViewForAlert:(PassiveAlert *)alert {
    UINib *nib = [UINib nibWithNibName:kPIPassiveAlertDefaultNibName bundle:nil];
    PassiveAlertView *alertView = [[nib instantiateWithOwner:self options:nil] firstObject];
    
    NSAssert([alertView isKindOfClass:[PassiveAlertView class]], @"Nib must contain view of type %@", kPIPassiveAlertDefaultNibName);
    
    alertView.messageLabel.text = alert.message;
    alertView.showType = [self alertViewShowTypeForAlertType:alert.showType];
    alertView.clipsToBounds = YES;
    alertView.backgroundColor = alert.backgroundColor;
    alertView.messageLabel.textColor = alert.textColor;
    alertView.messageLabel.font = alert.font;
    alertView.messageLabel.textAlignment = alert.textAlignment;
    
    if (alert.height) {
        alertView.frame = CGRectMake(alertView.frame.origin.x, alertView.frame.origin.y, alertView.frame.size.width, alert.height);
    }
    
    return alertView;
}

#pragma mark Private class methods

+ (PassiveAlertViewShowType)alertViewShowTypeForAlertType:(PassiveAlertShowType)alertShowType {
    switch (alertShowType) {
        case PassiveAlertShowTypeTop:
            return PassiveAlertViewShowTypeTop;
            break;
            
        case PassiveAlertShowTypeBottom:
            return PassiveAlertViewShowTypeBottom;
            break;
            
        case PassiveAlertShowTypeNavigationBar:
            return PassiveAlertViewShowTypeNavigationBar;
            break;
            
        case PIPassiveAlertShowTypeCustomOrigin:
            return PassiveAlertViewShowTypeCustomOrigin;
            break;
            
        default:
            return [self alertViewShowTypeForAlertType:PassiveAlertShowTypeTop];
            break;
    }
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Add extra background to the top, for the spring animation
        [self setupSupportingBackgroundView];
    }
    return self;
}

#pragma mark - Override methods

- (void)layoutSubviews
{
    CGRect frame = self.frame;
    frame.size.width = CGRectGetWidth(self.superview.superview.bounds);
    self.frame = frame;
    
    // Adjust container view's frame
    frame = self.superview.frame;
    frame.size.width = CGRectGetWidth(self.frame);
    self.superview.frame = frame;
    
    CGRect bounds = self.bounds;
    
    switch (self.showType) {
        case PassiveAlertViewShowTypeCustomOrigin:
        case PassiveAlertViewShowTypeTop:
            bounds.origin.y = -(bounds.size.height);
            break;
            
        case PassiveAlertViewShowTypeBottom:
            bounds.origin.y = (bounds.size.height);
            break;
            
        case PassiveAlertViewShowTypeNavigationBar:
            bounds.origin.y = -(bounds.size.height);
            break;
            
        default:
            break;
    }
    
    self.supportingBackgroundView.frame = bounds;
    self.supportingBackgroundView.backgroundColor = self.backgroundColor;
    
    [super layoutSubviews];
}

#pragma mark - Instance methods

#pragma mark Private instance methods

- (void)setupSupportingBackgroundView
{
    self.supportingBackgroundView = [UIView new];
    self.supportingBackgroundView.backgroundColor = self.backgroundColor;
    [self insertSubview:self.supportingBackgroundView atIndex:[self.subviews count]];
    [self setNeedsLayout];
}

@end
