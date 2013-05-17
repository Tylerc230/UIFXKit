//
//  ObjectGraph.m
//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "SceneGraph.h"
#import "VertexBuffer.h"
@interface SceneGraph ()
@property (nonatomic, strong) VertexBuffer *vertexBuffer;
@end

@implementation SceneGraph
- (id)init
{
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray arrayWithCapacity:15];
    }
    return self;
}

- (void)addWorldObject:(Model3D *)object
{
    [self.objects addObject:object];
}

- (void)clearWorldObjects
{
    [self.objects removeAllObjects];
}
//If we are animating the individual verticies of an object, this is where that happens
- (void)updateWorld
{
    
    for (Model3D *object in self.objects) {
        [object updateVerticies:self.vertexBuffer];
    }
    [self.vertexBuffer resetUpdateCount];
}

- (void)generateBuffers
{
    self.vertexBuffer = [[VertexBuffer alloc] init];
    for (Model3D *object in self.objects) {
        [object generateVertices:self.vertexBuffer];
    }
}

- (unsigned int)vertexBufferSize
{
    return self.vertexBuffer.vertexBufferSize;
}

- (float *)vertexData
{
    return self.vertexBuffer.vertexFloatArray;
}


@end
