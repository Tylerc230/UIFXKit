//
//  LandingPageViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "LandingPageViewController.h"
#import "SourceViewController.h"

#import "FireEffect.h"
#import "RippleEffect.h"

#define kFireSegueId @"FireSegue"
#define kRippleSegueId @"RippleSegue"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    SourceViewController *dest = segue.destinationViewController;
    if ([segue.identifier isEqualToString:kFireSegueId])
    {
        dest.transitionEffect = [FireEffect new];
    } else if ([segue.identifier isEqualToString:kRippleSegueId])
    {
        dest.transitionEffect = [RippleEffect new];
    }
}
@end
