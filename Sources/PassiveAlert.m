//
//  PassiveAlert.h
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
#import "PassiveAlertConfig.h"
#import "PassiveAlertView.h"

@interface PassiveAlert () <PassiveAlertViewDelegate>

@property (nonatomic, weak, readwrite) id<PassiveAlertDelegate> delegate;
@property (nonatomic, strong, readwrite) UINib *nib;
@property (nonatomic, copy, readwrite) NSString *message;
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) PassiveAlertShowType showType;
@property (nonatomic, assign, readwrite) BOOL shouldAutoHide;
@property (nonatomic, assign, readwrite) CGFloat autoHideDelay;
@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIColor *textColor;
@property (nonatomic, strong, readwrite) UIFont *font;
@property (nonatomic, assign, readwrite) NSTextAlignment textAlignment;

@property (nonatomic, strong) PassiveAlertView *alertView;
@property (nonatomic, strong) UIView *alertViewContainer;

@end


@implementation PassiveAlert

#pragma mark - Class methods

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
            
        case PassiveAlertShowTypeCustomOrigin:
            return PassiveAlertViewShowTypeCustomOrigin;
            break;
            
        default:
            return [self alertViewShowTypeForAlertType:PassiveAlertShowTypeTop];
            break;
    }
}

#pragma mark - Initialization

- (instancetype)initWithMessage:(NSString *)message config:(PassiveAlertConfig *)config delegate:(id<PassiveAlertDelegate>)delegate {
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

- (void)showInViewController:(UIViewController *)vc originY:(CGFloat)originY {
    [self showInView:vc.view origin:CGPointMake(0.0f, originY)];
}

- (void)closeAnimated:(BOOL)animated {
    CGRect finalAlertFrame = self.alertView.frame;
    
    switch (self.showType) {
        case PassiveAlertShowTypeBottom:
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

- (void)showInView:(UIView *)view origin:(CGPoint)origin
{
    // In case the view is already gone when the alert is about to being shown
    if (!view) {
        return;
    }
    
    self.alertView = [PassiveAlertView alertViewWithNib:self.nib message:self.message showType:[PassiveAlert alertViewShowTypeForAlertType:self.showType] backgroundColor:self.backgroundColor textColor:self.textColor font:self.font textAlignment:self.textAlignment height:self.height delegate: self];
    
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
                                                            constant:origin.y];
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
    
    if (self.showType == PassiveAlertShowTypeBottom) {
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

- (UIView *)containerViewForAlertView:(PassiveAlertView *)alertView
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

- (void)passiveAlertViewDidReceiveTap:(PassiveAlertView *)alertView {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertDidReceiveTap:)]) {
            [self.delegate passiveAlertDidReceiveTap:self];
        }
    }
}

@end
