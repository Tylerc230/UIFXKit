//
//  TestEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "TestEffect.h"
#import "Texture.h"
@interface TestEffect ()
@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@end

@implementation TestEffect
- (id)init
{
    GLKBaseEffect *baseEffect = [GLKBaseEffect new];
    self = [super initWithShader:baseEffect];
    if (self) {
        self.transitionDuration = 2.f;
        self.baseEffect = baseEffect;
    }
    return self;
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix
{
    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
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

@end
