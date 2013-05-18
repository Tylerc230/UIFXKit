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

- (id)initWithSize:(GLKVector3)size
{
    self = [super init];
    if (self) {
        self.subObjects = [NSMutableArray arrayWithCapacity:5];
        self.scale = GLKVector3Make(1.f, 1.f, 1.f);
        self.indicies = [NSMutableData dataWithCapacity:100];
        self.size = size;
    }
    return self;
}

- (void)updateVerticies:(Vertex *)vertexBuffer
{
    Vertex * currentVertex = vertexBuffer + self.numVerticies;
    for (Model3D *subObject in self.subObjects) {
        [subObject updateVerticies:currentVertex];
        currentVertex += subObject.totalVertexCount;
    }
}

- (void)genIndicies:(NSUInteger)startInx
{
    NSUInteger currentIndex = startInx + self.numVerticies;
    for (Model3D *subObject in self.subObjects) {
        [subObject genIndicies:currentIndex];
        currentIndex += subObject.totalVertexCount;
    }
}

- (NSUInteger)numVerticies
{
    return 0;
}

- (NSUInteger)totalVertexCount
{
    NSUInteger numVerts = 0;
    for (Model3D *model in self.subObjects) {
        numVerts += model.totalVertexCount;
    }
    return self.numVerticies + numVerts;
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