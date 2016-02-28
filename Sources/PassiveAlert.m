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
    
    CGFloat height = [self defaultHeight];
    UIFont *font = [self defaultFont];
    NSTextAlignment textAlignment = [self defaultTextAlignment];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(passiveAlertHeight)]) {
            height = [delegate passiveAlertHeight];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertFont)]) {
            font = [delegate passiveAlertFont];
        }
        
        if ([delegate respondsToSelector:@selector(passiveAlertTextAlignment)]) {
            textAlignment = [delegate passiveAlertTextAlignment];
        }
    }
    
    NSLog(@"Showing alert message for view controller: %@, height:%f, showType: %li, shouldAutoHide: %i, font: (%@, %f), text alignment: %li", message, height, (long)showType, shouldAutoHide, font.fontName, font.pointSize, (long)textAlignment);
    
    PassiveAlert *alert = [[PassiveAlert alloc] initWithMessage:message height:height showType:showType shouldAutoHide:shouldAutoHide font:font textAlignment:textAlignment delegate:delegate];
    
    [alert showInViewController:vc];
}

+ (void)showWindowMessage:(NSString *)message
                 delegate:(id<PassiveAlertDelegate>)delegate {
    NSLog(@"Showing alert message for window: %@", message);
}

+ (void)closeCurrentAlertAnimated:(BOOL)animated {
    NSLog(@"Closing alert; animated: %i", animated);
}

+ (CGFloat)defaultHeight {
    return 115.f;
}

+ (UIFont *)defaultFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.f];
}

+ (NSTextAlignment)defaultTextAlignment {
    return NSTextAlignmentCenter;
}

#pragma mark - Initialization

- (instancetype)initWithMessage:(NSString *)message height:(CGFloat)height showType:(PassiveAlertShowType)showType shouldAutoHide:(BOOL)shouldAutoHide font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment delegate:(id<PassiveAlertDelegate>)delegate {
    self = [super init];
    
    if (self) {
        self.message = message;
        self.height = height;
        self.showType = showType;
        self.shouldAutoHide = shouldAutoHide;
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
    
//    [self showInView:vc.view origin:origin];
}

#pragma mark Private instance methods

- (CGFloat)originForPassiveAlertOfShowType:(PassiveAlertShowType)showType inViewController:(UIViewController *)vc
{
    CGFloat yOrigin = 0.f;
    
    switch (showType) {
        case PassiveAlertShowTypeTop:
            yOrigin = 0.f;
            break;
            
        case PassiveAlertShowTypeBottom:
            yOrigin = vc.view.bounds.size.height - self.height;
            break;
            
        case PassiveAlertShowTypeNavigationBar:
            yOrigin = (vc.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
            break;
            
        default:
            break;
    }
    
    return yOrigin;
}

@end
