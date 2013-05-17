//
//  Texture.m
//  bestbuy_catalog_v4
//
//  Created by Tyler Casselman on 7/19/12.
//  Copyright (c) 2012 Sequence. All rights reserved.
//

#import "Texture.h"

@implementation Texture
@synthesize textureInfo;
@synthesize textureSize;

- (id)initWithFile:(NSString *)filename
{
    GLKTextureInfo *newTexture = nil;
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
        NSError *error = nil;
        newTexture = [GLKTextureLoader textureWithContentsOfFile:filePath options:
                      [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] 
                                                  forKey:GLKTextureLoaderOriginBottomLeft]  error:&error];
        NSAssert(error == nil, @"glError: (%d) Failed to load texture %@",glGetError(), error);
        self.textureInfo = newTexture;
        self.textureSize = CGSizeMake(self.textureInfo.width, self.textureInfo.height);
    }
    return self;

}

- (void)dealloc
{
    GLuint name = self.textureInfo.name;
    glDeleteTextures(1, &name);
}

- (id)initWithImage:(UIImage *)image size:(CGSize)size
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        GLKTextureInfo *newTexture = [GLKTextureLoader textureWithCGImage:image.CGImage options:
                                      [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]  forKey:GLKTextureLoaderOriginBottomLeft] 
                                                                    error:&error];
        NSAssert(error == nil, @"glError: (%d) Failed to load texture %@",glGetError(), error);
        self.textureInfo = newTexture;
        self.textureSize = size;
    }
    return self;
}

- (GLKVector2)scaledTextureCoordinates
{
    return GLKVector2Make(self.textureSize.width/self.textureInfo.width, self.textureSize.height/self.textureInfo.height);
}



@end
