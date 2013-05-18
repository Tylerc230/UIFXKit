//
//  Plane.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/17/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "Plane.h"
@interface Plane ()
//Number of verts in the x
@property (nonatomic, assign) int nx;
//Number of verts in the y
@property (nonatomic, assign) int ny;

@end

@implementation Plane
- (id)initWithWidth:(float)width height:(float)height nx:(int)nx ny:(int)ny
{
    self = [super initWithSize:GLKVector3Make(width, height, 0.f)];
    if (self) {
        self.nx = nx;
        self.ny = ny;
    }
    return self;
}

- (NSUInteger)numVerticies
{
    return (self.nx * self.ny);
}

- (void)genIndicies:(NSUInteger)startInx
{
    [super genIndicies:startInx];
    for (int y = 0; y < self.ny - 1; y++) {
        for (int x = 0; x < self.nx - 1; x++) {
            int tl = startInx + (y * self.nx) + x;
            int tr = tl + 1;
            int bl = tl + self.nx;
            int br = bl + 1;
            [self addIndex:tl];
            [self addIndex:bl];
            [self addIndex:tr];
            
            [self addIndex:tr];
            [self addIndex:bl];
            [self addIndex:br];
        }
    }
}

- (void)updateVerticies:(Vertex *)vertexBuffer
{
    [super updateVerticies:vertexBuffer];
    float dx = self.size.x/(self.nx - 1);
    float dy = self.size.y/(self.ny - 1);
    float du = 1.f/(self.nx - 1);
    float dv = 1.f/(self.ny - 1);
    for (int y = 0; y < self.ny; y++)
    {
        for(int x = 0; x < self.nx; x++)
        {
            Vertex *vert = vertexBuffer + x + (y * self.nx);
            GLKVector3 pos = GLKVector3Make(x * dx - self.size.x/2, y * dy - self.size.y/2, 0.f);
            GLKVector3 norm = GLKVector3Make(0., 0., 1.f);
            GLKVector2 uv = GLKVector2Make(x * du, y * dv);
            *vert = CREATE_VERT(pos, norm, uv);
        }
    }
}
@end
