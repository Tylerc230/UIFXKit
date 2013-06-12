//
//  DoubleSidedPlane.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/12/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "DoubleSidedPlane.h"
#import "Plane.h"

@implementation DoubleSidedPlane
- (id)initWithWidth:(float)width height:(float)height nx:(int)nx ny:(int)ny
{
    self = [super initWithSize:GLKVector3Make(width, height, 0.f)];
    if (self) {
        Plane *front = [[Plane alloc] initWithWidth:width height:height nx:nx ny:ny];
        front.position = GLKVector3Make(0.f, 0.f, .1f);
        [self addSubObject:front];
        
        Plane *back = [[Plane alloc] initWithWidth:width height:height nx:nx ny:ny];
        [self addSubObject:back];
        
    }
    return self;
}

- (void)setUvMap:(UVMap *)uvMap
{
    [super setUvMap:uvMap];
    for (Model3D *subobject in self.subObjects) {
        subobject.uvMap = uvMap;
    }
}
@end
