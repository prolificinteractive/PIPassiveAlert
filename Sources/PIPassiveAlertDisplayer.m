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
    [self displayMessage:message inViewController:vc showType:PIPassiveAlertShowTypeTop shouldAutoHide:YES delegate:delegate];
}

+ (void)displayMessage:(NSString *)message inViewController:(UIViewController *)vc showType:(PIPassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    PIPassiveAlert *alert = [self alertWithMessage:message inViewController:vc showType:showType shouldAutoHide:shouldAutoHide delegate:delegate];
    CGFloat originY = [self originYForPassiveAlert:alert inViewController:vc];
    
    [self displayAlert:alert inViewController:vc originY:originY];
}

+ (void)displayMessage:(NSString *)message inViewController:(UIViewController *)vc originY:(CGFloat)originY shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    PIPassiveAlert *alert = [self alertWithMessage:message inViewController:vc showType:PIPassiveAlertShowTypeCustomOrigin shouldAutoHide:shouldAutoHide delegate:delegate];
    
    [self displayAlert:alert inViewController:vc originY:originY];
}

+ (void)closeCurrentAlertAnimated:(BOOL)animated {
    if (currentAlert) {
        [currentAlert closeAnimated:animated];
    }
}

+ (PIPassiveAlertConfig *)defaultConfig {
    PIPassiveAlertConfig *defaultConfig = [[PIPassiveAlertConfig alloc] init];
    
    defaultConfig.nib = [self defaultNib];
    defaultConfig.showType = PIPassiveAlertShowTypeTop;
    defaultConfig.shouldAutoHide = YES;
    defaultConfig.autoHideDelay = 3.f;
    defaultConfig.backgroundColor = [UIColor redColor];
    defaultConfig.textColor = [UIColor whiteColor];
    defaultConfig.font = [UIFont systemFontOfSize:17.f]; // default Apple body text size
    defaultConfig.textAlignment = NSTextAlignmentCenter;
    
    return defaultConfig;
}

#pragma mark Private class methods

+ (void)displayAlert:(PIPassiveAlert *)alert inViewController:(UIViewController *)vc originY:(CGFloat)originY {
    if (currentAlert) {
        [currentAlert closeAnimated:YES];
        currentAlert = nil;
    }
    
    currentAlert = alert;
    
    [alert showInViewController:vc originY:originY];
}

+ (PIPassiveAlert *)alertWithMessage:(NSString *)message inViewController:(UIViewController *)vc showType:(PIPassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PIPassiveAlertDelegate>)delegate {
    PIPassiveAlertConfig *config = [PIPassiveAlertConfig mergeConfig:[self defaultConfig] withSecondConfig:[delegate passiveAlertConfig]];
    
    config.showType = showType;
    config.shouldAutoHide = shouldAutoHide;
    
    return [[PIPassiveAlert alloc] initWithMessage:message config:config delegate:delegate];
}

+ (CGFloat)originYForPassiveAlert:(PIPassiveAlert *)alert inViewController:(UIViewController *)vc
{
    switch (alert.showType) {
        case PIPassiveAlertShowTypeTop:
            return 0.f;
            break;
            
        case PIPassiveAlertShowTypeBottom:
            return vc.view.bounds.size.height - alert.height;
            break;
            
        case PIPassiveAlertShowTypeNavigationBar:
            return (vc.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
            break;
            
        case PIPassiveAlertShowTypeCustomOrigin:
            NSAssert(NO, @"Should not re-calculate origin for alert with custom origin.");
            return 0.f;
            break;
            
        default:
            return 0.f;
            break;
    }
}

+ (UINib *)defaultNib {
    // Source: http://www.the-nerd.be/2015/08/07/load-assets-from-bundle-resources-in-cocoapods/
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURLForNib = [bundle URLForResource:kPIPassiveAlertResourceBundleName withExtension:@"bundle"];
    NSBundle *bundleForNib = [NSBundle bundleWithURL:bundleURLForNib];
    
    return [UINib nibWithNibName:kPIPassiveAlertDefaultNibName bundle:bundleForNib];
}

@end
