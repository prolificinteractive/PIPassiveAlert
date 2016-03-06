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
#import "PIPassiveAlertConfig.h"
#import "PIPassiveAlertDisplayType.h"
#import "PIPassiveAlertView.h"

@interface PIPassiveAlert () <PIPassiveAlertViewDelegate>

@property (nonatomic, weak, readwrite) id<PIPassiveAlertDelegate> delegate;
@property (nonatomic, strong, readwrite) UINib *nib;
@property (nonatomic, copy, readwrite) NSString *message;
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) PIPassiveAlertShowType showType;
@property (nonatomic, assign, readwrite) BOOL shouldAutoHide;
@property (nonatomic, assign, readwrite) CGFloat autoHideDelay;
@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIColor *textColor;
@property (nonatomic, strong, readwrite) UIFont *font;
@property (nonatomic, assign, readwrite) NSTextAlignment textAlignment;

@property (nonatomic, strong) PIPassiveAlertView *alertView;
@property (nonatomic, strong) UIView *alertViewContainer;

@end


@implementation PIPassiveAlert

#pragma mark - Class methods

#pragma mark Private class methods

+ (PIPassiveAlertViewDisplayOrientation)alertViewOrientationForDisplayTypeOrientation:(PIPassiveAlertViewDisplayOrientation)orientation {
    switch (orientation) {
        case PIPassiveAlertViewDisplayOrientationFromTop:
            return PIPassiveAlertViewDisplayOrientationFromTop;
        case PIPassiveAlertViewDisplayOrientationFromBottom:
            return PIPassiveAlertViewDisplayOrientationFromBottom;
        default:
            NSAssert(NO, @"Should not retrieve unexpected orientation.");
            return PIPassiveAlertViewDisplayOrientationFromTop;
    }
}

#pragma mark - Initialization

- (instancetype)initWithMessage:(NSString *)message config:(PIPassiveAlertConfig *)config delegate:(id<PIPassiveAlertDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.message = message;
        self.nib = config.nib;
        self.showType = config.showType;
        self.shouldAutoHide = config.shouldAutoHide;
        self.autoHideDelay = config.autoHideDelay;
        self.height = config.height;
        self.backgroundColor = config.backgroundColor;
        self.textColor = config.textColor;
        self.font = config.font;
        self.textAlignment = config.textAlignment;
        self.delegate = delegate;
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
    
    switch (self.showType) {
        case PIPassiveAlertShowTypeBottom:
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

- (void)showInViewController:(UIViewController *)vc displayType:(PIPassiveAlertDisplayType *)displayType {
    // In case the view is already gone when the alert is about to being shown
    if (!vc) {
        return;
    }
    
    UIView *view = vc.view;
    CGFloat originY = displayType.originYCalculation(self, CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    
    self.alertView = [PIPassiveAlertView alertViewWithNib:self.nib message:self.message orientation:[PIPassiveAlert alertViewOrientationForDisplayTypeOrientation:displayType.orientation] backgroundColor:self.backgroundColor textColor:self.textColor font:self.font textAlignment:self.textAlignment height:self.height delegate: self];
    
    CGRect frame = self.alertView.frame;
    frame.size.width = view.frame.size.width;
    self.alertView.frame = frame;
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.alertViewContainer = [self containerViewForAlertView:self.alertView];
    [vc.view addSubview:self.alertViewContainer];
    
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
                                                            constant:originY];
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
    
    if (self.showType == PIPassiveAlertShowTypeBottom) {
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
        if (self.height) {
            NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.alertViewContainer
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:self.height];
            [self.alertViewContainer addConstraint:height];
        }
        
        [self.alertViewContainer setNeedsLayout];
        [self.alertViewContainer layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.shouldAutoHide) {
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
    [self performSelector:@selector(close) withObject:nil afterDelay:self.autoHideDelay];
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
    [UIView animateWithDuration:0.6f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:0.6f options:UIViewAnimationOptionLayoutSubviews animations:block completion:completion];
}

#pragma mark - Protocol conformance

#pragma PassiveAlertViewDelegate

- (void)passiveAlertViewDidReceiveTap:(PIPassiveAlertView *)alertView {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertDidReceiveTap:)]) {
            [self.delegate passiveAlertDidReceiveTap:self];
        }
    }
}

@end
