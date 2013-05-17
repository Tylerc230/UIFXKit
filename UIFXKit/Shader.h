//
//  GLSLProgram.h
//  ShaderTutorials
//
//  Created by Tyler Casselman on 7/24/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
typedef enum
{
    VERTEX,
    FRAGMENT,
    GEOMETRY,
    TESS_CONTROL,
    TESS_EVALUATION
}GLSLShaderType;

@interface Shader : NSObject<GLKNamedEffect>
@property (nonatomic, readonly) int handle;
@property (nonatomic, readonly) BOOL isLinked;
@property (nonatomic, strong, readonly) NSString *log;
- (void)compileShaderFromFile:(NSString *)fileName type:(GLSLShaderType)type;
- (void)compileShaderFromString:(NSString *)srcString type:(GLSLShaderType)type;
- (void)bindAttribLocation:(GLuint) location name:(NSString *)name;
- (void)bindUniformName:(NSString *)name;

- (void)set:(NSString *)uniformName toGLKMatrix4:(GLKMatrix4)matrix4;
- (void)set:(NSString *)uniformName toGLKMatrix3:(GLKMatrix3)matrix3;
- (void)set:(NSString *)uniformName toFloat:(float)floatValue;
- (void)set:(NSString *)uniformName toGLKVector2:(GLKVector2)vector2;
- (void)set:(NSString *)uniformName toGLKVector3:(GLKVector3)vector3;
- (void)set:(NSString *)uniformName toGLKVector4:(GLKVector4)vector4;
- (BOOL)create;
- (BOOL)link;
- (void)use;
- (void)destroy;
@end
