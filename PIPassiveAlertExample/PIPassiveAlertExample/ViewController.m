//
//  ViewController.m
//  PIPassiveAlertExample
//
//  Created by Harlan Kellaway on 2/28/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

#import "PIPassiveAlert.h"
#import "ViewController.h"

@interface ViewController () <PassiveAlertDelegate>

@property (nonatomic, assign) int alertCount;

@end

@implementation ViewController

#pragma mark - Protocol conformance

#pragma mark PassiveAlertDelegate

- (void)passiveAlertDidReceiveTapAction:(PassiveAlert *)passiveAlert {
    self.alertCount++;
    
    [PassiveAlert showMessage:[self message] inViewController:self showType:PassiveAlertShowTypeBottom shouldAutoHide:YES delegate:self];
}

- (CGFloat)passiveAlertAutoHideDelay {
    return 0.5f;
}

- (UIColor *)passiveAlertBackgroundColor {
    if ((self.alertCount % 2) == 0) {
        return [PassiveAlert defaultBackgroundColor];
    } else {
        return [self randomColor];
    }
}

- (UIFont *)passiveAlertFont {
    return [UIFont systemFontOfSize:22.f];
}

#pragma mark - Instance functions

- (NSString *)message {
    return [NSString stringWithFormat:@"Tap me! Alert #%i", self.alertCount];
}

- (UIColor *)randomColor {
    // Random color gist: https://gist.github.com/kylefox/1689973
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark IB Actions

- (IBAction)didTapButton:(id)sender {
    self.alertCount++;
    
    [PassiveAlert showMessage:[self message] inViewController:self showType:PassiveAlertShowTypeTop shouldAutoHide:NO delegate:self];
}

@end
