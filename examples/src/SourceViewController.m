//
//  SourceViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "SourceViewController.h"
#import "RippleEffect.h"
#import "UIFXWindow.h"

@interface SourceViewController ()

@end

@implementation SourceViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    [[UIFXWindow keyWindow] setEffect:self.transitionEffect];
    if ([self.transitionEffect isMemberOfClass:[RippleEffect class]])
    {
        RippleEffect *rippleEffect = (RippleEffect *)self.transitionEffect;
        rippleEffect.rippleOrigin = [[UIFXWindow keyWindow] convertPoint:sender.center fromView:self.view];
    }
}
@end
