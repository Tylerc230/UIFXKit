//
//  WorldScene.h
//
//  Created by Tyler Casselman
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Model3D.h"
@interface SceneGraph : NSObject
@property (nonatomic, strong) NSMutableArray *objects;
- (void)clearWorldObjects;
- (void)updateWorld;
- (void)addWorldObject:(Model3D *)object;
- (void)generateBuffers;
- (unsigned int)vertexBufferSize;
- (float *)vertexData;
@end
