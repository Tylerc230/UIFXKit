//
//  UVMap.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "UVMap.h"

@implementation UVMap
+ (UVMap *)defaultUVMap
{
    return [[UVMap alloc] initWithU0:0.f u1:1.f v0:1.f v1:0.f];//we go from 1 - 0 in the v direction to flip the image
}

- (id)initWithU0:(float)u0 u1:(float)u1 v0:(float)v0 v1:(float)v1
{
    self = [super init];
    if (self) {
        self.u0 = u0;
        self.u1 = u1;
        self.v0 = v0;
        self.v1 = v1;
    }
    return self;
}

- (float)dU
{
    return self.u1 - self.u0;
}

- (float)dV
{
    return self.v1 - self.v0;
}

- (UVMap *)invertV
{
    UVMap *invert = [self copy];
    float temp0 = invert.v0;
    invert.v0 = invert.v1;
    invert.v1 = temp0;
    return invert;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[UVMap alloc] initWithU0:self.u0 u1:self.u1 v0:self.v0 v1:self.v1];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"u0 %f u1 %f v0 %f v1 %f", self.u0, self.u1, self.v0, self.v1];
}
@end
