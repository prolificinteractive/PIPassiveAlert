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

#pragma mark IB Actions

- (IBAction)didTapButton:(id)sender {
    self.alertCount++;
    
    [PIPassiveAlertDisplayer displayMessage:[self message] inViewController:self showType:PIPassiveAlertShowTypeTop shouldAutoHide:YES delegate:self];
}

#pragma mark - Protocol conformance

#pragma mark PassiveAlertDelegate

- (void)passiveAlertDidReceiveTap:(PIPassiveAlert *)passiveAlert {
    self.alertCount++;
    
    // Custom alert - displays at random origin
    PIPassiveAlertDisplayType *randomOriginDisplayType = [[PIPassiveAlertDisplayType alloc] initWithOrientation:PIPassiveAlertDisplayOrientationFromTop originYCalculation:^CGFloat(PIPassiveAlert *alert, UIViewController *displayingViewController) {
        
        return [self randomNumberBetween:0 maxNumber:displayingViewController.view.bounds.size.height];
    }];
    
    [PIPassiveAlertDisplayer displayMessage:@"Random" inViewController:self displayType:randomOriginDisplayType shouldAutoHide:NO delegate:self];
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

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min);
}

- (UIColor *)passiveAlertBackgroundColor {
    if ((self.alertCount % 2) == 0) {
        return [PIPassiveAlertDisplayer defaultConfig].backgroundColor;
    } else {
        return [self randomColor];
    }
}

@end
