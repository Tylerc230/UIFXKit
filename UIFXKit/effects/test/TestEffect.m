//
//  TestEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "TestEffect.h"

@implementation TestEffect
- (id)init
{
    self = [super initWithShader:[GLKBaseEffect new]];
    if (self) {
        self.transitionDuration = 2.f;
    }
    return self;
}
@end
