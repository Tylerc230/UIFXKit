//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "CustomShader.h"

@interface CustomShader ()
@property (nonatomic, assign) int handle;
@property (nonatomic, assign) BOOL isLinked;
@property (nonatomic, strong, readwrite) NSString *log;
@property (nonatomic, strong) NSMutableDictionary *uniforms;
@property (nonatomic, strong) NSMutableDictionary *textures;
@end

@implementation CustomShader
- (id)initWithVertexShader:(NSString *)vertexShaderFile fragmentShader:(NSString *)fragmentShaderFile
{
    self = [super init];
    if (self) {
        self.uniforms = [NSMutableDictionary dictionaryWithCapacity:10];
        self.textures = [NSMutableDictionary dictionaryWithCapacity:10];
        [self create];
        [self compileShaderFromFile:vertexShaderFile type:VERTEX];
        [self compileShaderFromFile:fragmentShaderFile type:FRAGMENT];
        [self bindAttribLocation:GLKVertexAttribPosition name:kGLSLPositionName];
        [self bindAttribLocation:GLKVertexAttribNormal name:kGLSLNormalName];
        [self bindAttribLocation:GLKVertexAttribTexCoord0 name:kGLSLTextureCoordName];
        [self link];
        if (![self validateProgram:self.handle]) {
            [self exit];
        }
        [self bindUniformName:kGLSLModelViewProjectionMatrixName];
        [self bindUniformName:kGLSLModelViewMatrixName];
        [self bindUniformName:kGLSLNormalMatrixName];
        [self bindUniformName:kGLSLTextureName];

    }
    return self;
}

- (void)useTexture:(Texture *)texture atLocation:(NSInteger)glPosition forName:(NSString *)varName
{
    glActiveTexture(glPosition);
    GLuint textureName = texture.textureInfo.name;
    glBindTexture(texture.textureInfo.target, textureName);
    [self set:varName toInt:glPosition - GL_TEXTURE0];
}

- (void)dealloc
{
    [self destroy];
}


- (void)prepareToDraw
{
    [self use];
}

#pragma mark - Public methods
- (void)bindAttribLocation:(GLuint) location name:(NSString *)name
{
    glBindAttribLocation(self.handle, location, [name UTF8String]);
}

- (void)bindUniformName:(NSString *)name
{
    GLint location = glGetUniformLocation(self.handle, [name UTF8String]);
    if (location >= 0) {
        [self.uniforms setObject:[NSNumber numberWithInt:location] forKey:name];
    }
}

- (void)set:(NSString *)uniformName toInt:(int)intValue
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniform1i(location, intValue);
    }
}

- (void)set:(NSString *)uniformName toFloat:(float)floatValue
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniform1f(location, floatValue);
    }
}

- (void)set:(NSString *)uniformName toGLKMatrix3:(GLKMatrix3)matrix3
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniformMatrix3fv(location, 1, 0, matrix3.m);
    }
}

- (void)set:(NSString *)uniformName toGLKMatrix4:(GLKMatrix4)matrix4
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniformMatrix4fv(location, 1, 0, matrix4.m);
    }
}

- (void)set:(NSString *)uniformName toGLKVector2:(GLKVector2)vector2
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniform2f(location, vector2.x, vector2.y);
    }
}

- (void)set:(NSString *)uniformName toGLKVector3:(GLKVector3)vector3
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniform3f(location, vector3.x, vector3.y, vector3.z);
    }
}

- (void)set:(NSString *)uniformName toGLKVector4:(GLKVector4)vector4
{
    GLint location = [self locForName:uniformName];
    if (location >= 0) {
        glUniform4f(location, vector4.x, vector4.y, vector4.z, vector4.w);
    }
}

- (GLint)locForName:(NSString *)name
{
    return [[self.uniforms objectForKey:name] intValue];
}

- (BOOL)create
{
    self.handle = glCreateProgram();
    return self.handle > 0;
}

- (BOOL)link
{
    if (self.isLinked) {
        return YES;
    }
    if (self.handle <= 0) {
        return NO;
    }
    GLint status;
    glLinkProgram(self.handle);
    

    glGetProgramiv(self.handle, GL_LINK_STATUS, &status);
    if (status == 0) {
        [self retrieveProgramLog];
        return NO;
    }
    self.isLinked = YES;
    return YES;

}

- (void)use
{
    if( self.handle <= 0 || (! self.isLinked) ) return;
    glUseProgram( self.handle );
}

- (void)destroy
{
    if (self.handle > 0) {
        glDeleteProgram(self.handle);
        self.handle = 0;
        self.isLinked = NO;
    }
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint status;
    
    glValidateProgram(prog);
    [self retrieveProgramLog];    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Private methods
- (void)compileShaderFromFile:(NSString *)fileName type:(GLSLShaderType)type
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *source = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (!source) {
        NSLog(@"Failed to load vertex shader %@", fileName);
        [self exit];
    }
    [self compileShaderFromString:source type:type];
    
}
- (void)compileShaderFromString:(NSString *)srcString type:(GLSLShaderType)type
{
    GLenum glType = -1;
    switch (type) {
        case VERTEX:
            glType = GL_VERTEX_SHADER;
            break;
        case FRAGMENT:
            glType = GL_FRAGMENT_SHADER;
        default:
            break;
    }
    GLuint shaderHandle = glCreateShader(glType);
    const GLchar * csrc = (const GLchar*)[srcString UTF8String];
    glShaderSource(shaderHandle, 1, &csrc, NULL);
    glCompileShader(shaderHandle);
    GLint status = 0;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        [self retrieveShaderLog:shaderHandle];
        glDeleteShader(shaderHandle);
        [self exit];
    }
    glAttachShader(self.handle, shaderHandle);
}

- (void)exit
{
    NSLog(@"%@", self.log);
    abort();
}
- (void)retrieveProgramLog
{
    GLint logLength;
    glGetProgramiv(self.handle, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *clog = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(self.handle, logLength, &logLength, clog);
        self.log = [NSString stringWithUTF8String:clog];
        free(clog);
    }    
}

- (void)retrieveShaderLog:(GLuint)shaderHandle
{
    GLint logLength;
    glGetShaderiv(shaderHandle, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *clog = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(shaderHandle, logLength, &logLength, clog);
        self.log = [NSString stringWithUTF8String:clog];
        free(clog);
    }
}

@end
