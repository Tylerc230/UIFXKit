//
//  StripPlane.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "HorzStripPlane.h"
#import "Plane.h"

@interface HorzStripPlane ()

@end

@implementation HorzStripPlane
- (id)initWithWidth:(float)width height:(float)height numStrips:(int)numStrips
{
    self = [super initWithSize:GLKVector3Make(width, height, 0.f)];
    if (self) {
        float stripH = height/numStrips;
        for (int i = 0; i < numStrips; i++) {
            Plane *strip = [[Plane alloc] initWithWidth:width height:stripH nx:2 ny:2];
            strip.position = GLKVector3Make(0.f, i * stripH, 0.f);
            [self addSubObject:strip];
        }
    }
    return self;
}

@end
