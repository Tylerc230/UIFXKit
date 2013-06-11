//
//  VenetianEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "VenetianEffect.h"
#import "HorzStripPlane.h"
@interface VenetianEffect ()
@property (nonatomic, strong) GLKBaseEffect *shader;
@property (nonatomic, strong) HorzStripPlane *planeStrip;
@end

@implementation VenetianEffect
- (id)init
{
    GLKBaseEffect *shader = [[GLKBaseEffect alloc] init];
    self = [super initWithShader:shader];
    if (self) {
        self.shader = shader;
        self.planeStrip = [[HorzStripPlane alloc] initWithWidth:kScreenSize.width height:kScreenSize.height numStrips:3];
        [self.graph addWorldObject:self.planeStrip];
        [self updateVertexBuffer];
    }
    return self;
}

- (void)updateStateWithModel:(Model3D *)model
{
    [super updateStateWithModel:model];
    if (self.screenshotTexture != nil)
    {
        self.shader.texture2d0.enabled = GL_TRUE;
        self.shader.texture2d0.name = self.screenshotTexture.textureInfo.name;
    } else {
        self.shader.texture2d0.enabled = GL_FALSE;
    }
}

- (void)setProjectionMatrix:(GLKMatrix4)projectionMatrix
{
    self.shader.transform.projectionMatrix = projectionMatrix;
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix
{
    self.shader.transform.modelviewMatrix = modelViewMatrix;
}



@end
