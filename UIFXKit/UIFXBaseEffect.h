//
//  UIGLBaseEffect.h
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "Shader.h"
@interface UIFXBaseEffect : GLKBaseEffect
@property (nonatomic, strong) id<GLKNamedEffect> shader;
- (void)setSnapshot:(UIImage *)snapshot;

@end
