//
//  Texture.h
//  bestbuy_catalog_v4
//
//  Created by Tyler Casselman on 7/19/12.
//  Copyright (c) 2012 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
/*
 * Encapsulates information about a texture. Responsible for loading texture info
 * into a gl context. Also supports non power of 2 textures.
 */
@interface Texture : NSObject
@property (nonatomic, strong) GLKTextureInfo *textureInfo;
//Should be set to the size of the texture you want to render
//allows you to place non POT images into a POT texture
@property (nonatomic, assign) CGSize textureSize;
- (id)initWithImage:(UIImage *)image size:(CGSize)size;
- (id)initWithFile:(NSString *)filename;
//This is the texture coordinates of the non POT image embedded into the POT texture
- (GLKVector2)scaledTextureCoordinates;
@end
