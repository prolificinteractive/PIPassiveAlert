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
#import "PassiveAlertView.h"

#pragma mark - Constants

static NSString *const kPIPassiveAlertDefaultNibName = @"PIPassiveAlertView";

@interface PassiveAlert () <PassiveAlertViewDelegate>

@property (nonatomic, strong) PassiveAlertView *alertView;
@property (nonatomic, strong) UIView *alertViewContainer;

@end


@implementation PassiveAlert

#pragma mark - Class

#pragma mark Class properties

static PassiveAlert *currentAlert = nil;

#pragma mark Class methods

+ (void)showMessage:(NSString *)message
   inViewController:(UIViewController *)vc
           delegate:(id<PassiveAlertDelegate>)delegate {
    [self showMessage:message inViewController:vc showType:PassiveAlertShowTypeTop shouldAutoHide:YES delegate:delegate];
}

+ (void)showMessage:(NSString *)message inViewController:(UIViewController *)vc showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PassiveAlertDelegate>)delegate {
    
    UINib *nib = [self defaultNib];
    CGFloat autoHideDelay = [self defaultAutoHideDelay];
    CGFloat height = [self defaultHeight];
    UIColor *backgroundColor = [self defaultBackgroundColor];
    UIColor *textColor = [self defaultTextColor];
    UIFont *font = [self defaultFont];
    NSTextAlignment textAlignment = [self defaultTextAlignment];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(passiveAlertNib)]) {
            nib = [delegate passiveAlertNib];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertAutoHideDelay)]) {
            autoHideDelay = [delegate passiveAlertAutoHideDelay];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertHeight)]) {
            height = [delegate passiveAlertHeight];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertBackgroundColor)]) {
            backgroundColor = [delegate passiveAlertBackgroundColor];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertTextColor)]) {
            textColor = [delegate passiveAlertTextColor];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertFont)]) {
            font = [delegate passiveAlertFont];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertTextAlignment)]) {
            textAlignment = [delegate passiveAlertTextAlignment];
        }
    }
    
    PassiveAlert *alert = [[PassiveAlert alloc] initWithNib:nib message:message showType:showType shouldAutoHide:shouldAutoHide autoHideDelay:autoHideDelay height:height backgroundColor:backgroundColor textColor:textColor font:font textAlignment:textAlignment delegate:delegate];
    
    [alert showInViewController:vc];
}

+ (void)showWindowMessage:(NSString *)message
                 delegate:(id<PassiveAlertDelegate>)delegate {
    NSLog(@"Showing alert message for window: %@", message);
}

+ (void)closeCurrentAlertAnimated:(BOOL)animated {
    NSLog(@"Closing alert; animated: %i", animated);
}

+ (UINib *)defaultNib {
    return [UINib nibWithNibName:kPIPassiveAlertDefaultNibName bundle:nil];
}

+ (CGFloat)defaultAutoHideDelay {
    return 3.f;
}

+ (CGFloat)defaultHeight {
    return 70;
}

+ (UIColor *)defaultBackgroundColor {
    return [UIColor redColor];
}

+ (UIColor *)defaultTextColor {
    return [UIColor whiteColor];
}

+ (UIFont *)defaultFont {
    return [UIFont systemFontOfSize:15.f];
}

+ (NSTextAlignment)defaultTextAlignment {
    return NSTextAlignmentCenter;
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

- (instancetype)initWithNib:(UINib *)nib message:(NSString *)message showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide autoHideDelay:(CGFloat)autoHideDelay height:(CGFloat)height backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment delegate:(id<PassiveAlertDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.nib = nib;
        self.message = message;
        self.showType = showType;
        self.shouldAutoHide = shouldAutoHide;
        self.autoHideDelay = autoHideDelay;
        self.height = height;
        self.backgroundColor = backgroundColor;
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = textAlignment;
        self.delegate = delegate;
    }
    
    return self;
}

- (instancetype)init {
    NSAssert(FALSE, @"-init should not be called.");
    
    return nil;
}

#pragma mark - Instance methods

- (void)showInViewController:(UIViewController *)vc {
    CGPoint origin = vc.view.bounds.origin;
    
    origin.y = [self originForPassiveAlertOfShowType:self.showType inViewController:vc];
    
    [self showInView:vc.view origin:origin];
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
    if (currentAlert) {
        [currentAlert closeAnimated:YES];
        currentAlert = nil;
    }
    
    // In case the view is already gone when the alert is about to being shown
    if (!view) {
        return;
    }
    
    currentAlert = self;
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
    
    // PassiveAlert for tooltip in schedule view, we want the animation from the bottom. Handling it here.
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

- (CGFloat)originForPassiveAlertOfShowType:(PassiveAlertShowType)showType inViewController:(UIViewController *)vc
{
    switch (showType) {
        case PassiveAlertShowTypeTop:
            return 0.f;
            break;
            
        case PassiveAlertShowTypeBottom:
            return vc.view.bounds.size.height - self.height;
            break;
            
        case PassiveAlertShowTypeNavigationBar:
            return (vc.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
            break;
            
        default:
            return [self originForPassiveAlertOfShowType:PassiveAlertShowTypeTop inViewController:vc];
            break;
    }
}

#pragma mark - Protocol conformance

#pragma PassiveAlertViewDelegate

- (void)passiveAlertViewDidReceiveTap:(PassiveAlertView *)alertView {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(passiveAlertDidReceiveTapAction:)]) {
            [self.delegate passiveAlertDidReceiveTapAction:self];
        }
    }
}

@end
