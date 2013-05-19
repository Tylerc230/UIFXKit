//
//  RippleEffect.m
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "RippleEffect.h"
#import "Shader.h"
@interface RippleEffect ()
@property (nonatomic, strong) Shader *rippleShader;
@end

@implementation RippleEffect

- (id)init
{
    Shader *shader = [[Shader alloc] initWithVertexShader:@"ripple_shader.vert" fragmentShader:@"ripple_shader.frag"];
    self = [super initWithShader:shader];
    if (self) {
        self.rippleShader = shader;
    }
    return self;
}

@end
