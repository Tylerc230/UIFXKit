//
//  UIGLBaseEffect.h
//  UIGLKit
//
//  Created by Tyler Casselman on 11/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "UIFXShader.h"
@interface UIFXBaseEffect : NSObject
@property (nonatomic, strong) UIFXShader *shader;
- (void)setSnapshot:(UIImage *)snapshot;

@end
