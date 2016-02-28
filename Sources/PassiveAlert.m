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

@interface PassiveAlert ()

@end


@implementation PassiveAlert

#pragma mark - Class methods

+ (void)showMessage:(NSString *)message
   inViewController:(UIViewController *)vc
           delegate:(id<PassiveAlertDelegate>)delegate {
    [self showMessage:message inViewController:vc showType:PassiveAlertShowTypeTop shouldAutoHide:YES delegate:delegate];
}

+ (void)showMessage:(NSString *)message inViewController:(UIViewController *)vc showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide delegate:(id<PassiveAlertDelegate>)delegate {
    NSLog(@"Showing alert message for view controller: %@, showType: %i, shouldAutoHide: %i", message, showType, shouldAutoHide);
}

+ (void)showWindowMessage:(NSString *)message
                 delegate:(id<PassiveAlertDelegate>)delegate {
    NSLog(@"Showing alert message for window: %@", message);
}

+ (void)closeCurrentAlertAnimated:(BOOL)animated {
    NSLog(@"Closing alert; animated: %i", animated);
}

@end
