//
//  UIGLBaseEffect.m
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "UIFXBaseEffect.h"
@interface UIFXBaseEffect ()
@property (nonatomic, strong) id<GLKNamedEffect> shader;
@end

@implementation UIFXBaseEffect
- (id)initWithShader:(id<GLKNamedEffect>)shader;
{
    self = [super init];
    if (self) {
        self.shader = shader;
    }
    return self;
}

- (void)setSnapshot:(UIImage *)snapshot
{
    
}

- (void)render
{
    [self.shader prepareToDraw];
//    glDrawElements(GL_TRIANGLES, faces_count[0] * 3, INX_TYPE, 0);
}

@end
