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
typedef GLushort VertexBufferIndex;

@interface VertexBuffer : NSObject
@property (nonatomic, readonly) unsigned int vertexCount;
@property (nonatomic, readonly) float *vertexFloatArray;
@property (nonatomic, readonly) unsigned int vertexBufferSize;

- (VertexBufferIndex)addVerticies:(Vertex *)vertexArray count:(unsigned int)numVertices;
- (Vertex *)vertexDataForCurrentObject;
- (void)objectCreationBegin;
- (void)objectCreationEnd;
- (void)objectUpdateEnd;
- (void)objectUpdateBegin;
- (void)resetUpdateCount;


@end
