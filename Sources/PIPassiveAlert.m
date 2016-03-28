//
//  PIPassiveAlert.h
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
#import "PIPassiveAlertAnimationConfig.h"
#import "PIPassiveAlertConfig.h"
#import "PIPassiveAlertView.h"

@interface PIPassiveAlert () <PIPassiveAlertViewDelegate>

@property (nonatomic, strong, readwrite) PIPassiveAlertConfig *config;
@property (nonatomic, strong, readwrite) PIPassiveAlertAnimationConfig *animationConfig;
@property (nonatomic, weak, readwrite) id<PIPassiveAlertDelegate> delegate;
@property (nonatomic, copy, readwrite) NSString *message;

@property (nonatomic, strong) PIPassiveAlertView *alertView;
@property (nonatomic, strong) UIView *alertViewContainer;

@end


@implementation PIPassiveAlert

#pragma mark - Initialization

- (instancetype)initWithMessage:(NSString *)message config:(PIPassiveAlertConfig *)config animationConfig:(PIPassiveAlertAnimationConfig *)animationConfig delegate:(id<PIPassiveAlertDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.animationConfig = animationConfig;
        self.config = config;
        self.delegate = delegate;
        self.message = message;
    }
    
    return self;
}

- (instancetype)init {
    NSAssert(FALSE, @"-init should not be called.");
    
    return nil;
}

#pragma mark - Instance methods

- (void)closeAnimated:(BOOL)animated {
    CGRect finalAlertFrame = self.alertView.frame;
    
    switch (self.config.side) {
        case PIPassiveAlertConstraintSideBottom:
            finalAlertFrame.origin.y += finalAlertFrame.size.height;
            break;
            
        default:
            // 20 adds buffer so that the frame doesn't "bounce back" from above the view
            finalAlertFrame.origin.y -= finalAlertFrame.size.height + 20.f;
            break;
    }
    
    void (^completionBlock)() = ^{
        [self removeAlertView];
    };
    
    if (animated) {
        [self animateBlock:^{
            self.alertView.frame = finalAlertFrame;
        } completion:^(BOOL finished) {
            completionBlock();
        }];
    } else {
        completionBlock();
    }
}

#pragma mark Private instance methods

- (void)showInView:(UIView *)view originYCalculation:(PIPassiveAlertOriginYCalculation)originYCalculation {
    // In case the view is already gone when the alert is about to being shown
    if (!view) {
        return;
    }
    
    if (!originYCalculation) {
        NSAssert(NO, @"Should have origin-Y calculation.");
        return;
    }
    
    CGFloat originY = originYCalculation(self.config, CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    CGFloat topConstraintConstant = self.config.side == PIPassiveAlertConstraintSideOrigin ? originY : 0.f;
    
    self.alertView = [PIPassiveAlertView alertViewWithNib:self.config.nib message:self.message backgroundColor:self.config.backgroundColor textColor:self.config.textColor font:self.config.font textAlignment:self.config.textAlignment height:self.config.height isCloseButtonActive:self.config.isCloseButtonActive closeButtonImage:self.config.closeButtonImage delegate: self];
    
    CGRect frame = self.alertView.frame;
    frame.size.width = view.frame.size.width;
    self.alertView.frame = frame;
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.alertViewContainer = [self containerViewForAlertView:self.alertView];
    [view addSubview:self.alertViewContainer];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1
                                                             constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1
                                                              constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:topConstraintConstant];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1
                                                               constant:0];
    
    if (self.config.side == PIPassiveAlertConstraintSideBottom) {
        [view addConstraints:@[ left, right, bottom ]];
    } else {
        [view addConstraints:@[ left, right, top ]];
    }
    
    [self.alertViewContainer addConstraint:height];
    
    // Make the alert view size itself based off of the text height
    [self.alertViewContainer setNeedsLayout];
    [self.alertViewContainer layoutIfNeeded];
    
    [self animateBlock:^{
        [self.alertViewContainer removeConstraint:height];
        
        // If alertViewFrameHeight not specified then let alert view size itself based off of the text height
        if (self.config.height) {
            NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:self.config.height];
            [self.alertViewContainer addConstraint:height];
        }
        
        [self.alertViewContainer setNeedsLayout];
        [self.alertViewContainer layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.config.shouldAutoHide) {
            [self initiateAutomaticCloseTimer];
        }
    }];
}

- (UIView *)containerViewForAlertView:(PIPassiveAlertView *)alertView
{
    UIView *containerView = [[UIView alloc] initWithFrame:alertView.frame];
    
    containerView.backgroundColor = [UIColor clearColor];
    containerView.clipsToBounds = YES;
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [containerView addSubview:alertView];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:alertView
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:containerView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1
                                                             constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:alertView
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:containerView
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1
                                                              constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:alertView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:containerView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:alertView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:0];
    
    [containerView addConstraints:@[ left, right, top, bottom ]];
    
    return containerView;
}

- (void)initiateAutomaticCloseTimer
{
    [self performSelector:@selector(close) withObject:nil afterDelay:self.config.autoHideDelay];
}

- (void)close {
    [self closeAnimated:YES];
}

- (void)removeAlertView
{
    [self.alertView removeFromSuperview];
    self.alertView = nil;
    [self.alertViewContainer removeFromSuperview];
    self.alertViewContainer = nil;
}

- (void)animateBlock:(void (^)())block completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:self.animationConfig.duration delay:self.animationConfig.delay usingSpringWithDamping:self.animationConfig.damping initialSpringVelocity:self.animationConfig.initialVelocity options:UIViewAnimationOptionLayoutSubviews animations:block completion:completion];
}

#pragma mark - Protocol conformance

#pragma PIPassiveAlertViewDelegate

- (void)passiveAlertViewDidReceiveTap:(PIPassiveAlertView *)alertView atPoint:(CGPoint)touchPoint
{
    NSLog(@"Tapped!");
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertDidReceiveTap:atPoint:)]) {
            [self.delegate passiveAlertDidReceiveTap:self atPoint:touchPoint];
        }
    }
}

- (void)passiveAlertViewDidReceiveClose:(PIPassiveAlertView *)alertView
{
    NSLog(@"Button!");
}

@end
