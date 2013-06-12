//
//  UIGLBaseEffect.h
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "CustomShader.h"
#import "SceneGraph.h"
#import "Texture.h"
@interface UIFXBaseEffect : NSObject
@property (nonatomic, readonly) SceneGraph *graph;
@property (nonatomic, strong) Texture *sourceScreenshotTexture;
@property (nonatomic, strong) Texture *destScreenshotTexture;
@property (nonatomic, assign) float progress;

- (id)initWithShader:(Shader *)shader;
- (void)setSourceSnapshot:(UIImage *)snapshot;
- (void)setDestSnapshot:(UIImage *)snapshot;
- (void)preRenderSetup;
- (void)render:(CFTimeInterval)duration;
- (void)updateVertexBuffer;
- (void)setupGLState;
- (void)updateStateWithModel:(Model3D*)model;
@end
