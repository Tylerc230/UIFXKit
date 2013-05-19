//
//  RippleEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "RippleEffect.h"
#import "Shader.h"
#import "Plane.h"

@interface RippleEffect ()
@property (nonatomic, strong) Shader *rippleShader;
@property (nonatomic, strong) Plane *plane;
@end

@implementation RippleEffect

- (id)init
{
    Shader *shader = [[Shader alloc] initWithVertexShader:@"ripple_shader.vert" fragmentShader:@"ripple_shader.frag"];
    self = [super initWithShader:shader];
    if (self) {
        self.transitionDuration = 2.f;
        self.rippleShader = shader;
        self.plane = [[Plane alloc] initWithWidth:kScreenSize.width height:kScreenSize.height nx:2 ny:2];
        [self.graph addWorldObject:self.plane];
        [self updateVertexBuffer];

    }
    return self;
}

- (void)updateStateWithModel:(Model3D*)object
{
    [super updateStateWithModel:object];
    if (self.currentTexture != nil) {
        [self.rippleShader useTexture:self.currentTexture];
    }
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix
{
    [self.rippleShader set:kGLSLModelViewMatrixName toGLKMatrix4:modelViewMatrix];
    GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(self.projectionMatrix, modelViewMatrix);
    [self.rippleShader set:kGLSLModelViewProjectionMatrixName toGLKMatrix4:modelViewProjectionMatrix];
}

@end
