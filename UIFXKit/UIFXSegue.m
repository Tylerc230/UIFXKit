//
//  UIFXSegue.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "UIFXSegue.h"
#import "UIFXWindow.h"
#import "TransitionEffect.h"
@implementation UIFXSegue
- (void)perform
{
    TransitionEffect *effect = (TransitionEffect *)[UIFXWindow keyWindow].effect;
    [[UIFXWindow keyWindow] startTransition:^{
        UINavigationController *nav = [self.sourceViewController navigationController];
        [nav pushViewController:self.destinationViewController animated:NO];
        [NSTimer scheduledTimerWithTimeInterval:effect.transitionDuration target:self selector:@selector(endSegue) userInfo:nil repeats:NO];
    }];
}

- (void)endSegue
{
    [[UIFXWindow keyWindow] endTransition];
}
@end
