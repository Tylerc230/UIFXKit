//
//  UIGLBaseEffect.h
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "Shader.h"
#import "SceneGraph.h"
@interface UIFXBaseEffect : NSObject
@property (nonatomic, readonly) SceneGraph *graph;
- (id)initWithShader:(id<GLKNamedEffect>)shader;
- (void)setSnapshot:(UIImage *)snapshot;
- (void)render;
- (void)updateVertexBuffer;
@end
