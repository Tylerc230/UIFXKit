//
//  StripPlane.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "HorzStripPlane.h"
#import "DoubleSidedPlane.h"

@interface HorzStripPlane ()

@end

@implementation HorzStripPlane
- (id)initWithWidth:(float)width height:(float)height numStrips:(int)numStrips
{
    self = [super initWithSize:GLKVector3Make(width, height, 0.f)];
    if (self) {
        float stripH = height/numStrips;
        float dV = 1.f/numStrips;
        for (int i = 0; i < numStrips; i++) {
            DoubleSidedPlane *strip = [[DoubleSidedPlane alloc] initWithWidth:width height:stripH nx:2 ny:2];
            strip.position = GLKVector3Make(0.f, i * stripH, 0.f);
            strip.anchorPoint = GLKVector3Make(0.f, stripH/2, 0.f);
            float v0 =  1.f - i * dV;
            strip.uvMap = [[UVMap alloc] initWithU0:0.f u1:1.f v0:v0 v1:v0 - dV];
            [self addSubObject:strip];
        }
    }
    return self;
}

- (void)setFrontTexture:(Texture *)frontTexture
{
    for (DoubleSidedPlane *strip in self.subObjects) {
        strip.frontTexture = frontTexture;
    }
}

- (void)setBackTexture:(Texture *)backTexture
{
    for (DoubleSidedPlane *strip in self.subObjects) {
        strip.backTexture = backTexture;
    }
}

@end
