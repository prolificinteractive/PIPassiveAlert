//
//  ViewController.m
//  PIPassiveAlertExample
//
//  Created by Harlan Kellaway on 2/28/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

#import "PIPassiveAlertDisplayer.h"
#import "ViewController.h"

@interface ViewController () <PIPassiveAlertDelegate>

@property (nonatomic, assign) int alertCount;

@end

@implementation ViewController

#pragma mark - Protocol conformance

#pragma mark PassiveAlertDelegate

- (void)passiveAlertDidReceiveTap:(PIPassiveAlert *)passiveAlert {
    self.alertCount++;
    
    [PIPassiveAlertDisplayer displayMessage:[self message] inViewController:self showType:PIPassiveAlertShowTypeBottom shouldAutoHide:YES delegate:self];
}

- (PIPassiveAlertConfig *)passiveAlertConfig {
    PIPassiveAlertConfig *config = [PIPassiveAlertConfig config];
    
    config.autoHideDelay = 1.f;
    config.height = 70.f;
    config.backgroundColor = [self passiveAlertBackgroundColor];
    config.font = [UIFont systemFontOfSize:22.f];
    
    return config;
}

#pragma mark - Private functions

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

- (UIColor *)passiveAlertBackgroundColor {
    if ((self.alertCount % 2) == 0) {
        return [PIPassiveAlertDisplayer defaultConfig].backgroundColor;
    } else {
        return [self randomColor];
    }
}

#pragma mark IB Actions

- (IBAction)didTapButton:(id)sender {
    self.alertCount++;
    
    [PIPassiveAlertDisplayer displayMessage:[self message] inViewController:self showType:PIPassiveAlertShowTypeTop shouldAutoHide:NO delegate:self];
}

@end
