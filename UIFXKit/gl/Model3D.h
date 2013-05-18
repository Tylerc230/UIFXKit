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
//Objects vertices + subobjects verts
@property (nonatomic, readonly) NSUInteger totalVertexCount;
@property (nonatomic, readonly) NSUInteger numVerticies;
@property (nonatomic, assign) BOOL twoSided;

- (id)initWithSize:(GLKVector3)size;
- (void)updateVerticies:(Vertex *)vertexBuffer;
- (void)genIndicies:(NSUInteger)startInx;
- (unsigned int)indexCount;
- (unsigned int)indexByteSize;
- (VertexBufferIndex *)indexData;
- (void)addSubObject:(Model3D *)object;
- (void)addIndex:(VertexBufferIndex)index;
@end
