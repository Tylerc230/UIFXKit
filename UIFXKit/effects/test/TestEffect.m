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
#import "FixPipelineShader.h"

@interface TestEffect ()
@property (nonatomic, strong) FixPipelineShader *baseEffect;
@property (nonatomic, strong) Plane *plane;
@end

@implementation TestEffect
- (id)init
{
    FixPipelineShader *shader = [FixPipelineShader new];
    self = [super initWithShader:shader];
    if (self) {
        self.transitionDuration = 2.f;
        self.baseEffect = shader;
        self.plane = [[Plane alloc] initWithWidth:kScreenSize.width height:kScreenSize.height nx:2 ny:2];
        [self.graph addWorldObject:self.plane];
        [self updateVertexBuffer];
    }
    return self;
}

- (void)updateStateWithModel:(Model3D*)object
{
    [super updateStateWithModel:object];
    self.baseEffect.texture1 = self.sourceScreenshotTexture;
}

@end
