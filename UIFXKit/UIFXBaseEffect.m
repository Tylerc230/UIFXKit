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
#define kCameraAngleDeg 10.f
#define kScreenSize [UIFXWindow keyWindow].screen.bounds.size

@interface UIFXBaseEffect ()
@property (nonatomic, strong) id<GLKNamedEffect> shader;
@property (nonatomic, strong) SceneGraph *graph;
@property (nonatomic, assign) GLKMatrixStackRef matrixStack;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, strong) Texture *currentTexture;
@property (nonatomic, assign) GLuint indexBuffer;
@property (nonatomic, assign) GLuint vertexBuffer;
@end

@implementation UIFXBaseEffect
- (id)initWithShader:(id<GLKNamedEffect>)shader;
{
    self = [super init];
    if (self) {
        self.shader = shader;
        self.graph = [SceneGraph new];
        float screenHeigh = kScreenSize.height;
        float cameraZ = -(screenHeigh/2)/tan(GLKMathDegreesToRadians(kCameraAngleDeg)/2);
        self.matrixStack = GLKMatrixStackCreate(NULL);
        GLKMatrixStackTranslate(self.matrixStack, 0.f, 0.f, cameraZ);
        GLKMatrixStackPush(self.matrixStack);
        [self createBuffers];

    }
    return self;
}

- (void)setSnapshot:(UIImage *)snapshot
{
    self.currentTexture = [[Texture alloc] initWithImage:snapshot size:kScreenSize];
}

- (void)render
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBuffer);
    
    float stride = sizeof(Vertex);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, position));
    
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, normal));
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, stride, (GLvoid *)offsetof(Vertex, textureCoords));
    self.projectionMatrix = [self projectionMatrix];
    [self.shader prepareToDraw];
    GLKMatrixStackPush(self.matrixStack);
    for (Model3D *object in self.graph.objects) {
        [self drawObject:object];

    }
    GLKMatrixStackPop(self.matrixStack);
}

- (void)drawObject:(Model3D *)object
{
    GLKMatrixStackPush(self.matrixStack);
    GLKMatrixStackTranslateWithVector3(self.matrixStack, object.anchorPoint);
    GLKMatrixStackTranslateWithVector3(self.matrixStack, object.position);
    GLKMatrixStackScaleWithVector3(self.matrixStack, object.scale);
    GLKMatrixStackRotateZ(self.matrixStack, object.rotation.z);
    GLKMatrixStackRotateX(self.matrixStack, object.rotation.x);
    GLKMatrixStackRotateY(self.matrixStack, object.rotation.y);
    GLKMatrixStackTranslateWithVector3(self.matrixStack, GLKVector3Negate(object.anchorPoint));
    self.modelViewMatrix = GLKMatrixStackGetMatrix4(self.matrixStack);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, object.indexByteSize, object.indexData, GL_STATIC_DRAW);
    glDrawElements(GL_TRIANGLES, object.indexCount, GL_UNSIGNED_SHORT, 0);
    
    
    for (Model3D *subObject in object.subObjects) {
        [self drawObject:subObject];
    }
    GLKMatrixStackPop(self.matrixStack);
    
}

- (void)createBuffers
{
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LEQUAL);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    

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
    float aspect = fabsf(kScreenSize.width/kScreenSize.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(kCameraAngleDeg), aspect, 100.0f, 10000.f);
    return projectionMatrix;
}


@end
