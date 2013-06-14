//
//  Constants.h
//  UIFXKit
//
//  Created by Tyler Casselman on 5/18/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#ifndef UIFXKit_Constants_h
#define UIFXKit_Constants_h
#define kWhiteColor GLKVector4Make(1.f, 1.f, 1.f, 1.f);
#define kLightGrayColor GLKVector4Make(.5f, .5f, .5f, 1.f);
#define kClearColor GLKVector4Make(0.f, 0.f, 0.f, 0.f);
#define kScreenSize [UIScreen mainScreen].bounds.size
#define CGToGLKPoint(cgPoint) GLKVector2Make(cgPoint.width, cgPoint.height)
#endif
