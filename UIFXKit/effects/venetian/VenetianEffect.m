//
//  VenetianEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "VenetianEffect.h"
#import "HorzStripPlane.h"
#import "FixPipelineShader.h"

@interface VenetianEffect ()
@property (nonatomic, strong) FixPipelineShader *shader;
@property (nonatomic, strong) HorzStripPlane *planeStrip;
@end

@implementation VenetianEffect
- (id)init
{
    FixPipelineShader *shader = [[FixPipelineShader alloc] init];
    self = [super initWithShader:shader];
    if (self) {
        self.shader = shader;
    }
    return self;
}

- (void)setViewSize:(GLKVector2)viewSize
{
    [super setViewSize:viewSize];
    self.planeStrip = [[HorzStripPlane alloc] initWithWidth:viewSize.x height:viewSize.y numStrips:3];
    [self.graph addWorldObject:self.planeStrip];
    [self updateVertexBuffer];
}

- (void)preRenderSetup
{
    [super preRenderSetup];
    for (Model3D *strip in self.planeStrip.subObjects) {
        strip.rotation = GLKVector3Make(M_PI * self.progress, 0.f, 0.f);
    }
}

- (void)updateStateWithModel:(Model3D *)model
{
    [super updateStateWithModel:model];
    self.shader.texture1 = model.texture;
}

@end
