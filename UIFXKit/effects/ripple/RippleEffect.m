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

#define kRippleOriginName @"uRippleOrigin"
#define kRippleRadiusName @"uRippleRadius"

#define kMaxRadius 500.f

@interface RippleEffect ()
@property (nonatomic, strong) Shader *shader;
@property (nonatomic, strong) Plane *plane;
@property (nonatomic, assign) float rippleRadius;
@end

@implementation RippleEffect

- (id)init
{
    Shader *shader = [[Shader alloc] initWithVertexShader:@"ripple_shader.vert" fragmentShader:@"ripple_shader.frag"];
    self = [super initWithShader:shader];
    if (self) {
        self.transitionDuration = 4.f;
        self.shader = shader;
        [self.shader bindUniformName:kRippleOriginName];
        [self.shader bindUniformName:kRippleRadiusName];
        self.plane = [[Plane alloc] initWithWidth:kScreenSize.width height:kScreenSize.height nx:2 ny:2];
        [self.graph addWorldObject:self.plane];
        [self updateVertexBuffer];

    }
    return self;
}

- (void)preRenderSetup
{
    [super preRenderSetup];
    [self.shader set:kRippleRadiusName toFloat:self.rippleRadius];
    [self.shader set:kRippleOriginName toGLKVector3:GLKVector3Make(self.rippleOrigin.x, self.rippleOrigin.y, 0.f)];
//    [self.shader set:kGLSLModelViewMatrixName toGLKMatrix4:self.modelViewMatrix];
    GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(self.projectionMatrix, self.modelViewMatrix);
    [self.shader set:kGLSLModelViewProjectionMatrixName toGLKMatrix4:modelViewProjectionMatrix];
    if (self.screenshotTexture != nil) {
        [self.shader useTexture:self.screenshotTexture atLocation:GL_TEXTURE0 forName:kGLSLTextureName];
    }
}

- (void)update:(CFTimeInterval)duration
{
    [super update:duration];
    float percentComplete = self.progress;
    self.rippleRadius = percentComplete * kMaxRadius;
}
@end
