//
//  FixPipelineShader.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "FixPipelineShader.h"
#import "GLKit/GLKit.h"

@interface FixPipelineShader ()
@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@end

@implementation FixPipelineShader
- (id)init
{
    self = [super init];
    if (self) {
        self.baseEffect = [[GLKBaseEffect alloc] init];
    }
    return self;
}

- (void)prepareToDraw
{
    [self.baseEffect prepareToDraw];
}

- (void)setProjectionMatrix:(GLKMatrix4)projectionMatrix
{
    [super setProjectionMatrix:projectionMatrix];
    self.baseEffect.transform.projectionMatrix = self.projectionMatrix;
}

- (void)setViewMatrix:(GLKMatrix4)viewMatrix
{
    [super setViewMatrix:viewMatrix];
    self.baseEffect.transform.modelviewMatrix = self.viewMatrix;
    [self setupLights];
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix
{
    [super setModelViewMatrix:modelViewMatrix];
    self.baseEffect.transform.modelviewMatrix = self.modelViewMatrix;
}

- (void)setTexture1:(Texture *)texture1
{
    _texture1 = texture1;
    if (texture1 != nil)
    {
        self.baseEffect.texture2d0.enabled = GL_TRUE;
        self.baseEffect.texture2d0.name = texture1.textureInfo.name;
    } else {
        self.baseEffect.texture2d0.enabled = GL_FALSE;
    }
}

- (void)setTexture2:(Texture *)texture2
{
    _texture2 = texture2;
    if (texture2 != nil)
    {
        self.baseEffect.texture2d1.enabled = GL_TRUE;
        self.baseEffect.texture2d1.name = texture2.textureInfo.name;
    } else {
        self.baseEffect.texture2d1.enabled = GL_FALSE;
    }
}

- (void)setupLights
{
    GLKEffectPropertyLight *light = self.baseEffect.light0;
    light.enabled = YES;
    light.position = self.lightPosition;
//    light.ambientColor = kWhiteColor;
//    light.diffuseColor = kWhiteColor;
//    light.specularColor = kWhiteColor;
    
//    self.baseEffect.lightModelTwoSided = GL_TRUE;
//    self.baseEffect.lightingType = GLKLightingTypePerVertex;
    
}

@end
