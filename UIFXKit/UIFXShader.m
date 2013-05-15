//
//  GLSLProgram.m
//  ShaderTutorials
//
//  Created by Tyler Casselman on 7/24/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "UIFXShader.h"

@interface UIFXShader ()
@property (nonatomic, assign) int handle;
@property (nonatomic, assign) BOOL isLinked;
@property (nonatomic, strong, readwrite) NSString *log;
@property (nonatomic, strong) NSMutableDictionary *uniforms;
@property (nonatomic, strong) NSMutableDictionary *textures;
@end

@implementation UIFXShader
@synthesize handle;
@synthesize isLinked;
@synthesize log;
@synthesize uniforms;

- (id)init
{
    self = [super init];
    if (self) {
        self.uniforms = [NSMutableDictionary dictionaryWithCapacity:10];
        self.textures = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

- (void)useTexture:(NSString *)file
{
    if ([self.textures objectForKey:file] == nil)
    {
        [self loadTexture:file];
    }
    glActiveTexture(GL_TEXTURE0);
    GLuint textureName = [[self.textures objectForKey:file] intValue];
    glBindTexture(GL_TEXTURE_2D, textureName);
    int loc = glGetUniformLocation(self.handle, "Tex1");
    glUniform1i(loc, 0);
}

- (void)loadTexture:(NSString *)file
{
    UIImage *image = [UIImage imageNamed:file];
    if (image == nil)
        NSLog(@"Do real error checking here");
    
    GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
    CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( context, 0, height - height );
    CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
    

    GLuint textureName;
    glGenTextures(1, &textureName);
    [self.textures setObject:[NSNumber numberWithInt:textureName] forKey:file];
    glBindTexture(GL_TEXTURE_2D, textureName);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    CGContextRelease(context);
    
    free(imageData);
}

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

- (void)bindAttribLocation:(GLuint) location name:(NSString *)name
{
    glBindAttribLocation(handle, location, [name UTF8String]);
}

- (void)bindUniformName:(NSString *)name
{
    GLint location = glGetUniformLocation(self.handle, [name UTF8String]);
    [self.uniforms setObject:[NSNumber numberWithInt:location] forKey:name];
}

- (void)set:(NSString *)uniformName toFloat:(float)floatValue
{
    GLint location = [self locForName:uniformName];
    glUniform1f(location, floatValue);
}

- (void)set:(NSString *)uniformName toGLKMatrix3:(GLKMatrix3)matrix3
{
    GLint location = [self locForName:uniformName];
    glUniformMatrix3fv(location, 1, 0, matrix3.m);
}

- (void)set:(NSString *)uniformName toGLKMatrix4:(GLKMatrix4)matrix4
{
    GLint location = [self locForName:uniformName];
    glUniformMatrix4fv(location, 1, 0, matrix4.m);
}

- (void)set:(NSString *)uniformName toGLKVector2:(GLKVector2)vector2
{
    GLint location = [self locForName:uniformName];
    glUniform2f(location, vector2.x, vector2.y);
}

- (void)set:(NSString *)uniformName toGLKVector3:(GLKVector3)vector3
{
    GLint location = [self locForName:uniformName];
    glUniform3f(location, vector3.x, vector3.y, vector3.z);
}

- (void)set:(NSString *)uniformName toGLKVector4:(GLKVector4)vector4
{
    GLint location = [self locForName:uniformName];
    glUniform4f(location, vector4.x, vector4.y, vector4.z, vector4.w);
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
    glUseProgram( handle );
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
