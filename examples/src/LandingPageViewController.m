//
//  LandingPageViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "LandingPageViewController.h"
#import "UIFXWindow.h"
#import "TestEffect.h"
#import "RippleEffect.h"

#define kTestSegueId @"TestSegue"
#define kRippleSegueId @"RippleSegue"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if ([segue.identifier isEqualToString:kTestSegueId])
    {
        [UIFXWindow keyWindow].effect = [TestEffect new];
    } else if ([segue.identifier isEqualToString:kRippleSegueId])
    {
        RippleEffect *rippleEffect = [RippleEffect new];
        [UIFXWindow keyWindow].effect = rippleEffect;
        rippleEffect.rippleOrigin = [[UIFXWindow keyWindow] convertPoint:sender.center fromView:self.view];
    }
}
@end
