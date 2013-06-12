//
//  StripPlane.h
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "Model3D.h"

@interface HorzStripPlane : Model3D
@property (nonatomic, strong) Texture *frontTexture;
@property (nonatomic, strong) Texture *backTexture;
- (id)initWithWidth:(float)width height:(float)height numStrips:(int)numStrips;
@end
