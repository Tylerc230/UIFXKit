//
//  DoubleSidedPlane.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/12/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "DoubleSidedPlane.h"
#import "Plane.h"

@interface DoubleSidedPlane ()
@property (nonatomic, strong) Plane *front;
@property (nonatomic, strong) Plane *back;
@end

@implementation DoubleSidedPlane
- (id)initWithWidth:(float)width height:(float)height nx:(int)nx ny:(int)ny
{
    self = [super initWithSize:GLKVector3Make(width, height, 0.f)];
    if (self) {
        self.front = [[Plane alloc] initWithWidth:width height:height nx:nx ny:ny];
        [self addSubObject:self.front];
        
        self.back = [[Plane alloc] initWithWidth:width height:height nx:nx ny:ny];
        self.back.anchorPoint = GLKVector3Make(0.f, height/2, 0.f);
        self.back.position = GLKVector3Make(0.f, 0.f, 1.f);//Since z points away from the camera in our setup
        self.back.rotation = GLKVector3Make(M_PI, 0.f, 0.f);
        [self addSubObject:self.back];
        
    }
    return self;
}

- (void)setUvMap:(UVMap *)uvMap
{
    [super setUvMap:uvMap];
    self.front.uvMap = uvMap;
    self.back.uvMap = uvMap;
}

- (void)setFrontTexture:(Texture *)frontTexture
{
    _frontTexture = frontTexture;
    self.front.texture = frontTexture;
}

- (void)setBackTexture:(Texture *)backTexture
{
    _backTexture = backTexture;
    self.back.texture = backTexture;
    
}

@end
