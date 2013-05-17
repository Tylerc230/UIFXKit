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
@property (nonatomic, strong) Texture *currentTexture;
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

    }
    return self;
}

- (void)setSnapshot:(UIImage *)snapshot
{
    self.currentTexture = [[Texture alloc] initWithImage:snapshot size:kScreenSize];
}

- (void)render
{
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
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, object.indexByteSize, object.indexData, GL_STATIC_DRAW);
    glDrawElements(GL_TRIANGLES, object.indexCount, GL_UNSIGNED_SHORT, 0);
    
    
    for (Model3D *subObject in object.subObjects) {
        [self drawObject:subObject];
    }
    GLKMatrixStackPop(self.matrixStack);
    
}

@end
