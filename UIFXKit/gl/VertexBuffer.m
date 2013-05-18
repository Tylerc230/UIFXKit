//
//  VertexBuffer.m
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "VertexBuffer.h"
@interface VertexBuffer ()
@property (nonatomic, strong) NSMutableData *vertexData;
@end

@implementation VertexBuffer
- (id)init
{
    self = [super init];
    if (self) {
        self.vertexData = [NSMutableData dataWithCapacity:10000];
    }
    return self;
}

- (VertexBufferIndex)addNumVerticies:(unsigned int)numVertices{
    int indexCount = self.vertexCount;
    [self.vertexData increaseLengthBy:numVertices * sizeof(Vertex)];
    return indexCount + 1;
}

- (float *)vertexFloatArray
{
    return (float *)self.vertexData.bytes;
}

- (Vertex *)vertexArray
{
    return (Vertex *)self.vertexData.bytes;
}

- (unsigned int)vertexBufferSize
{
    return self.vertexData.length;
}

- (unsigned int)vertexCount
{
    return self.vertexData.length /sizeof(Vertex);
}

@end
