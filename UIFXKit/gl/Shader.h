//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
#import "Texture.h"

#define kGLSLModelViewMatrixName @"uModelViewMatrix"
#define kGLSLModelViewProjectionMatrixName @"uModelViewProjectionMatrix"
#define kGLSLNormalMatrixName @"uNormalMatrix"

#define kGLSLPositionName @"aVertPosition"
#define kGLSLNormalName @"aVertNormal"
#define kGLSLTextureCoordName @"aVertTextureCoords"

#define kGLSLTextureName @"uTexture"

typedef enum
{
    VERTEX,
    FRAGMENT,
    GEOMETRY,
    TESS_CONTROL,
    TESS_EVALUATION
}GLSLShaderType;

@interface Shader : NSObject<GLKNamedEffect>
- (id)initWithVertexShader:(NSString *)vertexShaderFile fragmentShader:(NSString *)fragmentShaderFile;
- (void)bindAttribLocation:(GLuint) location name:(NSString *)name;
- (void)bindUniformName:(NSString *)name;
- (void)useTexture:(Texture *)texture;
- (void)set:(NSString *)uniformName toGLKMatrix4:(GLKMatrix4)matrix4;
- (void)set:(NSString *)uniformName toGLKMatrix3:(GLKMatrix3)matrix3;
- (void)set:(NSString *)uniformName toFloat:(float)floatValue;
- (void)set:(NSString *)uniformName toGLKVector2:(GLKVector2)vector2;
- (void)set:(NSString *)uniformName toGLKVector3:(GLKVector3)vector3;
- (void)set:(NSString *)uniformName toGLKVector4:(GLKVector4)vector4;
@end
