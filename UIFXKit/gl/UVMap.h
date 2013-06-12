//
//  UVMap.h
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVMap : NSObject
@property (nonatomic, assign) float u0;
@property (nonatomic, assign) float u1;
@property (nonatomic, assign) float v0;
@property (nonatomic, assign) float v1;
@property (nonatomic, readonly) float dV;
@property (nonatomic, readonly) float dU;
+ (UVMap *)defaultUVMap;
- (id)initWithU0:(float)u0 u1:(float)u1 v0:(float)v0 v1:(float)v1;
@end
