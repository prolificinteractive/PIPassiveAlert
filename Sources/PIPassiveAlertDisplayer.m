//
//  PIPassiveAlertDisplayer.m
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

#import "PIPassiveAlertDisplayer.h"

#pragma mark - Constants

static NSString *const kPIPassiveAlertResourceBundleName = @"PIPassiveAlert";
static NSString *const kPIPassiveAlertDefaultNibName = @"PIPassiveAlertView";

@implementation PIPassiveAlertDisplayer

static PIPassiveAlert *currentAlert = nil;

#pragma mark - Class methods

+ (void)displayMessage:(NSString *)message inViewController:(UIViewController *)vc delegate:(id<PIPassiveAlertDelegate>)delegate {
    [self displayMessage:message inViewController:vc side:PIPassiveAlertConstraintSideTop shouldAutoHide:YES delegate:delegate];
}

+ (void)displayMessage:(NSString *)message inViewController:(UIViewController *)vc side:(PIPassiveAlertConstraintSide)side shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    PIPassiveAlert *alert = [self alertWithMessage:message inViewController:vc side:side shouldAutoHide:shouldAutoHide delegate:delegate];
    PIPassiveAlertOriginYCalculation originYCalculation = nil;
    
    switch (side) {
        case PIPassiveAlertConstraintSideTop:
            originYCalculation = [[self originFactory] topOriginYCalculation];
            break;
            
        case PIPassiveAlertConstraintSideBottom:
            originYCalculation = [[self originFactory] bottomOriginYCalculation];
            break;
            
        default:
            break;
    }
    
    [self displayAlert:alert originYCalculation:originYCalculation inViewController:vc];
}

+ (void)displayMessage:(NSString *)message inViewController:(UIViewController *)vc originYCalculation:(PIPassiveAlertOriginYCalculation)originYCalculation shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    PIPassiveAlert *alert = [self alertWithMessage:message inViewController:vc side:PIPassiveAlertConstraintSideOrigin shouldAutoHide:shouldAutoHide delegate:delegate];

    [self displayAlert:alert originYCalculation:originYCalculation inViewController:vc];
}

+ (void)closeCurrentAlertAnimated:(BOOL)animated {
    if (currentAlert) {
        [currentAlert closeAnimated:animated];
    }
}

+ (PIPassiveAlertConfig *)defaultConfig {
    PIPassiveAlertConfig *defaultConfig = [PIPassiveAlertConfig config];
    
    defaultConfig.nib = [self defaultNib];
    defaultConfig.side = PIPassiveAlertConstraintSideTop;
    defaultConfig.shouldAutoHide = YES;
    defaultConfig.autoHideDelay = 3.f;
    defaultConfig.backgroundColor = [UIColor redColor];
    defaultConfig.textColor = [UIColor whiteColor];
    defaultConfig.font = [UIFont systemFontOfSize:17.f]; // default Apple body text size
    defaultConfig.textAlignment = NSTextAlignmentCenter;
    
    return defaultConfig;
}

+ (PIPassiveAlertAnimationConfig *)defaultAnimationConfig {
    PIPassiveAlertAnimationConfig *defaultConfig = [PIPassiveAlertAnimationConfig config];
    
    defaultConfig.duration = 0.6f;
    defaultConfig.delay = 0.f;
    defaultConfig.damping = 0.5f;
    defaultConfig.initialVelocity = 0.6f;
    
    return defaultConfig;
}

+ (PIPassiveAlertOriginFactory *)originFactory {
    return [PIPassiveAlertOriginFactory factory];
}

#pragma mark Private class methods

+ (void)displayAlert:(PIPassiveAlert *)alert originYCalculation:(PIPassiveAlertOriginYCalculation)originYCalculation inViewController:(UIViewController *)vc {
    if (currentAlert) {
        [currentAlert closeAnimated:YES];
        currentAlert = nil;
    }
    
    currentAlert = alert;

    [alert showInView:vc.view originYCalculation:originYCalculation];
}

+ (PIPassiveAlert *)alertWithMessage:(NSString *)message inViewController:(UIViewController *)vc side:(PIPassiveAlertConstraintSide)side shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    // Start with default configs
    PIPassiveAlertConfig *alertConfig = [self defaultConfig];
    PIPassiveAlertAnimationConfig *animationConfig = [self defaultAnimationConfig];
    
    // Merge with delegate configs, if available
    if (delegate) {
        if ([delegate respondsToSelector:@selector(passiveAlertConfig)]) {
            PIPassiveAlertConfig *delegateAlertConfig = [delegate passiveAlertConfig];
            
            alertConfig = [PIPassiveAlertConfig mergeConfig:alertConfig withSecondConfig:delegateAlertConfig];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertAnimationConfig)]) {
            PIPassiveAlertAnimationConfig *delegateAnimationConfig = [delegate passiveAlertAnimationConfig];
            
            animationConfig = [PIPassiveAlertAnimationConfig mergeConfig:animationConfig withSecondConfig:delegateAnimationConfig];
        }
    }
    
    // Override with more specific values supplied
    alertConfig.side = side;
    alertConfig.shouldAutoHide = shouldAutoHide;
    
    return [[PIPassiveAlert alloc] initWithMessage:message config:alertConfig animationConfig:animationConfig delegate:delegate];
}

+ (UINib *)defaultNib {
    // Source: http://www.the-nerd.be/2015/08/07/load-assets-from-bundle-resources-in-cocoapods/
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURLForNib = [bundle URLForResource:kPIPassiveAlertResourceBundleName withExtension:@"bundle"];
    NSBundle *bundleForNib = [NSBundle bundleWithURL:bundleURLForNib];
    
    return [UINib nibWithNibName:kPIPassiveAlertDefaultNibName bundle:bundleForNib];
}

@end
