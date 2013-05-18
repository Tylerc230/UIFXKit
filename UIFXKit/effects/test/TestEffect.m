//
//  TestEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "TestEffect.h"
#import "Texture.h"
#import "Plane.h"
@interface TestEffect ()
@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, strong) Plane *plane;
@end

@implementation TestEffect
- (id)init
{
    GLKBaseEffect *baseEffect = [GLKBaseEffect new];
    self = [super initWithShader:baseEffect];
    if (self) {
        self.transitionDuration = 2.f;
        self.baseEffect = baseEffect;
        self.baseEffect.lightModelTwoSided = YES;
        self.baseEffect.constantColor = GLKVector4Make(1., 1., 1., 1.);
        self.baseEffect.useConstantColor = YES;
        self.plane = [[Plane alloc] initWithWidth:100.f height:100.f nx:2 ny:2];
        [self.graph addWorldObject:self.plane];
        [self updateVertexBuffer];
    }
    return self;
}

- (void)setCurrentTexture:(Texture *)texture
{
    if (texture != nil) {
        self.baseEffect.texture2d0.enabled = GL_TRUE;
        self.baseEffect.texture2d0.name = texture.textureInfo.name;
        self.baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    } else {
        self.baseEffect.texture2d0.enabled = GL_FALSE;
    }
}
- (void)setProjectionMatrix:(GLKMatrix4)projectionMatrix
{
    self.baseEffect.transform.projectionMatrix = projectionMatrix;
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix
{
    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
}

@end
