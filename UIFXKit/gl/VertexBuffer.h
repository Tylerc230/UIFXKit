//
//  VertexBuffer.h
//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
typedef struct {
    GLKVector3 position;
    GLKVector3 normal;
    GLKVector2 textureCoords;
}Vertex;
#define CREATE_VERT(pos, norm, uv) (Vertex){pos, norm, uv}
typedef GLushort VertexBufferIndex;

@interface VertexBuffer : NSObject
@property (nonatomic, readonly) unsigned int vertexCount;
@property (nonatomic, readonly) float *vertexFloatArray;
@property (nonatomic, readonly) Vertex *vertexArray;
@property (nonatomic, readonly) unsigned int vertexBufferSize;

- (VertexBufferIndex)addNumVerticies:(unsigned int)numVertices;

@end
