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
    self.shader.texture1 = self.sourceScreenshotTexture;
    self.shader.texture2 = self.destScreenshotTexture;
}

@end
