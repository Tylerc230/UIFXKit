//
//  Model3D.h
//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "Model3D.h"
@interface Model3D ()

@end

GLKVector2 rotate2DVector(float radians, GLKVector2 vector);
@implementation Model3D

- (id)init
{
    self = [super init];
    if (self) {
        self.subObjects = [NSMutableArray arrayWithCapacity:5];
        self.scale = GLKVector3Make(1.f, 1.f, 1.f);
        self.indicies = [NSMutableData dataWithCapacity:100];
    }
    return self;
}

- (void)generateVertices:(VertexBuffer *)vertexBuffer
{
    for (Model3D *subObject in self.subObjects) {
        [subObject generateVertices:vertexBuffer];
    }
}

- (void)updateVerticies:(VertexBuffer *)vertexBuffer
{
    for (Model3D *subObject in self.subObjects) {
        [subObject updateVerticies:vertexBuffer];
    }
}
- (void)addIndex:(VertexBufferIndex)index
{
    [self.indicies appendBytes:&index length:sizeof(VertexBufferIndex)];
}

- (unsigned int)indexCount
{
    return self.indicies.length/sizeof(VertexBufferIndex); 
}

- (unsigned int)indexByteSize
{
    return self.indicies.length;
}

- (VertexBufferIndex *)indexData
{
    return (VertexBufferIndex *) self.indicies.bytes;
}

- (void)addSubObject:(Model3D *)object
{
    [self.subObjects addObject:object];
}

@end