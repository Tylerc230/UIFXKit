//
//  FireEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/26/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "FireEffect.h"
#import "Plane.h"

#define kFireProgressName @"uFireProgress"
#define kBurnMapName @"uBurnMapTexture"

@interface FireEffect ()
@property (nonatomic, strong) CustomShader *shader;
@property (nonatomic, strong) Plane *plane;
@property (nonatomic, strong) Texture *burnMapTexture;
@end
@implementation FireEffect

- (id)init
{
    CustomShader *shader = [[CustomShader alloc] initWithVertexShader:@"fire_shader.vert" fragmentShader:@"fire_shader.frag"];
    self = [super initWithShader:shader];
    if (self) {
        self.transitionDuration = 4.f;
        self.shader = shader;
        [self.shader bindUniformName:kFireProgressName];
        [self.shader bindUniformName:kBurnMapName];
        self.plane = [[Plane alloc] initWithWidth:kScreenSize.width height:kScreenSize.height nx:2 ny:2];
        self.burnMapTexture = [[Texture alloc] initWithFile:@"burn_map"];
        [self.graph addWorldObject:self.plane];
        [self updateVertexBuffer];
    }
    return self;
}

- (void)preRenderSetup
{
    [super preRenderSetup];
    [self.shader set:kFireProgressName toFloat:self.progress];
    GLKMatrix4 modelViewProjectionMatrix = GLKMatrix4Multiply(self.shader.projectionMatrix, self.shader.modelViewMatrix);
    [self.shader set:kGLSLModelViewProjectionMatrixName toGLKMatrix4:modelViewProjectionMatrix];
    if (self.sourceScreenshotTexture) {
        [self.shader useTexture:self.sourceScreenshotTexture atLocation:GL_TEXTURE0 forName:kGLSLTextureName];
    }
    if (self.burnMapTexture) {
        [self.shader useTexture:self.burnMapTexture atLocation:GL_TEXTURE1 forName:kBurnMapName];
    }
}

@end
