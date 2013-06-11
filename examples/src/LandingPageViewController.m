//
//  LandingPageViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "LandingPageViewController.h"
#import "SourceViewController.h"
#import "ContinuousEffectViewController.h"

#import "FireEffect.h"
#import "RippleEffect.h"
#import "VenetianEffect.h"

#define kFireSegueId @"FireSegue"
#define kRippleSegueId @"RippleSegue"
#define kVenetianSegueId @"VenetianSegue"


@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    if ([segue.identifier isEqualToString:kFireSegueId])
    {
        SourceViewController *dest = segue.destinationViewController;
        dest.transitionEffect = [FireEffect new];
    } else if ([segue.identifier isEqualToString:kRippleSegueId])
    {
        SourceViewController *dest = segue.destinationViewController;
        dest.transitionEffect = [RippleEffect new];
    } else if ([segue.identifier isEqualToString:kVenetianSegueId])
    {
        ContinuousEffectViewController *dest = segue.destinationViewController;
        dest.effect = [VenetianEffect new];
    }
}
@end
