//
//  TransitionEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "TransitionEffect.h"

@implementation TransitionEffect
- (void)update:(CFTimeInterval)duration
{
    self.elapseTime += duration;
}

- (float)progress
{
    return self.elapseTime/self.transitionDuration;
}

- (void)render:(CFTimeInterval)duration
{
    [self update:duration];
    [super render:duration];
}

@end
