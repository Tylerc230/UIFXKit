//
//  UIGLBaseEffect.m
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "UIFXBaseEffect.h"
#import "UIFXWindow.h"
#import "Texture.h"

#define kCameraAngleDeg 65.f



@interface UIFXBaseEffect ()
@property (nonatomic, strong) Shader *shader;
@property (nonatomic, strong) SceneGraph *graph;
@property (nonatomic, assign) GLKMatrixStackRef matrixStack;
@property (nonatomic, assign) GLuint indexBuffer;
@property (nonatomic, assign) GLuint vertexBuffer;
@end

@implementation UIFXBaseEffect
- (id)initWithShader:(Shader *)shader
{
    self = [super init];
    if (self) {
        self.shader = shader;
        self.graph = [SceneGraph new];
        [self setupGLState];
    }
    return self;
}

- (void)setSourceSnapshot:(UIImage *)snapshot
{
    self.sourceScreenshotTexture = [[Texture alloc] initWithImage:snapshot size:self.glViewSize];
}

- (void)setDestSnapshot:(UIImage *)snapshot
{
    self.destScreenshotTexture = [[Texture alloc] initWithImage:snapshot size:self.glViewSize];
}

- (void)preRenderSetup
{
    self.matrixStack = GLKMatrixStackCreate(NULL);
    [self positionCamera];
    [self.shader prepareToDraw];
    
    self.shader.projectionMatrix = self.projectionMatrix;
    self.shader.viewMatrix = GLKMatrixStackGetMatrix4(self.matrixStack);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBuffer);
    
    float stride = sizeof(Vertex);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, position));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, normal));
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, textureCoords));
}

- (void)render:(CFTimeInterval)duration
{
    [self preRenderSetup];
    for (Model3D *object in self.graph.objects)
    {
        [self drawObject:object];
    }
    int error = glGetError();
    NSAssert(error == 0, @"GL Error %d", error);
}

- (void)updateStateWithModel:(Model3D*)model
{
    GLKMatrixStackTranslateWithVector3(self.matrixStack, model.anchorPoint);
    GLKMatrixStackTranslateWithVector3(self.matrixStack, model.position);
    GLKMatrixStackScaleWithVector3(self.matrixStack, model.scale);
    GLKMatrixStackRotateZ(self.matrixStack, model.rotation.z);
    GLKMatrixStackRotateX(self.matrixStack, model.rotation.x);
    GLKMatrixStackRotateY(self.matrixStack, model.rotation.y);
    GLKMatrixStackTranslateWithVector3(self.matrixStack, GLKVector3Negate(model.anchorPoint));
    self.shader.modelViewMatrix = GLKMatrixStackGetMatrix4(self.matrixStack);
}

- (void)drawObject:(Model3D *)object
{
    GLKMatrixStackPush(self.matrixStack);
    [self updateStateWithModel:object];
    [self.shader prepareToDraw];//This might be slowing down CustomShaders
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, object.indexByteSize, object.indexData, GL_STATIC_DRAW);
    glDrawElements(GL_TRIANGLES, object.indexCount, GL_UNSIGNED_SHORT, 0);
    
    for (Model3D *subObject in object.subObjects) {
        [self drawObject:subObject];
    }
    GLKMatrixStackPop(self.matrixStack);
}

- (void)setupGLState
{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    GLuint bufferName;
    glGenBuffers(1, &bufferName);
    self.indexBuffer = bufferName;
    glGenBuffers(1, &bufferName);
    self.vertexBuffer = bufferName;
}

- (void)updateVertexBuffer
{
    [self.graph generateBuffers];
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, self.graph.vertexBufferSize, self.graph.vertexData, GL_STREAM_DRAW);
}

- (GLKMatrix4)projectionMatrix
{
    float aspect = fabsf(self.glViewSize.x/self.glViewSize.y);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(kCameraAngleDeg), aspect, 100.0f, 10000.f);
    return projectionMatrix;
}

- (void)positionCamera
{
    float screenHeight = self.glViewSize.y;
    float cameraZ = -(screenHeight/2)/tan(GLKMathDegreesToRadians(kCameraAngleDeg)/2);
    GLKMatrixStackTranslate(self.matrixStack, -self.sourceViewSize.x/2.f, self.sourceViewSize.y/2.f, cameraZ);
    GLKMatrixStackRotate(self.matrixStack, M_PI, 1.f, 0.f, 0.f);
}


@end
