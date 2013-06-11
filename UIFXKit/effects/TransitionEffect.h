//
//  TransitionEffect.h
//  UIFXKit
//
//  Created by Tyler Casselman on 5/16/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "UIFXBaseEffect.h"

@interface TransitionEffect : UIFXBaseEffect
@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) float elapseTime;
- (void)update:(CFTimeInterval)duration;
@end
