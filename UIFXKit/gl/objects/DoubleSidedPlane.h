//
//  DoubleSidedPlane.h
//  UIFXKit
//
//  Created by Tyler Casselman on 6/12/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "Model3D.h"

@interface DoubleSidedPlane : Model3D
@property (nonatomic, strong) Texture *frontTexture;
@property (nonatomic, strong) Texture *backTexture;
- (id)initWithWidth:(float)width height:(float)height nx:(int)nx ny:(int)ny;

@end
