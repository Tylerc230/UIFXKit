//
//  Model3D.h
//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLKit/GLKit.h"
#import "VertexBuffer.h"
@interface Model3D : NSObject
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic, assign) GLKVector3 anchorPoint;
@property (nonatomic, assign) GLKVector3 size;
@property (nonatomic, assign) GLKVector3 scale;
@property (nonatomic, assign) GLKVector3 rotation;
@property (nonatomic, strong) NSMutableData *indicies;
@property (nonatomic, strong) NSMutableArray *subObjects;
@property (nonatomic, assign) BOOL twoSided;

- (void)generateVertices:(VertexBuffer *)vertexBuffer;
- (void)updateVerticies:(VertexBuffer *)vertexBuffer;
- (unsigned int)indexCount;
- (unsigned int)indexByteSize;
- (VertexBufferIndex *)indexData;
- (void)addSubObject:(Model3D *)object;
- (void)addIndex:(VertexBufferIndex)index;
@end
