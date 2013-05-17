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
#define kTestSegueId @"TestSegue"
@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kTestSegueId])
    {
        [UIFXWindow keyWindow].effect = [TestEffect new];
    }
}
@end
