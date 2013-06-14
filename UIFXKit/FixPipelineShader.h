//
//  FixPipelineShader.h
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "Shader.h"
#import "Texture.h"

@interface FixPipelineShader : Shader
@property (nonatomic, strong) Texture *texture1;
@property (nonatomic, strong) Texture *texture2;
@property (nonatomic, assign) GLKVector4 lightPosition;
@end
